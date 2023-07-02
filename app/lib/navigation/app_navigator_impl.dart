import 'package:domain/domain.dart';
import 'package:flutter/material.dart' as m;
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../app.dart';

@LazySingleton(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator with LogMixin {
  AppNavigatorImpl(
    this._appPopupInfoMapper,
  );

  final BasePopupInfoMapper _appPopupInfoMapper;
  final _popups = <AppPopupInfo>{};

  m.BuildContext get _context => rootNavigatorKey.currentContext!;
  m.BuildContext get _childContext {
    return homeNavigatorKey.currentContext!;
  }

  @override
  int get currentBottomTab {
    return StatefulNavigationShell.of(_childContext).currentIndex;
  }

  @override
  bool get canPopSelfOrChildren => _getRouter(true).canPop();

  GoRouter _getRouter(bool useRootNavigator) =>
      GoRouter.of(useRootNavigator ? _context : _childContext);

  m.NavigatorState _getNavigator(bool useRootNavigator) =>
      m.Navigator.of(useRootNavigator ? _context : _childContext);

  @override
  String getCurrentRouteName({bool useRootNavigator = false}) =>
      GoRouterState.of(_context).location;

  @override
  void navigateToBottomTab(int index, {bool notify = true}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('navigateToBottomTab with index = $index, notify = $notify');
    }

    StatefulNavigationShell.of(_context).goBranch(index);
  }

  @override
  Future<T?> push<T extends Object?>(
    AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  }) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('push $appRouteInfo');
    }

    return _getRouter(useRootNavigator).pushNamed<T>(
      appRouteInfo.name,
      extra: appRouteInfo.extra,
      pathParameters: appRouteInfo.pathParameters,
      queryParameters: appRouteInfo.queryParameters,
    );
  }

  @override
  Future<void> pushAll(
    List<AppRouteInfo> listAppRouteInfo, {
    bool useRootNavigator = false,
  }) async {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('pushAll $listAppRouteInfo');
    }

    for (final appRouteInfo in listAppRouteInfo) {
      await push(appRouteInfo);
    }
  }

  @override
  Future<T?> replace<T extends Object?>(
    AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  }) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('replace by $appRouteInfo');
    }

    return _getRouter(useRootNavigator).replaceNamed(
      appRouteInfo.name,
      extra: appRouteInfo.extra,
      pathParameters: appRouteInfo.pathParameters,
      queryParameters: appRouteInfo.queryParameters,
    );
  }

  @override
  void pop<T extends Object?>({T? result, bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('pop with result = $result, useRootNav = $useRootNavigator');
    }

    _getRouter(useRootNavigator).pop<T>(result);
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

    _getRouter(useRootNavigator).pop();

    return push(appRouteInfo, useRootNavigator: useRootNavigator);
  }

  @override
  void popUntilRoot({bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popUntilRoot, useRootNav = $useRootNavigator');
    }

    _getNavigator(useRootNavigator).popUntil((route) => route.isFirst);
  }

  @override
  void popUntilRouteName(String routeName, {bool useRootNavigator = false}) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popUntilRouteName $routeName');
    }

    _getNavigator(useRootNavigator).popUntil((route) => route.settings.name == routeName);
  }

  @override
  void popAllAndPush<T extends Object?>(
    AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  }) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('popAllAndPush $appRouteInfo');
    }

    _getRouter(useRootNavigator).goNamed(appRouteInfo.name);
  }

  @override
  Future<T?> pushReplacement<T extends Object?>(
    AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  }) {
    if (LogConfig.enableNavigatorObserverLog) {
      logD('pushReplacement $appRouteInfo');
    }

    return _getRouter(useRootNavigator).pushReplacementNamed(appRouteInfo.name);
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
      context: _context,
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
      context: _context,
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
      context: _context,
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
      _context,
      message,
      duration: duration,
      // backgroundColor: AppColors.current.primaryColor,
    );
  }

  @override
  void showSuccessSnackBar(String message, {Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _context,
      message,
      duration: duration,
      // backgroundColor: AppColors.current.primaryColor,
    );
  }
}
