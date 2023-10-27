import 'dart:math';

import 'package:colasol/config/config.dart';
import 'package:colasol/model/text_object.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorCheckPage extends HookConsumerWidget {
  const ColorCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void setTextObject() {
      List<TextObject> generateTextObject =
          List.generate(selectTargetCount, (index) {
        return TextObject(
          widget: Text('Color${index + 1}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 54 + Random().nextDouble() * 54,
                  color: ref.watch(selectedColorsProvider)[
                      'color${index % selectTargetCount + 1}'] as Color)),
          x: Random().nextDouble() * (MediaQuery.of(context).size.width - 200),
          y: (index) *
                  (MediaQuery.of(context).size.height - 200) /
                  selectTargetCount +
              50,
        );
      });
      ref.watch(textObjectListProvider.notifier).setList(generateTextObject);
    }

    useEffect(() {
      // build後に実行
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setTextObject();
      });
      return () {};
    }, [ref.watch(randomShuffleProvider)]);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        Center(
          child: Transform.rotate(
            angle: -pi / 6,
            child: Text('Check\n Color',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 96,
                    color: Colors.black.withOpacity(0.04))),
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            return Expanded(
                flex: 1,
                child: Container(
                  color: ref
                      .watch(selectedColorsProvider)['color${index % 5 + 1}'],
                ));
          }),
        ),
        ...List.generate(5, (index) {
          return Positioned(
            top: ref.watch(textObjectListProvider)[index].y,
            left: ref.watch(textObjectListProvider)[index].x,
            child: Draggable(
              data: index,
              childWhenDragging: Container(),
              feedback: Material(
                color: Colors.transparent,
                child: ref.watch(textObjectListProvider)[index].widget,
              ),
              child: ref.watch(textObjectListProvider)[index].widget,
            ),
          );
        }),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
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
      ]),
    );
  }
}
