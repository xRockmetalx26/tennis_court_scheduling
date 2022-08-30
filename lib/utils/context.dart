import 'package:flutter/material.dart';

extension ExtensionBuildContext on BuildContext {
  pop() => Navigator.of(this).pop();
  popUntil(String route) =>
      Navigator.of(this).popUntil(ModalRoute.withName(route));

  requestFocus(FocusNode focus) => FocusScope.of(this).requestFocus(focus);
  push(String route) => Navigator.of(this).pushNamed(route);
}
