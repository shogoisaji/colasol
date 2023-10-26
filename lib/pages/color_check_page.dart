import 'dart:math';

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

    final shuffleContainer = useState<List<Widget>>([]);
    final shuffleTextObject = useState<List<Widget>>([]);

    void objectShuffle() {
      List<Widget> generateShuffleContainer = List.generate(itemCount, (index) {
        return Align(
          alignment: Alignment(
              2 * Random().nextDouble() - 1, 2 * Random().nextDouble() - 1),
          child: Transform.rotate(
            angle: 2 * pi * Random().nextDouble(),
            child: Container(
                width: 100 + 200 * Random().nextDouble(),
                height: 200 + 200 * Random().nextDouble(),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(8 + 80 * Random().nextDouble()),
                  color: ref
                      .watch(selectedColorsProvider)['color${index % 5 + 1}'],
                )),
          ),
        );
      });

      List<Widget> generateShuffleTextObject =
          List.generate(itemCount - 5, (index) {
        return Align(
            alignment: Alignment(
                2 * Random().nextDouble() - 1, 2 * Random().nextDouble() - 1),
            child: Transform.rotate(
                angle: 2 * pi * Random().nextDouble(),
                child: Text(
                  'Color',
                  style: TextStyle(
                      color: ref.watch(
                          selectedColorsProvider)['color${index % 5 + 1}'],
                      fontSize: 72 + 72 * Random().nextDouble(),
                      fontWeight: FontWeight.bold),
                )));
      });

      final newShuffleContainer = generateShuffleContainer;
      final newShuffleTextObject = generateShuffleTextObject;
      shuffleContainer.value = newShuffleContainer;
      shuffleTextObject.value = newShuffleTextObject;
    }

    useEffect(() {
      objectShuffle();
      return () {};
    }, [ref.watch(randomShuffleProvider)]);

    return Stack(children: [
      ...shuffleContainer.value,
      ...shuffleTextObject.value,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            ),
            child: const Text(
              'SHUFFLE',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    ]);
  }
}
