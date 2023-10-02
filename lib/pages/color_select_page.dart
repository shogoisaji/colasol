import 'package:colasol/config/config.dart';
import 'package:colasol/model/color_hsv.dart';
import 'package:colasol/model/color_model.dart';
import 'package:colasol/model/original_coordinate.dart';
import 'package:colasol/model/scale_type.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorSelectPage extends ConsumerWidget {
  ColorSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color createColor(
      ScaleType scaleType,
      double x,
      double y,
    ) {
      bool isLightMode = ref.watch(lightModeProvider);
      Color tappedColor = ref.watch(tappedColorProvider);
      switch (scaleType) {
        case ScaleType.scale1:
          return ColorHelper().coordinateToColor(x, y, isLightMode);
        case ScaleType.scale2:
          return ColorHelper().getDetailColor(x, y, tappedColor);
        case ScaleType.scale3:
          return ColorHelper().getDetailColor(x, y, tappedColor);
      }
    }

    Map<String, int> getStartCoordinate() {
      int startX = ref.watch(selectedCoordinateProvider)['x'] as int;
      int startY = ref.watch(selectedCoordinateProvider)['y'] as int;
      return {'x': startX, 'y': startY};
    }

    final Map<String, int> startCoordinate = getStartCoordinate();

    final double scaleRate = ref.watch(scaleStateProvider).scaleRateValue;
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
                        Color color = createColor(
                            ref.watch(scaleStateProvider),
                            360 * x / maxHorizontal * scaleRate,
                            y / maxVertical * scaleRate);
                        ref.read(tappedColorProvider.notifier).setColor(color);
                        ref.read(scaleStateProvider.notifier).changeScale();
                      },
                      child: Draggable(
                        data: createColor(
                            ref.watch(scaleStateProvider),
                            360 * x / maxHorizontal * scaleRate,
                            y / maxVertical * scaleRate),
                        feedback: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            color: createColor(
                                ref.watch(scaleStateProvider),
                                360 * x / maxHorizontal * scaleRate,
                                y / maxVertical * scaleRate),
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
                            color: createColor(
                                ref.watch(scaleStateProvider),
                                360 * x / maxHorizontal * scaleRate,
                                y / maxVertical * scaleRate),
                          ),
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
