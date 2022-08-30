import 'dart:convert';
import 'dart:io';

import 'package:agendamiento_canchas/utils/attempt.dart';
import 'package:agendamiento_canchas/utils/files.dart';

class Maps {
  static int sumLengthInMap(Map<dynamic, Iterable> map) {
    int sum =
        map.values.fold<int>(0, (length, iterable) => length + iterable.length);

    return sum;
  }

  // string data with json.encode()
  static Map<String, dynamic>? fromString(String dataEncode) {
    final map = Attempt.syncCall(() => json.decode(dataEncode));
    if (map == null) return null;

    return map as Map<String, dynamic>;
  }

  // file data with json.encode()
  static Future<Map<String, dynamic>?> fromFile(String filepath) async {
    final map = await Attempt.asyncCall(() async {
      final file = File(filepath);
      final dataEncode = await file.readAsString();
      return fromString(dataEncode);
    });

    return map;
  }

  static Future<File?> toFile(String filepath, Map<String, dynamic> map) async {
    final file = await Attempt.asyncCall(() => Files.write(filepath, json.encode(map)));
    return file;
  }
}
