import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/data/repositories/news_repository_impl.dart';
import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/entity/news_topic.dart';
import 'package:news_app/src/domain/repositories/news_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_news_list_usecase.g.dart';

class GetNewsListUseCase {
  final NewsRepository repository;

  GetNewsListUseCase({required this.repository});

  Stream<List<News>> execute(NewsTopic topic) async* {
    yield* repository.getNewsList(topic).handleError((e) {
      throw e;
    });
  }
}

@riverpod
GetNewsListUseCase getNewsListUseCase(Ref ref) {
  final newsRepository = ref.read(newsRepositoryProvider);

  return GetNewsListUseCase(repository: newsRepository);
}
