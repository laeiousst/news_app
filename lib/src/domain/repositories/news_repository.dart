import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/entity/news_topic.dart';

abstract class NewsRepository {
  Stream<List<News>> getNewsList(NewsTopic topic);

  Future<List<News>> getSavedNewsList();

  Future<void> saveNews(News news);
}
