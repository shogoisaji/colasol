import 'dart:math';

import 'package:flutter/material.dart';

class ColorHelper {
  double hue = 360.0; // 色相
  double saturation = 1.0; // 彩度
  double value = 1.0; // 明度

  Color coordinateToColor(double x, double y, bool isLightMode) {
    if (isLightMode) {
      saturation = 1 - y;
      value = 1.0;
    } else {
      saturation = 1.0;
      value = 1 - y;
    }
    return HSVColor.fromAHSV(1.0, x, saturation, value).toColor();
  }

  Color randomColor(bool isLightMode) {
    hue = Random().nextDouble() * 360;

    if (isLightMode) {
      saturation = Random().nextDouble();
      value = 1.0;
    } else {
      saturation = 1.0;
      value = Random().nextDouble();
    }
    return HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
  }

  Color getDetailColor(
      int x, int y, int maxHorizontal, int maxVertical, Color color) {
    final double hue = colorToHSV(color)['hue'] as double;
    final double saturation = colorToHSV(color)['saturation'] as double;
    final double value = colorToHSV(color)['value'] as double;
    final double updateSaturation = saturation - x * saturation / maxHorizontal;
    final double updateValue = value - y * value / maxVertical;

    return HSVColor.fromAHSV(1.0, hue, updateSaturation, updateValue).toColor();
  }

  Map<String, double> colorToHSV(Color color) {
    double hue = HSVColor.fromColor(color).hue;
    double saturation = HSVColor.fromColor(color).saturation;
    double value = HSVColor.fromColor(color).value;
    return {'hue': hue, 'saturation': saturation, 'value': value};
  }

  bool isDarkColor(Color color) {
    return colorToHSV(color)['value'] as double < 0.5;
  }
}
