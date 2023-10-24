import 'dart:math';

import 'package:colasol/animations/drop_animation.dart';
import 'package:colasol/animations/grab_animation.dart';
import 'package:colasol/config/config.dart';
import 'package:colasol/model/randomColorObject.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:colasol/widgets/light_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RandomPage extends ConsumerStatefulWidget {
  RandomPage({Key? key}) : super(key: key);

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends ConsumerState<RandomPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool lightMode = true;

  final int count = maxRandomHorizontal * maxRandomVertical;

  late List<Map<String, dynamic>> randomObjectArray;

  void setRandomArray() {
    randomObjectArray = List.generate(
        maxRandomHorizontal * maxRandomVertical,
        (index) => RandomColorObject(
              index: index,
              lightMode: lightMode,
            ).getObject());
    randomObjectArray.shuffle();
    debugPrint(lightMode.toString());

    Future.microtask(() => ref
        .read(randomColorObjectArrayProvider.notifier)
        .setArray(randomObjectArray));
  }

  @override
  void initState() {
    super.initState();
    setRandomArray();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ref.watch(lightModeProvider) ? Colors.black : Colors.white,
      child: Stack(
        children: [
          for (int i = 0; i < count; i++) ...{
            Align(
                alignment: Alignment(
                    randomObjectArray[i]['x'], randomObjectArray[i]['y']),
                child: DropAnimation(
                    controller: _controller,
                    child: Draggable(
                      data: randomObjectArray[i]['color'] as Color,
                      feedback: DragAnimation(
                        child: SizedBox(
                          width: 100,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(300),
                                color: randomObjectArray[i]['color'] as Color,
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
                  setState(() {
                    setRandomArray();
                    _controller.reset();
                    _controller.forward();
                  });
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
                    ref.read(lightModeProvider.notifier).changeMode();
                    setState(() {
                      lightMode = ref.watch(lightModeProvider);
                      setRandomArray();
                      _controller.reset();
                      _controller.forward();
                    });
                  },
                  child: const LightModeButton(),
                )),
          ),
        ],
      ),
    );
  }
}
