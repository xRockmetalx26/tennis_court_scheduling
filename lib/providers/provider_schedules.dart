import 'dart:convert';

import 'package:agendamiento_canchas/models/schedule.dart';
import 'package:agendamiento_canchas/utils/flutter_files.dart';
import 'package:flutter/material.dart';

class ProviderSchedules extends ChangeNotifier {
  ProviderSchedules() {
    _loadSchedules();
  }

  bool addShedule(Schedule schedule) {
    var isAdded = false;

    if (schedules[schedule.tennisCourt]!.containsKey(schedule.date)) {
      if (schedules[schedule.tennisCourt]![schedule.date]!.length < 3) {
        schedules[schedule.tennisCourt]![schedule.date]!.add(schedule);

        isAdded = true;
      }
    } else {
      schedules[schedule.tennisCourt]![schedule.date] = [schedule];

      isAdded = true;
    }

    if (isAdded) {
      updateShedules();
      notifyListeners();
    }

    return isAdded;
  }

  void removeSchedule(Schedule schedule) {
    schedules[schedule.tennisCourt]![schedule.date]!.remove(schedule);

    if (schedules[schedule.tennisCourt]![schedule.date]!.isEmpty) {
      schedules[schedule.tennisCourt]!.remove(schedule.date);
    }

    updateShedules();
    notifyListeners();
  }

  void updateShedules() => FlutterFiles.write(filename, jsonEncode(schedules));

  Future<Map<String, dynamic>?> _readSchedules() async {
    final encodeData = (await FlutterFiles.read(filename))!;

    final data = json.decode(encodeData) as Map<String, dynamic>;

    return data;
  }

  void _loadSchedules() async {
    if (!await FlutterFiles.exists(filename)) {
      FlutterFiles.write(filename, json.encode(schedules));
      return;
    }

    final encodeData = await _readSchedules();
    if (encodeData == null) return;

    final schedulesList = await mapToList(encodeData);

    for (final schedule in schedulesList) {
      addShedule(Schedule.fromJson(schedule));
    }
  }

  Future<List<dynamic>> mapToList(Map<String, dynamic> map) async {
    final scheduleList = map.values
        .expand((listMap) => listMap.values)
        .expand((scheduleList) => scheduleList)
        .toList();

    return scheduleList;
  }

  static const filename = "schedules.txt";
  static const tennisCourts = {"A", "B", "C"};
  Map<String, Map<String, List<Schedule>>> schedules = {
    "A": {},
    "B": {},
    "C": {}
  };
}
