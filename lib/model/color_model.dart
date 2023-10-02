import 'package:colasol/config/config.dart';
import 'package:flutter/material.dart';

// 0~1536で色相、明度を表現
// 今回は未使用
class ColorModel {
  // original is 0~1536(6*256)
  final int originalIndexX; // 色相
  final int originalIndexY; // 明度

  ColorModel({
    required this.originalIndexX,
    required this.originalIndexY,
  });

// index is 0~1536　rgb
  Color getColor() {
    int r = 0;
    int g = 0;
    int b = 0;
    int type = originalIndexX ~/ 256;
    switch (type) {
      case 0:
        r = 255;
        g = 0;
        b = originalIndexX % 256;
        break;
      case 1:
        r = 255 - (originalIndexX % 256);
        g = 0;
        b = 255;
        break;
      case 2:
        r = 0;
        g = originalIndexX % 256;
        b = 255;
        break;
      case 3:
        r = 0;
        g = 255;
        b = 255 - (originalIndexX % 256);
        break;
      case 4:
        r = originalIndexX % 256;
        g = 255;
        b = 0;
        break;
      case 5:
        r = 255;
        g = 255 - (originalIndexX % 256);
        b = 0;
        break;
    }
    int red = r + (originalIndexY / maxIndex * (255 - r)).toInt();
    int green = g + (originalIndexY / maxIndex * (255 - g)).toInt();
    int blue = b + (originalIndexY / maxIndex * (255 - b)).toInt();
    return Color.fromARGB(255, red, green, blue);
  }
}
