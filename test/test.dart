import 'dart:convert';

import 'package:agendamiento_canchas/services/pop.dart';
import 'package:agendamiento_canchas/utils/date_time_converter.dart';
import 'package:agendamiento_canchas/utils/files.dart';
import 'package:agendamiento_canchas/utils/maps.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test unitarios", () {
    test("Otro", () async {
      await Files.write("test.txt", json.encode({"1": [1,2], "2": [3,4], "3": true}));
      expect((await Maps.fromFile("test.txt")).toString(), "{1: [1, 2], 2: [3, 4], 3: true}");
    });

    test("Modulo de DateTimeConverter", () {
      // today Y-M-D format
      expect(DateTimeConverter.toYMDString(DateTime.now()),
          DateTime.now().toString().substring(0, 10));

      expect(
          DateTimeConverter.toYMDString(DateTime.fromMicrosecondsSinceEpoch(0)),
          DateTime.fromMicrosecondsSinceEpoch(0).toString().substring(0, 10));
    });

    test("Modulo utilidades Maps", () {
      // suma todos los tamanos de los iterables contenidos en un Map<dynamic, Iterable>
      expect(
          Maps.sumLengthInMap({
            "1": [1, 2, 3],
            "2": [4, 5],
            "3": [6, 7, 8]
          }),
          8);

      expect(
          Maps.sumLengthInMap({
            "1": [1, 2, 3],
            "2": [4, 5],
            "3": [6, 7, 8],
            "4": [9, 10],
            "5": [],
            "6": [11, 12]
          }),
          12);
    });

    test("Modulo de servicio de pronostico de probabilidad de lluvia",
        () async {
      // consulta el servicio de pronostico de tiempo para 8 dias
      expect(
          await POP
              .popEightDays("8.3457", "-62.6501",
                  "38ff661b277d2131d9510cff179ec0e3" /*Personal Api Key*/)
              .then((data) => !data.containsKey("Error")),
          true);
    });
  });
}
