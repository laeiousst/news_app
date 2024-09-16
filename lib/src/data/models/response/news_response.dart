import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/src/core/utils/data_mapper.dart';
import 'package:news_app/src/data/models/response/news_images_response.dart';
import 'package:news_app/src/domain/entity/news.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse extends DataMapper<News> {
  final String title;
  final String snippet;
  final String timestamp;
  final String newsUrl;
  final NewsImagesResponse? images;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);

  NewsResponse({
    required this.title,
    required this.snippet,
    required this.timestamp,
    required this.newsUrl,
    this.images,
  });

  @override
  News toEntity() {
    return News(
      title: title,
      snippet: snippet,
      timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)),
      newsUrl: newsUrl,
      images: images?.toEntity(),
    );
  }
}

extension NewsResponseX on News {
  NewsResponse get toResponse => NewsResponse(
        title: title,
        newsUrl: newsUrl,
        snippet: snippet,
        timestamp: timestamp.millisecondsSinceEpoch.toString(),
        images: NewsImagesResponse(
          thumbnail: images?.thumbnail ?? '',
          thumbnailProxied: images?.thumbnail ?? '',
        ),
      );
}
