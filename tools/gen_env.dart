// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main() {
  final allDartDefinesByEnv = <String, Map<String, String>>{};
  allDartDefinesByEnv[devPrefix] = readDartDefineFromEnv(devEnvPath, devFlavorValue);
  allDartDefinesByEnv[qaPrefix] = readDartDefineFromEnv(qaEnvPath, qaFlavorValue);
  allDartDefinesByEnv[stgPrefix] = readDartDefineFromEnv(stgEnvPath, stgFlavorValue);
  allDartDefinesByEnv[prodPrefix] = readDartDefineFromEnv(prodEnvPath, prodFlavorValue);

  try {
    final settingsFile = File(settingsJsonPath);
    if (!settingsFile.existsSync()) {
      settingsFile.createSync(recursive: true);
      settingsFile.writeAsStringSync('{}');
    }

    SettingsJsonWriter(dartDefinesByEnv: allDartDefinesByEnv).call();

    LaunchJsonWriter(
      filePath: launchJsonPath,
      dartDefinesByEnv: allDartDefinesByEnv,
    ).call();
  } on FormatException catch (e) {
    print(
        '''Error: The content of settings.json or launch.json is empty or the trailing comma is redundant or comments are invalid
        
        BAD:
        ```
        "settingA": {
          "keyA": "A",
          "keyB": "B", // <== Please remove this trailing comma
        }
        ```

        GOOD:
        ```
        "settingA": {
          "keyA": "A",
          "keyB": "B"
        }
        ```
        $e''');
  } on FileSystemException catch (e) {
    print('Error: Either .vscode/settings.json or .vscode/launch.json is not exist!\n$e');
  }
}

const devPrefix = 'DEV';
const qaPrefix = 'QA';
const stgPrefix = 'STG';
const prodPrefix = 'PROD';
const devEnvPath = './env/develop.env';
const qaEnvPath = './env/qa.env';
const stgEnvPath = './env/staging.env';
const prodEnvPath = './env/production.env';
const flavorKey = 'FLAVOR';
const devFlavorValue = 'develop';
const qaFlavorValue = 'qa';
const stgFlavorValue = 'staging';
const prodFlavorValue = 'production';
const launchJsonPath = './.vscode/launch.json';
const settingsJsonPath = './.vscode/settings.json';

Map<String, String> readDartDefineFromEnv(String path, String flavor) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync('FLAVOR=$flavor\n');
  }

  final lines = LineSplitter.split(file.readAsStringSync());
  final map = <String, String>{};
  final regex = RegExp(r'(\w+)=(.*)');
  lines.forEach((element) {
    final match = regex.firstMatch(element);

    if (match != null) {
      map[match[1]!] = match[2]!;
    }
  });

  if (!map.containsKey(flavorKey)) {
    file.writeAsStringSync('FLAVOR=$flavor', mode: FileMode.append);
    map[flavorKey] = flavor;
  }

  return map;
}

class SettingsJsonWriter extends LaunchJsonWriter {
  SettingsJsonWriter({required super.dartDefinesByEnv}) : super(filePath: settingsJsonPath);

  @override
  String writeConfig(String fileContent) {
    fileContent = fileContent.replaceAll(RegExp('.+// .+\n'), '');
    final Map<String, dynamic> configJson = jsonDecode(fileContent);
    configJson['dart.env'] = convertDartDefineToEnvVariable();

    return prettifyJson(configJson);
  }

  Map<String, String> convertDartDefineToEnvVariable() {
    final map = <String, String>{};
    dartDefinesByEnv.forEach((key, value) {
      if (key == devPrefix) {
        map.addAll(value.map((key, value) => MapEntry('${devPrefix}_$key', value))
          ..remove('${devPrefix}_$flavorKey'));
      } else if (key == qaPrefix) {
        map.addAll(value.map((key, value) => MapEntry('${qaPrefix}_$key', value))
          ..remove('${qaPrefix}_$flavorKey'));
      } else if (key == stgPrefix) {
        map.addAll(value.map((key, value) => MapEntry('${stgPrefix}_$key', value))
          ..remove('${stgPrefix}_$flavorKey'));
      } else if (key == prodPrefix) {
        map.addAll(value.map((key, value) => MapEntry('${prodPrefix}_$key', value))
          ..remove('${prodPrefix}_$flavorKey'));
      }
    });

    return map;
  }
}

class LaunchJsonWriter {
  final String filePath;
  final Map<String, Map<String, String>> dartDefinesByEnv;

  LaunchJsonWriter({
    required this.filePath,
    required this.dartDefinesByEnv,
  });

  void call() {
    final mandatoryFile = File(filePath);
    mandatoryFile.writeAsStringSync(writeConfig(mandatoryFile.readAsStringSync()));
  }

  String writeConfig(String fileContent) {
    fileContent = fileContent.replaceAll(RegExp('.+// .+\n'), '');
    final dynamic configJson = jsonDecode(fileContent);
    final configList = configJson['configurations'] as Iterable;

    final configurations = configList.map<dynamic>((dynamic configMap) {
      final String launcherName = configMap['name'];
      if (launcherName.toLowerCase().contains('dev') ||
          launcherName.toLowerCase().contains('develop')) {
        return updateConfig(configMap, devPrefix);
      } else if (launcherName.toLowerCase().contains('qa')) {
        return updateConfig(configMap, qaPrefix);
      } else if (launcherName.toLowerCase().contains('stg') ||
          launcherName.toLowerCase().contains('staging')) {
        return updateConfig(configMap, stgPrefix);
      } else if (launcherName.toLowerCase().contains('prod') ||
          launcherName.toLowerCase().contains('production')) {
        return updateConfig(configMap, prodPrefix);
      } else {
        return configMap;
      }
    }).toList();
    configJson['configurations'] = configurations;
    return prettifyJson(configJson);
  }

  Map<String, dynamic> updateConfig(
    Map<String, dynamic> config,
    String flavor,
  ) {
    final dartDefines = dartDefinesByEnv[flavor]!;
    final dartDefineArgs = <String>[];
    dartDefines.forEach((k, v) {
      dartDefineArgs.add('--dart-define');
      if (k == flavorKey) {
        dartDefineArgs.add('$k=$v');
      } else {
        dartDefineArgs.add('$k=\${${flavor}_$k}');
      }
    });

    config.update(
      'toolArgs',
      (dynamic value) => getNonDartDefineArguments(value).followedBy(dartDefineArgs).toList(),
      ifAbsent: () => dartDefineArgs.toList(),
    );
    return config;
  }

  String prettifyJson(dynamic json) {
    try {
      final spaces = ' ' * 4;
      final encoder = JsonEncoder.withIndent(spaces);
      return encoder.convert(json);
    } catch (e) {
      return '';
    }
  }

  List<dynamic> getNonDartDefineArguments(List<dynamic> argList) {
    bool previousWasDartDefine = false;

    final List retainedArgs = <dynamic>[];
    argList.forEach((dynamic arg) {
      if (arg == '--dart-define') {
        previousWasDartDefine = true;
        return;
      }

      if (!previousWasDartDefine) {
        retainedArgs.add(arg);
      }

      previousWasDartDefine = false;
    });
    return retainedArgs;
  }
}

String convertEnvToDartDefineString(Iterable<String> envs) {
  final StringBuffer buffer = StringBuffer();
  envs.forEach((value) {
    buffer.write('--dart-define=$value ');
  });
  final string = buffer.toString();
  return string.substring(0, string.length - 1);
}
