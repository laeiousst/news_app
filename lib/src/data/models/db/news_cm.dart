import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/src/core/utils/data_mapper.dart';
import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/domain/entity/news_images.dart';

part 'news_cm.g.dart';

@HiveType(typeId: 0)
class NewsCM extends DataMapper<News> {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String snippet;
  @HiveField(2)
  final String timestamp;
  @HiveField(3)
  final String newsUrl;
  @HiveField(4)
  final String thumbnail;
  @HiveField(5)
  final String thumbnailProxied;

  NewsCM({
    required this.title,
    required this.snippet,
    required this.timestamp,
    required this.newsUrl,
    required this.thumbnail,
    required this.thumbnailProxied,
  });

  @override
  News toEntity() {
    final timestampDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return News(
      title: title,
      snippet: snippet,
      timestamp: timestampDateTime,
      newsUrl: newsUrl,
      images: NewsImages(thumbnail: thumbnail, thumbnailProxied: thumbnailProxied),
    );
  }
}

extension NewsMapper on News {
  NewsCM get toCM => NewsCM(
        title: title,
        snippet: snippet,
        timestamp: timestamp.millisecondsSinceEpoch.toString(),
        newsUrl: newsUrl,
        thumbnail: images?.thumbnail ?? '',
        thumbnailProxied: images?.thumbnailProxied ?? '',
      );
}
