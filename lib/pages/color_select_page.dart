import 'dart:math';

import 'package:colasol/animations/grab_animation.dart';
import 'package:colasol/animations/appear_animation.dart';
import 'package:colasol/config/config.dart';
import 'package:colasol/model/color_hsv.dart';
import 'package:colasol/model/scale_type.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/widgets/light_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorSelectPage extends HookConsumerWidget {
  ColorSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int maxHorizontal = MediaQuery.of(context).size.width ~/ itemSize;
    final int maxVertical =
        (MediaQuery.of(context).size.height - 150) ~/ itemSize;
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    Animatable<double> _animatable = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).chain(
      CurveTween(
        curve: Curves.easeIn,
      ),
    );

    Animation<double> _tapAnimation = _animatable.animate(animationController);

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
          return ColorHelper()
              .getDetailColor(x, y, maxHorizontal, maxVertical, tappedColor);
      }
    }

    Map<String, int> getStartCoordinate() {
      int startX = ref.watch(selectedCoordinateProvider)['x'] as int;
      int startY = ref.watch(selectedCoordinateProvider)['y'] as int;
      return {'x': startX, 'y': startY};
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ref.watch(lightModeProvider) ? Colors.black : Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              for (int y = 0; y < maxVertical; y++) ...{
                Row(
                  children: [
                    for (int x = 0; x < maxHorizontal; x++) ...{
                      GestureDetector(
                          onTap: () {
                            Color color = createColor(
                                ref.watch(scaleStateProvider), x, y);
                            ref
                                .read(tappedColorProvider.notifier)
                                .setColor(color);
                            ref.read(scaleStateProvider.notifier).changeScale();
                            ref.read(tapStateProvider.notifier).tapped();
                            if (ref.watch(scaleStateProvider) ==
                                ScaleType.scale2) {
                              animationController.forward();
                              animationController.addStatusListener((status) {
                                if (status == AnimationStatus.completed) {
                                  animationController.reset();
                                }
                              });
                            }
                          },
                          onTapDown: (details) {
                            //tap座標を取得
                            final x = details.globalPosition.dx;
                            final y = details.globalPosition.dy;
                            ref
                                .read(tappedCoordinateProvider.notifier)
                                .tap(x, y);
                          },
                          child: Draggable(
                              data: createColor(
                                  ref.watch(scaleStateProvider), x, y),
                              feedback: DragAnimation(
                                  child: SizedBox(
                                width: itemSize,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    margin: const EdgeInsets.all(margin),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: createColor(
                                          ref.watch(scaleStateProvider), x, y),
                                    ),
                                  ),
                                ),
                              )),
                              child: AppearAnimation(
                                  delay: Random().nextDouble(),
                                  child: SizedBox(
                                    width: itemSize,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        margin: const EdgeInsets.all(margin),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: createColor(
                                              ref.watch(scaleStateProvider),
                                              x,
                                              y),
                                        ),
                                      ),
                                    ),
                                  ))))
                    }
                  ],
                )
              }
            ],
          ),
          IgnorePointer(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: AnimatedBuilder(
                  animation: _tapAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                        offset: Offset(
                          (ref.watch(tappedCoordinateProvider)['x']! - 30) *
                              (1 - animationController.value),
                          (ref.watch(tappedCoordinateProvider)['y']! - 90) *
                              (1 - animationController.value),
                        ),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Transform.scale(
                              scale: animationController.value * 1.2,
                              child: SizedBox(
                                width: itemSize,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: ref
                                              .watch(tappedColorProvider)
                                              .withOpacity(
                                                  animationController.value))),
                                ),
                              ),
                            )));
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () {
                    ref.read(lightModeProvider.notifier).changeMode();
                  },
                  child: const LightModeButton()),
            ),
          ),
        ],
      ),
    );
  }
}
