import 'dart:developer';
import 'dart:io';

import 'package:agendamiento_canchas/utils/attempt.dart';

class Files {
  static Future<File?> write(String filepath, String data, {FileMode mode = FileMode.write}) async {
    final file = File(filepath);
    final fileReference = await Attempt.asyncCall<File?>(() async => await file.writeAsString(data));

    return fileReference;
  }

  static Future<String?> read(String filepath) async {
    final file = File(filepath);
    final data = await Attempt.asyncCall<String?>(() async => await file.readAsString());

    return data;
  }
}
