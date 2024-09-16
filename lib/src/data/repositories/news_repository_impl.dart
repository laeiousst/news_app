import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/exceptions/exceptions.dart';
import 'package:news_app/src/core/utils/logger.dart';
import 'package:news_app/src/data/datasources/news_local_datasource.dart';
import 'package:news_app/src/data/datasources/news_remote_datasource.dart';
import 'package:news_app/src/data/models/response/news_response.dart';
import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/entity/news_topic.dart';
import 'package:news_app/src/domain/repositories/news_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_repository_impl.g.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsLocalDataSource newsLocalDataSource;
  final NewsRemoteDataSource newsRemoteDataSource;

  NewsRepositoryImpl({
    required this.newsLocalDataSource,
    required this.newsRemoteDataSource,
  });

  @override
  Stream<List<News>> getNewsList(NewsTopic topic) async* {
    try {
      final cacheNewsCMList = await newsLocalDataSource.getCacheNewsList(topic.name);
      if (cacheNewsCMList.isNotEmpty) {
        final cacheNewsList = cacheNewsCMList.map((e) => e.toEntity()).toList();
        yield cacheNewsList;
      }

      final freshNewList = await newsRemoteDataSource.getNewsList(topic.name);
      final newsList = freshNewList.map((e) => e.toEntity()).toList();
      yield newsList;
      final cacheList = newsList.map((e) => e.toResponse).toList();
      await newsLocalDataSource.updateCacheNewsList(topic.name, cacheList);
    } catch (error, st) {
      logger.e(error, stackTrace: st);
      if (error is DioException) {
        logger.d(error);
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 429:
            throw LimitReachedException();
          default:
            throw UnknownException();
        }
      }
    }
  }

  @override
  Future<List<News>> getSavedNewsList() async {
    final newsList = await newsLocalDataSource.getSavedNewsList();
    return newsList.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveNews(News news) async {
    return newsLocalDataSource.saveNews(news.toResponse);
  }
}

@Riverpod(keepAlive: true)
NewsRepository newsRepository(Ref ref) {
  final newsLocalDataSource = ref.read(newsLocalDataSourceProvider);
  final newsRemoteDataSource = ref.read(newsRemoteDataSourceProvider);

  return NewsRepositoryImpl(
    newsLocalDataSource: newsLocalDataSource,
    newsRemoteDataSource: newsRemoteDataSource,
  );
}
