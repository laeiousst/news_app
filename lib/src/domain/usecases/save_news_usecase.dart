import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/data/repositories/news_repository_impl.dart';
import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/repositories/news_repository.dart';
import 'package:news_app/src/presentation/saved_news/providers/saved_news_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_news_usecase.g.dart';

class SaveNewsUseCase {
  final NewsRepository repository;
  final Ref ref;

  SaveNewsUseCase({required this.repository, required this.ref});

  Future<void> execute(News news) async {
    await repository.saveNews(news);
    return ref.refresh(savedNewsListProvider);
  }
}

@riverpod
SaveNewsUseCase saveNewsUseCase(Ref ref) {
  final newsRepository = ref.read(newsRepositoryProvider);

  return SaveNewsUseCase(repository: newsRepository, ref: ref);
}
