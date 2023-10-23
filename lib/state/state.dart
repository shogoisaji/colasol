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
        'color1': Colors.white,
        'color2': Colors.white,
        'color3': Colors.white,
        'color4': Colors.white,
        'color5': Colors.white,
      };

  void setColor(String index, Color color) => state[index] = color;

  void resetColor() => state = {
        'color1': Colors.white,
        'color2': Colors.white,
        'color3': Colors.white,
        'color4': Colors.white,
        'color5': Colors.white,
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

  void changeScale() {
    switch (state) {
      case ScaleType.scale1:
        state = ScaleType.scale2;
        break;
      case ScaleType.scale2:
        state = ScaleType.scale1;
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

@riverpod
class tappedColor extends _$tappedColor {
  @override
  Color build() => Colors.transparent;

  void setColor(Color color) => state = color;
  void resetColor() => state = Colors.transparent;
}

@riverpod
class tapState extends _$tapState {
  @override
  bool build() => false;

  void tapped() => state = !state;
  // void untapped() => state = false;
}

@riverpod
class tappedCoordinate extends _$tappedCoordinate {
  @override
  Map<String, double> build() => {'x': 0, 'y': 0};

  void tap(double x, double y) => state = {'x': x, 'y': y};
}

@riverpod
class lightMode extends _$lightMode {
  @override
  bool build() => true;

  void changeMode() => state = !state;
}

@riverpod
class randomShuffle extends _$randomShuffle {
  @override
  bool build() => true;

  void shuffle() => state = !state;
}

@riverpod
class longPressPosition extends _$longPressPosition {
  @override
  Map<String, double> build() => {'x': 0, 'y': 0};

  void changePosition(double x, double y) => state = {'x': x, 'y': y};
}

@riverpod
class randomColorObjectArray extends _$randomColorObjectArray {
  @override
  List<Map<String, dynamic>> build() => [];

  void setArray(List<Map<String, dynamic>> array) => state = array;
}
