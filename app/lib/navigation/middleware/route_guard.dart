import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@Injectable()
class RouteGuard {
  RouteGuard(this._isLoggedInUseCase);

  final IsLoggedInUseCase _isLoggedInUseCase;

  bool get _isLoggedIn =>
      runCatching(action: () => _isLoggedInUseCase.execute(const IsLoggedInInput())).when(
        success: (output) => output.isLoggedIn,
        failure: (e) => false,
      );

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return _isLoggedIn ? null : NavigationConstants.loginPath;
  }
}
