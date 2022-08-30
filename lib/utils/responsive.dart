import 'dart:math';
import 'package:flutter/material.dart';

class Responsive {
  Responsive(final BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = sqrt(pow(_width, 2) + pow(_height, 2));
  }

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;

  double getWidthPercentage(final double percentage) => _width * percentage / 100.0;
  double getHeightPercentage(final double percentage) => _height * percentage / 100.0;
  double getDiagonalPercentage(final double percentage) => _diagonal * percentage / 100.0;

  late final double _width;
  late final double _height;
  late final double _diagonal;
}
