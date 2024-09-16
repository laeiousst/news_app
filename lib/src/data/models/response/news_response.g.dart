// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      title: json['title'] as String,
      snippet: json['snippet'] as String,
      timestamp: json['timestamp'] as String,
      newsUrl: json['newsUrl'] as String,
      images: json['images'] == null
          ? null
          : NewsImagesResponse.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'snippet': instance.snippet,
      'timestamp': instance.timestamp,
      'newsUrl': instance.newsUrl,
      'images': instance.images,
    };
