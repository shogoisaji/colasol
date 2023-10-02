import 'package:colasol/config/config.dart';
import 'package:colasol/model/scale_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

// selected colors , show upper 5 items
@riverpod
class SelectedColors extends _$SelectedColors {
  @override
  Map<String, Color> build() => {
        'color1': Colors.black.withOpacity(0.0),
        'color2': Colors.black.withOpacity(0.025),
        'color3': Colors.black.withOpacity(0.05),
        'color4': Colors.black.withOpacity(0.075),
        'color5': Colors.black.withOpacity(0.1),
      };

  void setColor(String index, Color color) => state[index] = color;

  void resetColor() => state = {
        'color1': Colors.black.withOpacity(0.0),
        'color2': Colors.black.withOpacity(0.025),
        'color3': Colors.black.withOpacity(0.05),
        'color4': Colors.black.withOpacity(0.075),
        'color5': Colors.black.withOpacity(0.1),
      };
}

// index 0~3
@riverpod
class bottomNavigationBarIndex extends _$bottomNavigationBarIndex {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}

@riverpod
class scaleState extends _$scaleState {
  @override
  ScaleType build() => ScaleType.scale1;

  void chengeScale() {
    switch (state) {
      case ScaleType.scale1:
        state = ScaleType.scale2;
        break;
      case ScaleType.scale2:
        state = ScaleType.scale3;
        break;
      case ScaleType.scale3:
        state = ScaleType.scale1;
        ref.read(selectedCoordinateProvider.notifier).selectCoordinate(0, 0);
        break;
    }
  }
}

@riverpod
class selectedCoordinate extends _$selectedCoordinate {
  @override
  Map<String, int> build() => {'x': 0, 'y': 0};

  void selectCoordinate(int x, int y) => state = {'x': x, 'y': y};
}
