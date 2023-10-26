import 'dart:math';

import 'package:colasol/animations/drop_animation.dart';
import 'package:colasol/animations/grab_animation.dart';
import 'package:colasol/config/config.dart';
import 'package:colasol/model/randomColorObject.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:colasol/widgets/light_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RandomPage extends HookConsumerWidget {
  RandomPage({super.key});

  final int count = maxRandomHorizontal * maxRandomVertical;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    void setRandomArray() {
      List<Map<String, dynamic>> generateArray = List.generate(
          maxRandomHorizontal * maxRandomVertical,
          (index) => RandomColorObject(
                index: index,
                lightMode: ref.read(lightModeProvider),
              ).getObject());
      generateArray.shuffle();

      Future.microtask(() => ref
          .read(randomColorObjectArrayProvider.notifier)
          .setArray(generateArray));
    }

    useEffect(() {
      setRandomArray();
      animationController.forward();
      return () {};
    }, [ref.watch(lightModeProvider), ref.watch(randomShuffleProvider)]);

    final List<Map<String, dynamic>> randomObjectArray =
        ref.watch(randomColorObjectArrayProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ref.watch(lightModeProvider) ? Colors.black : Colors.white,
      child: Stack(
        children: [
          if (randomObjectArray.isNotEmpty)
            for (int i = 0; i < count; i++) ...{
              DropAnimation(
                  controller: animationController,
                  child: Align(
                      alignment: Alignment(
                          randomObjectArray[i]['x'], randomObjectArray[i]['y']),
                      child: Draggable(
                        data: randomObjectArray[i]['color'] as Color,
                        feedback: DragAnimation(
                          child: Container(
                            width: MediaQuery.of(context).size.width /
                                    maxRandomHorizontal +
                                50,
                            height: MediaQuery.of(context).size.width /
                                    maxRandomHorizontal +
                                50,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 100,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(300),
                                    color:
                                        randomObjectArray[i]['color'] as Color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width /
                                  maxRandomHorizontal +
                              Random().nextDouble() * 100,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1.0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(300),
                                color: randomObjectArray[i]['color'] as Color,
                              ),
                            ),
                          ),
                        ),
                      )))
            },
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  animationController.reset();
                  ref.read(randomShuffleProvider.notifier).shuffle();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                ),
                child: const Text(
                  'SHUFFLE',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    animationController.reset();
                    ref.read(lightModeProvider.notifier).changeMode();
                    ref.read(randomShuffleProvider.notifier).shuffle();
                  },
                  child: const LightModeButton(),
                )),
          ),
        ],
      ),
    );
  }
}
