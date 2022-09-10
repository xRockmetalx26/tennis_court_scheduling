import 'dart:convert';
import 'dart:io';

import 'console.dart';
import 'try.dart';

class Maps {
  static int sumLengthInMap(Map map) => Try.syncCall(() => map.values
      .fold(0, (length, iterable) => length ?? 0 + iterable?.length as int));

  static List? valuesInDeth(Map map, int depth) {
    if (depth < 0) {
      Console.error("Depth cannot be a negative value");
      return null;
    }

    List? values = Try.syncCall(() {
      Iterable it = map.values;

      for (var i = 0; i < depth; i++) {
        it = it.expand((element) => element.values);
      }

      return it.toList();
    },
        onException: () => Console.error("Depth overflow"),
        showInternalException: false);

    return values;
  }

  static Map<String, dynamic>? fromJsonString(String jsonString) =>
      Try.syncCall(() => json.decode(jsonString));

  static String? toJsonString(Map<String, dynamic> map) =>
      Try.syncCall(() => json.encode(map));

  static Future<Map<String, dynamic>?> fromFile(String filepath) async =>
      await Try.asyncCall(() async {
        File file = File(filepath);
        String jsonString = await file.readAsString();

        return fromJsonString(jsonString);
      });

  static Future<File?> toFile(Map map, String filepath) async =>
      await Try.asyncCall(
          () async => await File(filepath).writeAsString(json.encode(map)));
}
