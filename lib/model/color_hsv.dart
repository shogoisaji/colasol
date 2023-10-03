import 'package:colasol/config/config.dart';
import 'package:colasol/model/scale_type.dart';
import 'package:colasol/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Color getDetailColor(int x, int y, Color color) {
    final double hue = colorToHSV(color)['hue'] as double;
    final double saturation = colorToHSV(color)['saturation'] as double;
    final double value = colorToHSV(color)['value'] as double;
    final double updateHue = (hue - (x - 45)) % 360.abs();
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
}
