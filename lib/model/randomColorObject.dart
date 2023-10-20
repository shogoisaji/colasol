import 'dart:math';

import 'package:colasol/config/config.dart';
import 'package:colasol/model/color_hsv.dart';
import 'package:flutter/material.dart';

class RandomColorObject {
  final int index;

  RandomColorObject({required this.index});

  Map<String, dynamic> getObject() {
    double x =
        2.2 * ((index % maxRandomHorizontal) / (maxRandomHorizontal - 1)) - 1.1;
    double y =
        2.2 * (index ~/ (maxRandomHorizontal)) / (maxRandomVertical - 1) - 1.1;
    // add random
    x = x + (2 * Random().nextDouble() - 1) / 10;
    y = y + (2 * Random().nextDouble() - 1) / 10;
    Color color = ColorHelper().randomColor(true);
    return {
      'x': x,
      'y': y,
      'color': color,
    };
  }
}
