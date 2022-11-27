import 'package:auto_route/auto_route.dart';

import '../../ui/home/home_page.dart';
import '../../ui/item_detail/item_detail_page.dart';
import '../../ui/login/login_page.dart';
import '../../ui/main/main_page.dart';
import '../../ui/my_page/my_page_page.dart';
import '../../ui/search/search_page.dart';

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
        AutoRoute<dynamic>(page: ItemDetailPage),
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
