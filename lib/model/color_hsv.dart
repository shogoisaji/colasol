import 'package:flutter/material.dart';

class ColorHelper {
  double hue = 360.0; // 色相
  double saturation = 1.0; // 彩度
  double value = 1.0; // 明度

  Color coordinateToColor(double x, double y) {
    if (x < 0 || x > 360 || y < -1 || y > 1) return Colors.white;
    // negative -> chenge sateration
    if (y < 0) {
      saturation = 1.0 + y;
      value = 1.0;
      if (saturation < 0) {}
      // positive -> chenge value
    } else {
      saturation = 1.0;
      value = 1 - y;
    }
    return HSVColor.fromAHSV(1.0, x, saturation, value).toColor();
  }

  static double colorToHue(Color color) => HSVColor.fromColor(color).hue;
}
