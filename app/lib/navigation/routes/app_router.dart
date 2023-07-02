import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNavigator');
final searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'searchNavigator');
final myPageNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'myPageNavigator');

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: NavigationConstants.homePath,
  debugLogDiagnostics: true,
  observers: [NavigatorObserver()],
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainPage(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: NavigationConstants.homePath,
              name: NavigationConstants.homeName,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: searchNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: NavigationConstants.searchPath,
              name: NavigationConstants.searchName,
              builder: (context, state) => const SearchPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: myPageNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: NavigationConstants.myPagePath,
              name: NavigationConstants.myPageName,
              builder: (context, state) => const MyPagePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: NavigationConstants.loginPath,
      name: NavigationConstants.loginName,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: NavigationConstants.registerAccountPath,
      name: NavigationConstants.registerAccountName,
      builder: (context, state) => const RegisterAccountPage(),
    ),
    GoRoute(
      path: NavigationConstants.itemDetailPath,
      name: NavigationConstants.itemDetailName,
      builder: (context, state) => ItemDetailPage(
        user: User.fromJson(
          state.extra is Map<String, dynamic> ? state.extra as Map<String, dynamic> : {},
        ),
        userId: state.pathParameters[NavigationConstants.userIdPathParam] ?? '',
        email: state.queryParameters[NavigationConstants.emailQueryParam] ?? '',
      ),
      // redirect: (context, state) => GetIt.instance.get<RouteGuard>().redirect(context, state),
    ),
  ],
);
