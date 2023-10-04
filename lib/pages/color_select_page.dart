import 'dart:math';

import 'package:colasol/animations/grab_animation.dart';
import 'package:colasol/animations/point_animation.dart';
import 'package:colasol/animations/tapped_animation.dart';
import 'package:colasol/config/config.dart';
import 'package:colasol/model/color_hsv.dart';
import 'package:colasol/model/scale_type.dart';
import 'package:colasol/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorSelectPage extends ConsumerWidget {
  ColorSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double margin = 2;

    Color createColor(
      ScaleType scaleType,
      int x,
      int y,
    ) {
      bool isLightMode = ref.watch(lightModeProvider);
      Color tappedColor = ref.watch(tappedColorProvider);
      switch (scaleType) {
        case ScaleType.scale1:
          return ColorHelper().coordinateToColor(
              360 * x / maxHorizontal * ScaleType.scale1.scaleRateValue,
              y / maxVertical * ScaleType.scale1.scaleRateValue,
              isLightMode);
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

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
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
                                  ref.watch(scaleStateProvider), x, y);
                              ref
                                  .read(tappedColorProvider.notifier)
                                  .setColor(color);
                              ref
                                  .read(scaleStateProvider.notifier)
                                  .changeScale();
                            },
                            child: Draggable(
                              data: createColor(
                                  ref.watch(scaleStateProvider), x, y),
                              feedback: DragAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: createColor(
                                        ref.watch(scaleStateProvider), x, y),
                                  ),
                                  width: MediaQuery.of(context).size.width /
                                      maxHorizontal *
                                      1.2,
                                  height: MediaQuery.of(context).size.width /
                                      maxHorizontal *
                                      1.2,
                                ),
                              ),
                              child: PointAnimation(
                                delay: Random().nextDouble(),
                                child: Container(
                                  margin: const EdgeInsets.all(margin),
                                  width: (MediaQuery.of(context).size.width -
                                          2 * margin * maxHorizontal) /
                                      maxHorizontal,
                                  height: MediaQuery.of(context).size.width /
                                      maxHorizontal,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: createColor(
                                        ref.watch(scaleStateProvider), x, y),
                                  ),
                                ),
                              ),
                            ))
                      }
                    ],
                  )
                }
              ],
            ),
          ),
          IgnorePointer(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.amber.withOpacity(0.2),
              child: TappedAnimation(
                  isTapped: ref.watch(tappStateProvider),
                  child: IgnorePointer(
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.red,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
