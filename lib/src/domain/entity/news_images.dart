import 'package:equatable/equatable.dart';

class NewsImages extends Equatable {
  final String thumbnail;
  final String thumbnailProxied;

  const NewsImages({
    required this.thumbnail,
    required this.thumbnailProxied,
  });

  @override
  List<Object> get props => [
        thumbnail,
        thumbnailProxied,
      ];
}
