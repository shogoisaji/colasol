import 'package:colasol/config/config.dart';
import 'package:colasol/model/color_model.dart';
import 'package:colasol/model/original_coordinate.dart';
import 'package:colasol/model/scale_type.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorSelectPage extends ConsumerWidget {
  OriginalCoordinate initialCoordinate = OriginalCoordinate(0, 0);
  final int maxHorizontal = 12;
  final int maxVertical = 15;
  ColorSelectPage({super.key});

  Color createColorModel(int x, int y) {
    return ColorModel(
      originalIndexX: initialCoordinate.x + x * maxIndex ~/ maxHorizontal,
      originalIndexY: initialCoordinate.x + y * maxIndex ~/ maxVertical,
    ).getColor();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScaleType scaleType = ScaleType.scale1;
    OriginalCoordinate selectedCoordinate = OriginalCoordinate(500, 500);
    Color selectedColor = Colors.white24;
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int y = 0; y < maxVertical; y++) ...{
            Row(
              children: [
                for (int x = 0; x < maxHorizontal; x++) ...{
                  GestureDetector(
                      onTap: () {
                        print('tap  $x:$y');
                      },
                      child: Draggable(
                        data: createColorModel(x, y),
                        feedback: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 246, 246, 246),
                              width: 1,
                            ),
                            color: createColorModel(x, y),
                          ),
                          width: MediaQuery.of(context).size.width /
                              maxHorizontal *
                              1.2,
                          height: MediaQuery.of(context).size.width /
                              maxHorizontal *
                              1.2,
                        ),
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width / maxHorizontal,
                          height:
                              MediaQuery.of(context).size.width / maxHorizontal,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                              color: createColorModel(x, y)),
                        ),
                      ))
                }
              ],
            )
          }
        ],
      ),
    );
  }
}
