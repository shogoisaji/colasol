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
    final int itemCount = MediaQuery.of(context).size.width > 800 ? 15 : 10;

    // final shuffleContainer = useState<List<Widget>>([]);
    // final textObjectList = useState<List<TextObject>>([]);

    void setTextObject() {
      List<TextObject> generateTextObject =
          List.generate(selectTargetCount, (index) {
        return TextObject(
          text: 'Color${index + 1}',
          color: ref.watch(selectedColorsProvider)[
              'color${index % selectTargetCount + 1}'] as Color,
          x: MediaQuery.of(context).size.width / 2 -
              200 +
              Random().nextDouble() * 100,
          y: (index) *
                  (MediaQuery.of(context).size.height - 200) /
                  selectTargetCount +
              50,
        );
      });
      ref.watch(textObjectListProvider.notifier).setList(generateTextObject);
      // textObjectList.value = generateTextObject;
    }

    useEffect(() {
      // build後に実行
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setTextObject();
      });
      return () {};
    }, []);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
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
        // ...shuffleContainer.value,
        ...List.generate(5, (index) {
          return Positioned(
            top: ref.watch(textObjectListProvider)[index].y,
            left: ref.watch(textObjectListProvider)[index].x,
            child: Text(ref.watch(textObjectListProvider)[index].text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36 + Random().nextDouble() * 36,
                    color: ref.watch(textObjectListProvider)[index].color)),
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
