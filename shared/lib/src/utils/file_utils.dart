import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  /// If set, we want to save all files into a specific folder
  static String? defaultDir;

  static Future<File?> getImageFileFromUrl(String imageUrl) async {
    try {
      return DefaultCacheManager().getSingleFile(imageUrl);
    } catch (_) {
      return null;
    }
  }

  /// Read content of file by file-name
  ///
  /// Example:
  /// ```dart
  /// final fileContent = await FileUtils.readFile('temp-file.txt');
  ///
  /// // read png image from cached folder
  /// final pngContent = await FileUtils.readFile('my-avatar.png', temporary: true);
  /// ```
  static Future<Uint8List?> readFile(String filename, {bool temporary = false}) async {
    final theFile = await _getFile(filename, temporary: temporary);
    if (theFile != null) {
      return await theFile.readAsBytes();
    }

    return null;
  }

  /// Write content to a file by file-name
  static Future<File> writeFile(
    String filename,
    Uint8List buffer, {
    bool temporary = false,
    bool override = false,
  }) async {
    final theFile = await _getFile(filename, temporary: temporary);
    if (theFile == null) {
      final newFilePath = await _filePath(filename, temporary: temporary);

      return await File(newFilePath).writeAsBytes(buffer);
    } else {
      if (override) {
        return await theFile.writeAsBytes(buffer);
      } else {
        final oldFileName = filename.split('.').toList();
        var fileExtension = '';
        if (oldFileName.length > 1) {
          fileExtension = '.${oldFileName.removeLast()}';
        }

        final newFileName =
            '${oldFileName.join(".")}_${(DateTime.now().millisecondsSinceEpoch) / 1000}$fileExtension';

        return await writeFile(newFileName, buffer, temporary: temporary, override: override);
      }
    }
  }

  // /// Create a temporary File in cached folder
  // static Future<File> createTempFile(String fileName) async {
  //   return File(await _filePath(fileName, temporary: true));
  // }

  static String? getMimeType(File file) {
    return lookupMimeType(file.path);
  }

  static bool isExist(String filePath) {
    return File(filePath).existsSync();
  }

  static bool isFolder(String filePath) {
    return FileSystemEntity.typeSync(filePath) == FileSystemEntityType.directory;
  }

  static Future<bool> removeFile(String filePath) async {
    try {
      await File(filePath).delete(recursive: true);

      return true;
    } catch (e) {}

    return false;
  }

  /// Get temporary directory for App. If `defaultDir` is not set, all files will not be save into
  /// a specific folder.
  ///
  /// A temporary directory (cache) that the system can clear at any time.
  ///
  /// Return `null` if there are any exception
  static Future<Directory?> _getTemporaryDir() async {
    try {
      final directory = await getTemporaryDirectory();
      final tempDirPath = "${directory.path}${defaultDir != null ? '/$defaultDir' : ''}";
      final tempDir = Directory(tempDirPath);
      if (!(await tempDir.exists())) {
        return await tempDir.create(recursive: true);
      }

      return tempDir;
    } on MissingPlatformDirectoryException catch (_) {}

    return null;
  }

  /// Get document directory for App. If `defaultDir` is not set, all files will not be save into
  /// a specific folder.
  ///
  /// The system clears the directory only when the app is deleted.
  ///
  /// Return `null` if there are any exception
  static Future<Directory?> _getDocumentDir() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final documentPath = "${directory.path}${defaultDir != null ? '/$defaultDir' : ''}";
      final documentDir = Directory(documentPath);
      if (!(await documentDir.exists())) {
        return await documentDir.create(recursive: true);
      }

      return documentDir;
    } on MissingPlatformDirectoryException catch (_) {}

    return null;
  }

  /// Get file object from filename. If file is not exists, return `null`
  static Future<File?> _getFile(String filename, {bool temporary = false}) async {
    final filePath = await _filePath(filename, temporary: temporary);
    final file = File(filePath);

    return (await file.exists()) ? file : null;
  }

  /// Return `file-path` according to either temporary folder or document folder
  static Future<String> _filePath(String filename, {bool temporary = false}) async {
    return temporary
        ? "${(await _getTemporaryDir())?.path ?? ''}/$filename"
        : "${(await _getDocumentDir())?.path ?? ''}/$filename";
  }
}
