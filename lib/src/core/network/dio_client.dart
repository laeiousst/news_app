import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/env/app_env.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio();
  dio.options = BaseOptions(
    baseUrl: 'https://google-news13.p.rapidapi.com',
    headers: {
      'x-rapidapi-host': 'google-news13.p.rapidapi.com', // Host header
      'x-rapidapi-key': AppEnv.rapidKey, // Your API key here
    },
  );

  dio.interceptors.addAll([
    if (!kReleaseMode)
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
      ),
  ]);

  return dio;
}
