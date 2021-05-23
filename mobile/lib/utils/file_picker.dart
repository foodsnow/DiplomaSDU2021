import 'dart:async';

import 'package:flutter/services.dart';

/// Supported file types, [ANY] should be used if the file you need isn't listed
enum FileType {
  ANY,
  IMAGE,
  VIDEO,
  CAMERA,
  CUSTOM,
}

class FilePicker {
  static const MethodChannel _channel = const MethodChannel('file_picker');
  static const String _tag = 'FilePicker';

  static Future<String> _getPath(String type) async {
    try {
      return await _channel.invokeMethod(type);
    } on PlatformException catch (e) {
      print("[$_tag] Platform exception: " + e.toString());
    } catch (e) {
      print(
          "[$_tag] Unsupported operation. This probably have happened because [${type.split('_').last}] is an unsupported file type. You may want to try FileType.ALL instead.");
    }
    return null;
  }

  /// Returns an absolute file path from the calling platform
  ///
  /// A [type] must be provided to filter the picking results.
  /// Can be used a custom file type with `FileType.CUSTOM`. A [fileExtension] must be provided (e.g. PDF, SVG, etc.)
  /// Defaults to `FileType.ANY` which will display all file types.
  static Future<Map<String, dynamic>> getFilePath(
      {FileType type = FileType.ANY}) async {
    switch (type) {
      case FileType.ANY:
        final result = await _getPath('ANY');
        return <String, String>{'path': result};
      default:
        final result = await _getPath('ANY');
        return <String, String>{'path': result};
    }
  }
}
