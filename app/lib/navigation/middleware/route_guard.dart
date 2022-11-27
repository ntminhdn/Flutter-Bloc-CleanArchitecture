import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

@Injectable()
class RouteGuard extends AutoRouteGuard {
  RouteGuard(this._isLoggedInUseCase);

  final IsLoggedInUseCase _isLoggedInUseCase;

  bool get _isLoggedIn =>
      runCatching(action: () => _isLoggedInUseCase.execute(const IsLoggedInInput())).when(
        success: (output) => output.isLoggedIn,
        failure: (e) => false,
      );

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
      resolver.next(false);
    }
  }
}
