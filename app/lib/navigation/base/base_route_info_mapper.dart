import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';

abstract class BaseRouteInfoMapper {
  PageRouteInfo map(AppRouteInfo appRouteInfo);

  List<PageRouteInfo> mapList(List<AppRouteInfo> listAppRouteInfo) {
    return listAppRouteInfo.map(map).toList(growable: false);
  }
}
