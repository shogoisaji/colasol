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

  Color createColorModel(double x, double y) {
    return ColorHelper().coordinateToColor(x, y);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, int> getStartCoordinate() {
      int startX = ref.watch(selectedCoordinateProvider)['x'] as int;
      int startY = ref.watch(selectedCoordinateProvider)['y'] as int;
      print('start $startX:$startY');
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
                        ref
                            .read(selectedCoordinateProvider.notifier)
                            .selectCoordinate(x, y);
                        ref.read(scaleStateProvider.notifier).chengeScale();
                      },
                      child: Draggable(
                        data: createColorModel(
                            360 * x / maxHorizontal * scaleRate,
                            (2 * y - maxVertical) / maxVertical * scaleRate),
                        feedback: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            color: createColorModel(
                                360 * x / maxHorizontal * scaleRate,
                                (2 * y - maxVertical) /
                                    maxVertical *
                                    scaleRate),
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
                              color: createColorModel(
                                  360 *
                                      (x - (startCoordinate['x'] as int)) /
                                      maxHorizontal *
                                      scaleRate,
                                  (2 * (y - startCoordinate['y']! as int) -
                                          maxVertical) /
                                      maxVertical *
                                      scaleRate)),
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
