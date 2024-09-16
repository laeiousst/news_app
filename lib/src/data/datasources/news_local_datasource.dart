import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/utils/logger.dart';
import 'package:news_app/src/data/models/response/news_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'news_local_datasource.g.dart';

abstract class NewsLocalDataSource {
  Future<void> updateCacheNewsList(String topic, List<NewsResponse> newsList);

  Future<List<NewsResponse>> getCacheNewsList(String topic);

  Future<List<NewsResponse>> getSavedNewsList();

  Future<void> saveNews(NewsResponse news);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  static const _savedKey = 'saved-key';
  static const _cacheKey = 'cached-key';

  String cacheKeyWithTopic(String topic) => '${_cacheKey}_$topic';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  NewsLocalDataSourceImpl();

  @override
  Future<List<NewsResponse>> getSavedNewsList() async {
    try {
      final items = await _prefs.getString(_savedKey);
      if (items == null) return [];
      final json = jsonDecode(items) as Map<String, dynamic>;
      return (json['data'] as Iterable).map((e) => NewsResponse.fromJson(e)).toList();
    } catch (e, st) {
      logger.e(e, stackTrace: st);
      return [];
    }
  }

  @override
  Future<void> saveNews(NewsResponse news) async {
    try {
      final oldItems = await getSavedNewsList();
      final hasNews = oldItems.indexWhere((e) => e.timestamp == news.timestamp);
      List<NewsResponse> newItems;
      if (hasNews != -1) {
        oldItems.removeAt(hasNews);
        newItems = [...oldItems];
      } else {
        newItems = [...oldItems, news];
      }
      final String json = jsonEncode({'data': newItems});
      await _prefs.setString(_savedKey, json);
    } catch (e, st) {
      logger.e(e, stackTrace: st);
    }
  }

  @override
  Future<List<NewsResponse>> getCacheNewsList(String topic) async {
    try {
      final items = await _prefs.getString(cacheKeyWithTopic(topic));
      if (items == null) return [];
      final json = jsonDecode(items) as Map<String, dynamic>;
      return (json['data'] as Iterable).map((e) => NewsResponse.fromJson(e)).toList();
    } catch (e, st) {
      logger.e(e, stackTrace: st);
      return [];
    }
  }

  @override
  Future<void> updateCacheNewsList(String topic, List<NewsResponse> newsList) async {
    try {
      final String json = jsonEncode({'data': newsList});
      await _prefs.setString(cacheKeyWithTopic(topic), json);
    } catch (e, st) {
      logger.e(e, stackTrace: st);
    }
  }
}

// abstract class NewsLocalDataSource {
//   Future<void> updateCacheNewsList(String topic, List<NewsCM> newsList);

//   Future<List<NewsCM>> getCacheNewsList(String topic);

//   Future<List<NewsCM>> getSavedNewsList();

//   Future<void> saveNews(NewsCM news);
// }

// class NewsLocalDataSourceImpl implements NewsLocalDataSource {
//   static const _cacheNewsListBoxKey = 'cache-news-list';
//   static const _savedNewsListBoxKey = 'saved-news-list';
//   static const _savedKey = 'saved-key';

//   final HiveInterface _hive;

//   NewsLocalDataSourceImpl({
//     @visibleForTesting HiveInterface? hive,
//   }) : _hive = hive ?? Hive {
//     try {
//       _hive.registerAdapter(NewsCMAdapter());
//     } catch (_) {
//       throw Exception('Hive registerAdapter error');
//     }
//   }

//   @override
//   Future<List<NewsCM>> getSavedNewsList() async {
//     final box = await _openHiveBox<List<NewsCM>>(_savedNewsListBoxKey);
//     try {
//       final items = box.get(_savedKey);
//       return items ?? [];
//     } catch (e, st) {
//       logger.e(e, stackTrace: st);
//       box.clear();
//       return [];
//     }
//   }

//   @override
//   Future<void> saveNews(NewsCM news) async {
//     final box = await _openHiveBox<List<NewsCM>>(_savedNewsListBoxKey);
//     final items = box.get(_savedKey) ?? [];

//     await box.put(_savedKey, [...items, news]);

//     logger.d("Save News");
//     logger.d(box.get(_savedKey));
//   }

//   @override
//   Future<List<NewsCM>> getCacheNewsList(String topic) async {
//     final box = await _openHiveBox<List<NewsCM>>(_cacheNewsListBoxKey);
//     final items = box.get(topic) ?? [];
//     return items;
//   }

//   @override
//   Future<void> updateCacheNewsList(String topic, List<NewsCM> newsList) async {
//     final box = await _openHiveBox<List<NewsCM>>(_cacheNewsListBoxKey);
//     await box.put(topic, newsList);
//   }

//   Future<Box<T>> _openHiveBox<T>(String boxKey) async {
//     if (_hive.isBoxOpen(boxKey)) {
//       return _hive.box(boxKey);
//     } else {
//       return _hive.openBox<T>(boxKey);
//     }
//   }
// }

@Riverpod(keepAlive: true)
NewsLocalDataSource newsLocalDataSource(Ref ref) {
  return NewsLocalDataSourceImpl();
}
