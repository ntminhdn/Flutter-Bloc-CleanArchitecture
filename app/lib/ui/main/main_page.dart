import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import 'bloc/main.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BasePageState<MainPage, MainBloc> {
  final _bottomBarKey = GlobalKey();

  @override
  Widget buildPage(BuildContext context) {
    return AutoTabsScaffold(
      routes: (navigator as AppNavigatorImpl).tabRoutes,
      bottomNavigationBuilder: (_, tabsRouter) {
        (navigator as AppNavigatorImpl).tabsRouter = tabsRouter;

        return BottomNavigationBar(
          key: _bottomBarKey,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) {
            if (index == tabsRouter.activeIndex) {
              (navigator as AppNavigatorImpl).popUntilRootOfCurrentBottomTab();
            }
            tabsRouter.setActiveIndex(index);
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          // unselectedItemColor: AppColors.current.primaryColor,
          // selectedItemColor: AppColors.current.primaryColor,
          type: BottomNavigationBarType.fixed,
          // backgroundColor: AppColors.current.primaryColor,
          items: BottomTab.values
              .map(
                (tab) => BottomNavigationBarItem(
                  label: tab.title,
                  icon: tab.icon,
                  activeIcon: tab.activeIcon,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
