import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/source/database/generated/objectbox.g.dart' show getObjectBoxModel;
import 'di.config.dart';

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Store> getStore() async {
    final dir = await getApplicationDocumentsDirectory();

    return Store(getObjectBoxModel(), directory: '${dir.path}/${DatabaseConstants.databaseName}');
  }
}

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection() => getIt.init();
