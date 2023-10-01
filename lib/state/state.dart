import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

// selected colors
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

@riverpod
class bottomNavigationBarIndex extends _$bottomNavigationBarIndex {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}
