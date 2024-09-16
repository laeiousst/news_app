import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/usecases/get_news_list_usecase.dart';
import 'package:news_app/src/presentation/news_list/providers/news_topic_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_list_provider.g.dart';

@riverpod
Stream<List<News>> newsList(NewsListRef ref) async* {
  final getNewsListUseCase = ref.read(getNewsListUseCaseProvider);
  final newsTopic = ref.watch(newsTopicStateProvider);

  yield* getNewsListUseCase.execute(newsTopic).handleError((e, st) {
    throw e;
  });
}
