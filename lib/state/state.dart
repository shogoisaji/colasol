import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

// selected colors
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

@riverpod
class bottomNavigationBarIndex extends _$bottomNavigationBarIndex {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}
