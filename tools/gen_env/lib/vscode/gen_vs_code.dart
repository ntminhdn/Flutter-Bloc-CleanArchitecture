// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import '../common/index.dart';

class VsCodeEnvGenerator {
  final Map<FlavorsEnum, Map<String, String>> allDartDefinesByEnv;

  VsCodeEnvGenerator({
    required this.allDartDefinesByEnv,
  });

  void call() {
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
      print(
          'Error: Either .vscode/settings.json or .vscode/launch.json is not exist!\n$e');
    }
  }
}

class SettingsJsonWriter extends LaunchJsonWriter {
  SettingsJsonWriter({required super.dartDefinesByEnv})
      : super(filePath: settingsJsonPath);

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
      final Flavor matchingFlavor =
      flavorsList.firstWhere((element) => element.flavorEnum == key);
      map.addAll(value
          .map((key, value) => MapEntry('${matchingFlavor.prefix}_$key', value))
        ..remove('${matchingFlavor.prefix}_$flavorKey'));
    });
    return map;
  }
}

class LaunchJsonWriter {
  final String filePath;
  final Map<FlavorsEnum, Map<String, String>> dartDefinesByEnv;

  LaunchJsonWriter({
    required this.filePath,
    required this.dartDefinesByEnv,
  });

  void call() {
    final mandatoryFile = File(filePath);
    mandatoryFile
        .writeAsStringSync(writeConfig(mandatoryFile.readAsStringSync()));
  }

  String writeConfig(String fileContent) {
    fileContent = fileContent.replaceAll(RegExp('.+// .+\n'), '');
    final dynamic configJson = jsonDecode(fileContent);
    final configList = configJson['configurations'] as Iterable;

    final configurations = configList.map<dynamic>((dynamic configMap) {
      final String launcherName = configMap['name'];
      final Flavor? foundMatch = getFlavorFromString(launcherName);
      if (foundMatch == null) {
        return configMap;
      }
      return updateConfig(configMap, foundMatch);
    }).toList();
    configJson['configurations'] = configurations;
    return prettifyJson(configJson);
  }

  Map<String, dynamic> updateConfig(
      Map<String, dynamic> config, Flavor flavor) {
    final dartDefines = dartDefinesByEnv[flavor.flavorEnum]!;
    final dartDefineArgs = <String>[];
    dartDefines.forEach((k, v) {
      dartDefineArgs.add('--dart-define');
      if (k == flavorKey) {
        dartDefineArgs.add('$k=$v');
      } else {
        dartDefineArgs.add('$k=\${${flavor.prefix}_$k}');
      }
    });

    config.update(
      'toolArgs',
          (dynamic value) =>
          getNonDartDefineArguments(value).followedBy(dartDefineArgs).toList(),
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

    final List<dynamic> retainedArgs = <dynamic>[];
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
