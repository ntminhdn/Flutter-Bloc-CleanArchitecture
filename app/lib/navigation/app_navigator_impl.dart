import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart' as m;
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../app.dart';

@LazySingleton(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator with LogMixin {
  AppNavigatorImpl(
    this._myAppRouter,
    this._appPopupInfoMapper,
    this._appRouteInfoMapper,
  );

  final tabRoutes = const [
    BottomTabHomeRouter(),
    BottomTabSearchRouter(),
    BottomTabMyPageRouter(),
  ];

  TabsRouter? tabsRouter;

  final MyAppRouter _myAppRouter;
  final BasePopupInfoMapper _appPopupInfoMapper;
  final BaseRouteInfoMapper _appRouteInfoMapper;
  final _popups = <AppPopupInfo>{};

  StackRouter? get _currentTabRouter => tabsRouter?.stackRouterOfIndex(currentBottomTab);

  StackRouter get _currentTabRouterOrRootRouter => _currentTabRouter ?? _myAppRouter;

  m.BuildContext get _rootRouterContext => _myAppRouter.navigatorKey.currentContext!;

  m.BuildContext? get _currentTabRouterContext => _currentTabRouter?.navigatorKey.currentContext;

  m.BuildContext get _currentTabContextOrRootContext =>
      _currentTabRouterContext ?? _rootRouterContext;

  @override
  int get currentBottomTab {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    return tabsRouter?.activeIndex ?? 0;
  }

  @override
  bool get canPopSelfOrChildren => _myAppRouter.canPop();

  @override
  String getCurrentRouteName({bool useRootNavigator = false}) =>
      AutoRouter.of(useRootNavigator ? _rootRouterContext : _currentTabContextOrRootContext)
          .current
          .name;

  @override
  void popUntilRootOfCurrentBottomTab() {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (_currentTabRouter?.canPop() == true) {
      if (LogConfig.enableNavigatorObserverLog) {
        logD('popUntilRootOfCurrentBottomTab');
      }
      _currentTabRouter?.popUntilRoot();
    }
  }

  @override
  void navigateToBottomTab(int index, {bool notify = true}) {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (LogConfig.enableNavigatorObserverLog) {
      logD('navigateToBottomTab with index = $index, notify = $notify');
    }
    tabsRouter?.setActiveIndex(index, notify: notify);
  }

  @override
  Future<T?> push<T extends Object?>(AppRouteInfo appRouteInfo) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('push $appRouteInfo');
    }

    return _myAppRouter.push<T>(_appRouteInfoMapper.map(appRouteInfo));
  }

  @override
  Future<void> pushAll(List<AppRouteInfo> listAppRouteInfo) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('pushAll $listAppRouteInfo');
    }

    return _myAppRouter.pushAll(_appRouteInfoMapper.mapList(listAppRouteInfo));
  }

  @override
  Future<T?> replace<T extends Object?>(AppRouteInfo appRouteInfo) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('replace by $appRouteInfo');
    }

    return _myAppRouter.replace<T>(_appRouteInfoMapper.map(appRouteInfo));
  }

  @override
  Future<void> replaceAll(List<AppRouteInfo> listAppRouteInfo) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('replaceAll by $listAppRouteInfo');
    }

    return _myAppRouter.replaceAll(_appRouteInfoMapper.mapList(listAppRouteInfo));
  }

  @override
  Future<bool> pop<T extends Object?>({T? result, bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('pop with result = $result, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _myAppRouter.pop<T>(result)
        : _currentTabRouterOrRootRouter.pop<T>(result);
  }

  @override
  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    AppRouteInfo appRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  }) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popAndPush $appRouteInfo with result = $result, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _myAppRouter.popAndPush<T, R>(_appRouteInfoMapper.map(appRouteInfo), result: result)
        : _currentTabRouterOrRootRouter.popAndPush<T, R>(
            _appRouteInfoMapper.map(appRouteInfo),
            result: result,
          );
  }

  @override
  void popUntilRoot({bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popUntilRoot, useRootNav = $useRootNavigator');
    }

    useRootNavigator ? _myAppRouter.popUntilRoot() : _currentTabRouterOrRootRouter.popUntilRoot();
  }

  @override
  void popUntilRouteName(String routeName) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popUntilRouteName $routeName');
    }

    _myAppRouter.popUntilRouteWithName(routeName);
  }

  @override
  bool removeUntilRouteName(String routeName) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('removeUntilRouteName $routeName');
    }

    return _myAppRouter.removeUntil((route) => route.name == routeName);
  }

  @override
  bool removeAllRoutesWithName(String routeName) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('removeAllRoutesWithName $routeName');
    }

    return _myAppRouter.removeWhere((route) => route.name == routeName);
  }

  @override
  Future<void> popAndPushAll(List<AppRouteInfo> listAppRouteInfo, {bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popAndPushAll $listAppRouteInfo, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _myAppRouter.popAndPushAll(_appRouteInfoMapper.mapList(listAppRouteInfo))
        : _currentTabRouterOrRootRouter
            .popAndPushAll(_appRouteInfoMapper.mapList(listAppRouteInfo));
  }

  @override
  bool removeLast() {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('removeLast');
    }

    return _myAppRouter.removeLast();
  }

  @override
  Future<T?> showDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool barrierDismissible = true,
    bool useSafeArea = false,
    bool useRootNavigator = true,
  }) {
    if (_popups.contains(appPopupInfo)) {
      logD('Dialog $appPopupInfo already shown');

      return Future.value(null);
    }
    _popups.add(appPopupInfo);

    return m.showDialog<T>(
      context: useRootNavigator ? _rootRouterContext : _currentTabContextOrRootContext,
      builder: (_) => m.WillPopScope(
        onWillPop: () async {
          logD('Dialog $appPopupInfo dismissed');
          _popups.remove(appPopupInfo);

          return Future.value(true);
        },
        child: _appPopupInfoMapper.map(appPopupInfo, this),
      ),
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
    );
  }

  @override
  Future<T?> showGeneralDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    Duration transitionDuration = DurationConstants.defaultGeneralDialogTransitionDuration,
    m.Widget Function(m.BuildContext, m.Animation<double>, m.Animation<double>, m.Widget)?
        transitionBuilder,
    m.Color barrierColor = const m.Color(0x80000000),
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) {
    if (_popups.contains(appPopupInfo)) {
      logD('Dialog $appPopupInfo already shown');

      return Future.value(null);
    }
    _popups.add(appPopupInfo);

    return m.showGeneralDialog<T>(
      context: useRootNavigator ? _rootRouterContext : _currentTabContextOrRootContext,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      pageBuilder: (
        m.BuildContext context,
        m.Animation<double> animation1,
        m.Animation<double> animation2,
      ) =>
          m.WillPopScope(
        onWillPop: () async {
          logD('Dialog $appPopupInfo dismissed');
          _popups.remove(appPopupInfo);

          return Future.value(true);
        },
        child: _appPopupInfoMapper.map(appPopupInfo, this),
      ),
      transitionBuilder: transitionBuilder,
      transitionDuration: transitionDuration,
    );
  }

  @override
  Future<T?> showModalBottomSheet<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    m.Color barrierColor = m.Colors.black54,
    m.Color? backgroundColor,
  }) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('showModalBottomSheet $appPopupInfo, useRootNav = $useRootNavigator');
    }

    return m.showModalBottomSheet<T>(
      context: useRootNavigator ? _rootRouterContext : _currentTabContextOrRootContext,
      builder: (_) => _appPopupInfoMapper.map(appPopupInfo, this),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useRootNavigator: useRootNavigator,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
    );
  }

  @override
  void showErrorSnackBar(String message, {Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      // backgroundColor: AppColors.current.primaryColor,
    );
  }

  @override
  void showSuccessSnackBar(String message, {Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      // backgroundColor: AppColors.current.primaryColor,
    );
  }
}
