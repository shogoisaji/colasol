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
    if (x < 0 || x > 360 || y < -1 || y > 1) return Colors.white;
    // negative -> change saturation
    if (isLightMode) {
      saturation = y;
      value = 1.0;
      // positive -> change value
    } else {
      saturation = 1.0;
      value = y;
    }
    return HSVColor.fromAHSV(1.0, x, saturation, value).toColor();
  }

  Color getDetailColor(double x, double y, Color color) {
    final double hue = colorToHSV(color)['hue'] as double;
    final double saturation = colorToHSV(color)['saturation'] as double;
    final double value = colorToHSV(color)['value'] as double;
    final double updateHue = (hue - (x - 45)) % 360.abs();
    late double updateSaturation;
    late double updateValue;
    if (saturation > 0.0) {
      updateSaturation = saturation + y;
      updateSaturation = updateSaturation > 1 ? 1 : updateSaturation;
      updateSaturation = updateSaturation < 0 ? 0 : updateSaturation;
      updateValue = 1.0;
    } else {
      updateValue = value + y;
      updateValue = updateValue > 1 ? 1 : updateValue;
      updateValue = updateValue < 0 ? 0 : updateValue;
      updateSaturation = 1.0;
    }
    return HSVColor.fromAHSV(1.0, updateHue, updateSaturation, updateValue)
        .toColor();
  }

  Map<String, double> colorToHSV(Color color) {
    double hue = HSVColor.fromColor(color).hue;
    double saturation = HSVColor.fromColor(color).saturation;
    double value = HSVColor.fromColor(color).value;
    return {'hue': hue, 'saturation': saturation, 'value': value};
  }
}
