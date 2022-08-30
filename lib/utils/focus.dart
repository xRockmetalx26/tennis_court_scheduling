import 'package:flutter/material.dart';

class Focus {
  void requestFocus(BuildContext context, FocusNode focus) =>
      FocusScope.of(context).requestFocus(focus);
}
