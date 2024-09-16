import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/data/repositories/news_repository_impl.dart';
import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/repositories/news_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_saved_news_list_usecase.g.dart';

class GetSavedNewsListUseCase {
  final NewsRepository repository;

  GetSavedNewsListUseCase({required this.repository});

  Future<List<News>> execute() async {
    return await repository.getSavedNewsList();
  }
}

@riverpod
GetSavedNewsListUseCase getSavedNewsListUseCase(Ref ref) {
  final newsRepository = ref.read(newsRepositoryProvider);

  return GetSavedNewsListUseCase(repository: newsRepository);
}
