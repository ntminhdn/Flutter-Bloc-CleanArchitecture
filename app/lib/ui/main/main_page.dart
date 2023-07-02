import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app.dart';
import 'bloc/main.dart';

class MainPage extends StatefulWidget {
  const MainPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BasePageState<MainPage, MainBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
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
      ),
    );
  }
}
