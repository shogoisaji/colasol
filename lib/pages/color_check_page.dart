import 'dart:math';

import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorCheckPage extends ConsumerStatefulWidget {
  ColorCheckPage({Key? key}) : super(key: key);

  @override
  _ColorCheckPageState createState() => _ColorCheckPageState();
}

class _ColorCheckPageState extends ConsumerState<ColorCheckPage> {
  List<Widget> _buildColorContainers(WidgetRef ref) {
    return List.generate(5, (index) {
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
                color:
                    ref.watch(selectedColorsProvider)['color${index % 5 + 1}'],
              )),
        ),
      );
    });
  }

  List<Widget> _buildColorText(WidgetRef ref) {
    return List.generate(5, (index) {
      return Align(
          alignment: Alignment(
              2 * Random().nextDouble() - 1, 2 * Random().nextDouble() - 1),
          child: Transform.rotate(
              angle: 2 * pi * Random().nextDouble(),
              child: Text(
                'Color',
                style: TextStyle(
                    color: ref
                        .watch(selectedColorsProvider)['color${index % 5 + 1}'],
                    fontSize: 48 + 48 * Random().nextDouble(),
                    fontWeight: FontWeight.bold),
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ..._buildColorContainers(ref),
      ..._buildColorText(ref),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {});
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
