import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/usecases/get_saved_news_list_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_news_list_provider.g.dart';

@riverpod
Future<List<News>> savedNewsList(SavedNewsListRef ref) {
  final getNewsListUseCase = ref.read(getSavedNewsListUseCaseProvider);
  return getNewsListUseCase.execute();
}
