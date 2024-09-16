import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ViewMode { page, list }

final viewModeStateProvider = StateProvider<ViewMode>((ref) {
  return ViewMode.list;
});
