import 'package:equatable/equatable.dart';
import 'package:news_app/src/domain/entity/news_images.dart';

class News extends Equatable {
  final String title;
  final String snippet;
  final DateTime timestamp;
  final String newsUrl;
  final NewsImages? images;

  const News({
    required this.title,
    required this.snippet,
    required this.timestamp,
    required this.newsUrl,
    required this.images,
  });

  @override
  List<Object?> get props {
    return [
      title,
      snippet,
      timestamp,
      newsUrl,
      images,
    ];
  }
}
