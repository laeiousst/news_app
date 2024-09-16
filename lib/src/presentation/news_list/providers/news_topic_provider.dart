import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/domain/entity/news_topic.dart';

final newsTopicStateProvider = StateProvider<NewsTopic>((ref) {
  return NewsTopic.latest;
});
