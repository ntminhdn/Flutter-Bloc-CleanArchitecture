import 'package:injectable/injectable.dart';

import '../../app.dart';

@LazySingleton(as: AppRouter)
class MyAppRouter extends AppRouter {
  MyAppRouter(this.guard) : super(routeGuard: guard);

  final RouteGuard guard;
}
