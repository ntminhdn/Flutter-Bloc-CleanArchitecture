// ignore_for_file: avoid_print

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../common/index.dart';
import 'conf_skeleton.dart';

final List<String> flutterCommands = ['run', 'release', 'profile'];
final List<String> makefileCommands = [
  'gen_env',
  'sync',
  'dart_code_metrics',
  'update_app_icon',
  'update_splash',
  'remove_splash'
];

class AndroidStudioEnvGenerator {
  final Map<FlavorsEnum, Map<String, String>> allDartDefinesByEnv;

  AndroidStudioEnvGenerator({
    required this.allDartDefinesByEnv,
  });

  void call() {
    try {
      final settingsFile = File(workspaceXmlPath);
      if (!settingsFile.existsSync()) {
        settingsFile.createSync(recursive: true);
        settingsFile.writeAsStringSync(workspaceSkeleton);
      }
      ConfigXmlWriter(
        filePath: workspaceXmlPath,
        allDartDefinesByEnv: allDartDefinesByEnv,
      ).call();
    } on FormatException catch (e) {
      print('''Error: The content of $workspaceXmlPath is not a valid XML format
        $e''');
    } on FileSystemException catch (e) {
      print('Error: $workspaceXmlPath does not exist!\n$e');
    }
  }
}

class ConfigXmlWriter {
  final String filePath;
  final Map<FlavorsEnum, Map<String, String>> allDartDefinesByEnv;

  ConfigXmlWriter({
    required this.filePath,
    required this.allDartDefinesByEnv,
  });

  void call() {
    final mandatoryFile = File(filePath);
    mandatoryFile
        .writeAsStringSync(writeConfig(mandatoryFile.readAsStringSync()));
  }

  String writeConfig(String fileContent) {
    final XmlDocument document = XmlDocument.parse(fileContent);
    validateConfFile(document);
    final runConfRootElement = document
        .findAllElements('component')
        .firstWhereOrNull(
            (element) => element.getAttribute('name') == 'RunManager');
    if (runConfRootElement == null) {
      throw FormatException;
    }

    flutterCommands.forEach((String command) {
      flavorsList.forEach((element) {
        addOrReplaceConf(
            runConfRootElement,
            createRunConf(
                config: command,
                flavor: element.name,
                dartDefines: allDartDefinesByEnv[element.flavorEnum]));
      });
    });

    makefileCommands.forEach((String command) {
      addOrReplaceConf(runConfRootElement, createMakeConf(target: command));
    });

    return document.toXmlString(pretty: true, indent: '\t');
  }

  void validateConfFile(XmlDocument document) {
    XmlElement? runConfRootElement = document
        .findAllElements('component')
        .firstWhereOrNull(
            (element) => element.getAttribute('name') == 'RunManager');
    if (runConfRootElement == null) {
      final projectRootElements = document.findAllElements('project');
      if (projectRootElements.isEmpty) {
        throw FormatException;
      }
      final XmlNode runManagerElement =
          createElementFromSkeleton(runManagerSkeleton);
      projectRootElements.first.children.add(runManagerElement);

      runConfRootElement = document
          .findAllElements('component')
          .firstWhereOrNull(
              (element) => element.getAttribute('name') == 'RunManager');
    }
  }

  XmlNode createRunConf(
      {required String config,
      required String flavor,
      Map<String, String>? dartDefines}) {
    final XmlNode newRunConfElement =
        createElementFromSkeleton(runConfigSkeletonXml);
    newRunConfElement.setAttribute('name', '$config $flavor');
    final buildFlavorElement = newRunConfElement.childElements
        .firstWhere((element) => element.getAttribute('name') == 'buildFlavor');
    buildFlavorElement.setAttribute('value', flavor);
    final dartDefinesElement = newRunConfElement.childElements.firstWhere(
        (element) => element.getAttribute('name') == 'additionalArgs');
    dartDefinesElement.setAttribute(
        'value',
        getAdditionalArgs(
            command: config, flavor: flavor, dartDefines: dartDefines));
    return newRunConfElement;
  }

  XmlNode createMakeConf({required String target}) {
    final XmlNode newMakeConfElement =
        createElementFromSkeleton(makeConfigSkeletonXml);
    newMakeConfElement.setAttribute('name', 'make $target');
    final targetElement = newMakeConfElement.findAllElements('makefile').first;
    targetElement.setAttribute('target', target);
    return newMakeConfElement;
  }

  XmlNode createElementFromSkeleton(String skeleton) {
    final XmlNode? element = XmlDocument.parse(skeleton).firstChild?.copy();
    if (element == null) {
      throw FormatException;
    }
    return element;
  }

  String getAdditionalArgs({
    required String flavor,
    String? command,
    Map<String, String>? dartDefines,
  }) {
    final StringBuffer buffer = StringBuffer();
    if (command != null && !command.contains('run')) {
      buffer.write('--$command ');
    }
    buffer.write('--flavor $flavor ');
    buffer.write(convertEnvToDartDefineString(dartDefines));
    return buffer.toString();
  }

  void addOrReplaceConf(XmlElement rootElement, XmlNode newConf) {
    final XmlNode? existingElement = rootElement.children.firstWhereOrNull(
        (element) =>
            element.getAttribute('name') == newConf.getAttribute('name'));
    if (existingElement != null) {
      rootElement.children.remove(existingElement);
    }
    rootElement.children.add(newConf);
  }
}
