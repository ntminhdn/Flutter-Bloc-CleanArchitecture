import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../domain.dart';

abstract class AppNavigator {
  const AppNavigator();

  bool get canPopSelfOrChildren;

  int get currentBottomTab;

  String getCurrentRouteName({bool useRootNavigator = false});

  void navigateToBottomTab(int index);

  Future<T?> push<T extends Object?>(
    AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  });

  Future<void> pushAll(List<AppRouteInfo> listAppRouteInfo, {
    bool useRootNavigator = false,
  });

  Future<T?> replace<T extends Object?>(AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  });

  Future<T?> pushReplacement<T extends Object?>(AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  });

  void pop<T extends Object?>({
    T? result,
    bool useRootNavigator = false,
  });

  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    AppRouteInfo appRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  });

  void popAllAndPush<T extends Object?>(
    AppRouteInfo appRouteInfo, {
    bool useRootNavigator = false,
  });

  void popUntilRoot({bool useRootNavigator = false});

  void popUntilRouteName(String routeName, {bool useRootNavigator = false});

  Future<T?> showDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool barrierDismissible = true,
    bool useSafeArea = false,
    bool useRootNavigator = true,
  });

  Future<T?> showGeneralDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transitionBuilder,
    Duration transitionDuration = DurationConstants.defaultGeneralDialogTransitionDuration,
    bool barrierDismissible = true,
    Color barrierColor = const Color(0x80000000),
    bool useRootNavigator = true,
  });

  Future<T?> showModalBottomSheet<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color barrierColor = Colors.black54,
    Color? backgroundColor,
  });

  void showErrorSnackBar(String message, {Duration? duration});

  void showSuccessSnackBar(String message, {Duration? duration});
}
