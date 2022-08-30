import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Attempt {
  static T? syncCall<T>(Function function) {
    try {
      return function();
    } catch (e) {
      log("", error: e.toString());
      return null;
    }
  }

    static Future<T?> asyncCall<T>(Function function) async {
    try {
      return await function();
    } catch (e) {
      log("", error: e.toString());
      return null;
    }
  }
}

