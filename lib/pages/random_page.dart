import 'dart:math';

import 'package:colasol/animations/drop_animation.dart';
import 'package:colasol/animations/grab_animation.dart';
import 'package:colasol/animations/appear_animation.dart';
import 'package:colasol/config/config.dart';
import 'package:colasol/model/randomColorObject.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

  final int count = maxRandomHorizontal * maxRandomVertical;

  late List<Map<String, dynamic>> randomObjectArray;

  void setArray() {
    randomObjectArray = List.generate(
        maxRandomHorizontal * maxRandomVertical,
        (index) => RandomColorObject(
              index: index,
            ).getObject());
    randomObjectArray.shuffle();

    Future.microtask(() => ref
        .read(randomColorObjectArrayProvider.notifier)
        .setArray(randomObjectArray));
  }

  @override
  void initState() {
    super.initState();
    setArray();

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
                    setArray();
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
        ],
      ),
    );
  }
}
