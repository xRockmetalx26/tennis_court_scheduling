import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FlutterFiles {
  static Future<String?> get applicationDocumentsPath async {
    try {
      final path = await getApplicationDocumentsDirectory()
          .then((directory) => directory.path);
      return path;
    } catch (e) {
      log("", error: e.toString());
      return null;
    }
  }

  static Future<File?> localFile(String filename) async {
    final localPath = await applicationDocumentsPath;

    if (localPath == null) return null;

    return File("$localPath/$filename");
  }

  static void write(String filename, String data,
      {FileMode mode = FileMode.write}) async {
    final file = await localFile(filename);
    if (file == null) return;

    try {
      await file.writeAsString(data, mode: mode);
    } catch (e) {
      log("", error: e.toString());
      return;
    }
  }

  static Future<String?> read(String filename) async {
    final file = await localFile(filename);
    if (file == null) return null;

    try {
      final data = await file.readAsString();
      return data;
    } catch (e) {
      log("", error: e.toString());
      return null;
    }
  }

  static Future<bool> exists(String filename) async {
    final file = await localFile(filename);
    if (file == null) return false;

    return await file.exists();
  }

  static void remove(String filename) async {
    final file = await localFile(filename);
    if (file == null) return;

    try {
      await file.delete();
    } catch (e) {
      log("", error: e.toString());
    }
  }
}
