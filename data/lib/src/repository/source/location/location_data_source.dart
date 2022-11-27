import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@LazySingleton()
class LocationDataSource {
  late final Location _location = Location();

  Future<LocationData?> getGpsLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return _location.getLocation();
  }
}
