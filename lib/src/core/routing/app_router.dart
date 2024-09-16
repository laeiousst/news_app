import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/common_widgets/scaffold_nav_bar.dart';
import 'package:news_app/src/core/routing/app_routes.dart';
import 'package:news_app/src/presentation/news_list/news_list_screen.dart';
import 'package:news_app/src/presentation/saved_news/saved_news_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _newsListNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'news');
final GlobalKey<NavigatorState> _savedNewsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'saved');

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/news',
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext c, GoRouterState state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _newsListNavigatorKey,
            routes: [
              GoRoute(
                path: '/news',
                name: AppRoutes.NEWS_LIST.name,
                builder: (context, state) => const NewsListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _savedNewsNavigatorKey,
            routes: [
              GoRoute(
                path: '/saved',
                name: AppRoutes.SAVED_NEWS.name,
                builder: (context, state) => const SavedNewsScreen(),
              ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //   path: '/',
      //   name: AppRoutes.NEWS_LIST.name,
      //   builder: (context, state) => const NewsListScreen(),
      // ),
      // GoRoute(
      //   path: '/news',
      //   name: AppRoutes.NEWS_DETAIL.name,
      //   builder: (context, state) => const NewsDetailScreen(),
      // ),
      // GoRoute(
      //   path: '/saved',
      //   name: AppRoutes.SAVED_NEWS.name,
      //   builder: (context, state) => const SavedNewsScreen(),
      // ),
    ],
  );
}
