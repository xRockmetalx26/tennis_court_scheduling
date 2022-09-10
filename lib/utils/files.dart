import 'dart:io';
import 'try.dart';

class Files {
  Future<File?> write(String filepath, String data, {FileMode mode = FileMode.write}) async =>
      await Try.asyncCall(() async => await File(filepath).writeAsString(data));

  Future<String?> read(String filepath) async =>
      await Try.asyncCall(() async => await File(filepath).readAsString());
}
