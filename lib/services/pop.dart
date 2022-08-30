import 'dart:convert';
import 'dart:developer';
import 'package:agendamiento_canchas/utils/date_time_converter.dart';
import 'package:http/http.dart';

class POP {
  static Future<Map<String, String>> popEightDays(
      String latitude, String longitude, String apiKey) async {
    try {
      final uri = Uri.parse(
          "$_urlApi/onecall?lat=$latitude&lon=$longitude&appid=$apiKey&exclude=current,minutely,hourly,alerts&units=metric");

      final response = await get(uri);
      var data = json.decode(response.body) as Map<String, dynamic>;

      if (!data.containsKey("daily")) return {"Error": "Error"};

      final Map<String, String> pops = {
        for (final day in data["daily"])
          DateTimeConverter.toYMDString(DateTime.fromMillisecondsSinceEpoch(day["dt"] * 1000)): day["pop"].toString()
      };

      return pops;
    } catch (e) {
      log("", error: e.toString());

      return {"Error": "Error"};
    }
  }

  static const String _urlApi = "https://api.openweathermap.org/data/2.5";
}
