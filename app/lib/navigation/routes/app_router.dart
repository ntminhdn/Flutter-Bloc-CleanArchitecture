import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../../app.dart';

// ignore_for_file:avoid-dynamic
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: LoginPage),
    mainScreenRouter,
  ],
)
class $AppRouter {}

const mainScreenRouter = CustomRoute<dynamic>(
  transitionsBuilder: TransitionsBuilders.fadeIn,
  durationInMilliseconds: 200,
  page: MainPage,
  children: [
    AutoRoute<dynamic>(
      name: 'BottomTabHomeRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(page: HomePage, initial: true),
        AutoRoute<dynamic>(
          page: ItemDetailPage,
          guards: [RouteGuard],
        ),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabSearchRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(page: SearchPage, initial: true),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabMyPageRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(page: MyPagePage, name: 'MyPageRoute', initial: true),
      ],
    ),
  ],
);
