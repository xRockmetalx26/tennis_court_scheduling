import 'package:flutter/material.dart';

class SnackBarManager {
  static show({required BuildContext context, required Widget icon, required Widget message}) {
    final width = MediaQuery.of(context).size.width;

    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left: width * .2, right: width * .2, bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      backgroundColor: Colors.black54,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 15),
          Flexible(child: message)
        ]
      )
    );

    ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(snackBar);
  }
}
