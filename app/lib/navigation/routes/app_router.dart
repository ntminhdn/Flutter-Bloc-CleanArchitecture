import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';

// ignore_for_file:prefer-single-widget-per-file
@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
@LazySingleton()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(
            page: HomeTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: HomeRoute.page, initial: true),
              AutoRoute(
                page: ItemDetailRoute.page,
                guards: [RouteGuard(GetIt.instance.get<IsLoggedInUseCase>())],
              ),
            ],
          ),
          AutoRoute(
            page: SearchTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: SearchRoute.page, initial: true),
            ],
          ),
          AutoRoute(
            page: MyPageTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: MyPageRoute.page, initial: true),
            ],
          ),
        ]),
      ];
}

@RoutePage(name: 'HomeTab')
class HomeTabPage extends AutoRouter {
  const HomeTabPage({super.key});
}

@RoutePage(name: 'SearchTab')
class SearchTabPage extends AutoRouter {
  const SearchTabPage({super.key});
}

@RoutePage(name: 'MyPageTab')
class MyPageTabPage extends AutoRouter {
  const MyPageTabPage({super.key});
}
