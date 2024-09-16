import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/src/core/utils/data_mapper.dart';
import 'package:news_app/src/domain/entity/news_images.dart';

part 'news_images_response.g.dart';

@JsonSerializable()
class NewsImagesResponse extends DataMapper<NewsImages> {
  final String thumbnail;
  final String thumbnailProxied;

  NewsImagesResponse({required this.thumbnail, required this.thumbnailProxied});

  factory NewsImagesResponse.fromJson(Map<String, dynamic> json) => _$NewsImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsImagesResponseToJson(this);

  @override
  NewsImages toEntity() {
    return NewsImages(
      thumbnail: thumbnail,
      thumbnailProxied: thumbnailProxied,
    );
  }
}
