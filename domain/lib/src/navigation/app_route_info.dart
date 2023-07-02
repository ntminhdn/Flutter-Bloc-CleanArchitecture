import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../domain.dart';

part 'app_route_info.freezed.dart';

@freezed
class AppRouteInfo with _$AppRouteInfo {
  const factory AppRouteInfo({
    required String name,
    @Default(<String, dynamic>{}) Map<String, dynamic> extra,
    @Default(<String, String>{}) Map<String, String> pathParameters,
    @Default(<String, dynamic>{}) Map<String, dynamic> queryParameters,
  }) = _AppRouteInfo;

  static AppRouteInfo login() => const AppRouteInfo(
        name: NavigationConstants.loginName,
      );

  static AppRouteInfo main() => const AppRouteInfo(
        name: NavigationConstants.homeName,
      );

  static AppRouteInfo itemDetail(User user) => AppRouteInfo(
        name: NavigationConstants.itemDetailName,
        extra: user.toJson(),
        pathParameters: {NavigationConstants.userIdPathParam: user.id.toString()},
        queryParameters: {NavigationConstants.emailQueryParam: user.email},
      );
  
  static AppRouteInfo registerAccount() =>const AppRouteInfo(
        name: NavigationConstants.registerAccountName,
      );
}
