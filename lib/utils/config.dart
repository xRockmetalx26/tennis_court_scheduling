import 'package:agendamiento_canchas/constants/constants.dart';
import 'package:agendamiento_canchas/utils/attempt.dart';
import 'package:agendamiento_canchas/utils/flutter_files.dart';
import 'package:agendamiento_canchas/utils/maps.dart';

class Config {
  static Future<bool> loadConfig() async {
    final result = await Attempt.asyncCall<bool>(() async {
      final applicationDocumentsPath =
          await FlutterFiles.applicationDocumentsPath;

      final data = await Maps.fromFile(
          "${applicationDocumentsPath!}/${Constants.configFilename}");

      _config = data!;

      return true;
    });

    return result ?? false;
  }

  static Future<bool> createConfig(Map<String, dynamic> config) async {
    final result = await Attempt.asyncCall<bool>(() async {
      final applicationDocumentsPath =
          await FlutterFiles.applicationDocumentsPath;

      await Maps.toFile(
          "${applicationDocumentsPath!}/${Constants.configFilename}", config);

      return true;
    });

    return result ?? false;
  }

  static Future<void> _updateConfig() async {
    final applicationDocumentsPath =
        await FlutterFiles.applicationDocumentsPath;

    await Maps.toFile(
        "${applicationDocumentsPath!}/${Constants.configFilename}", _config);
  }

  static get(String key) {
    return _config[key];
  }

  static set(String key, dynamic value) async {
    _config[key] = value;
    await _updateConfig();
  }

  static Map<String, dynamic> _config = {};
}
