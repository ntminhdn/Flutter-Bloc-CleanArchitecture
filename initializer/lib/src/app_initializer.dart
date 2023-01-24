import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';

abstract class ApplicationConfig extends Config {}

class AppInitializer {
  AppInitializer(this._applicationConfig);

  final ApplicationConfig _applicationConfig;

  Future<void> init() async {
    EnvConstants.init();
    await SharedConfig.getInstance().init();
    await DataConfig.getInstance().init();
    await DomainConfig.getInstance().init();
    await _applicationConfig.init();
  }
}
