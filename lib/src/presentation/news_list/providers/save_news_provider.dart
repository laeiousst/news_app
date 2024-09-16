import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/usecases/save_news_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_news_provider.g.dart';

@riverpod
Future<void> saveNews(SaveNewsRef ref, News news) {
  final getNewsListUseCase = ref.read(saveNewsUseCaseProvider);
  return getNewsListUseCase.execute(news);
}
