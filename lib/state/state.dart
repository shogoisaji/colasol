import 'package:colasol/config/config.dart';
import 'package:colasol/model/display_type.dart';
import 'package:colasol/model/text_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

// selected colors , show upper 5 items
@riverpod
class SelectedColors extends _$SelectedColors {
  @override
  Map<String, Color> build() => {
        'color1': Colors.transparent,
        'color2': Colors.transparent,
        'color3': Colors.transparent,
        'color4': Colors.transparent,
        'color5': Colors.transparent,
      };

  void setColor(String index, Color color) => state[index] = color;

  void resetColor() => state = {
        'color1': Colors.transparent,
        'color2': Colors.transparent,
        'color3': Colors.transparent,
        'color4': Colors.transparent,
        'color5': Colors.transparent,
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
  DisplayType build() => DisplayType.regular;

  void changeScale() {
    switch (state) {
      case DisplayType.regular:
        state = DisplayType.detail;
        break;
      case DisplayType.detail:
        state = DisplayType.regular;
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

@riverpod
class textObjectList extends _$textObjectList {
  final List<TextObject> initialList = List.generate(selectTargetCount,
      (index) => TextObject(widget: Container(), x: 0, y: 0));
  @override
  List<TextObject> build() => initialList;

  void reset() => state = initialList;

  void setList(List<TextObject> list) => state = list;

  void changeIndex(TextObject textObject, int index) {
    state[index] = textObject;
  }
}
