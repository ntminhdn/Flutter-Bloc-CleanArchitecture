import 'package:shared/shared.dart';

import '../di/di.dart' as di;

class DomainConfig extends Config {
  factory DomainConfig.getInstance() {
    return _instance;
  }

  DomainConfig._();

  static final DomainConfig _instance = DomainConfig._();

  @override
  Future<void> config() async => di.configureInjection();
}
