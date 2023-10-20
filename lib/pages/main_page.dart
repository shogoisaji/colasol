import 'package:colasol/config/config.dart';
import 'package:colasol/model/color_model.dart';
import 'package:colasol/model/original_coordinate.dart';
import 'package:colasol/pages/color_check_page.dart';
import 'package:colasol/pages/color_list_page.dart';
import 'package:colasol/pages/color_select_page.dart';
import 'package:colasol/pages/random_page.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:colasol/widgets/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  // final ScaleType scaleType = ScaleType.scale1;
  final OriginalCoordinate initialCoordinate = OriginalCoordinate(0, 0);
  final int maxHorizontal = 50;
  final int maxVertical = 100;
  MainPage({super.key});

  Color createColorModel(int x, int y) {
    return ColorModel(
      originalIndexX: initialCoordinate.x + x * maxIndex ~/ maxHorizontal,
      originalIndexY: initialCoordinate.x + y * maxIndex ~/ maxVertical,
    ).getColor();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pageViewController = PageController();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(bottomNavigationBarIndexProvider),
        onTap: (int index) {
          ref.read(bottomNavigationBarIndexProvider.notifier).setIndex(index);
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
        items: <BottomNavigationBarItem>[
          customBottomNavigationItem(const Icon(Icons.category)),
          customBottomNavigationItem(const Icon(Icons.grid_on)),
          customBottomNavigationItem(const Icon(Icons.brush)),
          customBottomNavigationItem(const Icon(Icons.assignment)),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyTheme.blueGrey,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedIconTheme: IconThemeData(size: 36, color: MyTheme.red),
        unselectedIconTheme: const IconThemeData(size: 36, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Reset Colors ?'),
                            actions: [
                              TextButton(
                                child: const Text('cancel',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Reset',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24)),
                                onPressed: () {
                                  ref
                                      .read(selectedColorsProvider.notifier)
                                      .resetColor();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return DragTarget(
                            onAccept: (Color color) {
                              ref
                                  .read(selectedColorsProvider.notifier)
                                  .setColor('color${index + 1}', color);
                            },
                            builder: (context, candidateData, rejectedData) =>
                                Container(
                              width:
                                  (MediaQuery.of(context).size.width - 80) / 5,
                              decoration: BoxDecoration(
                                color: ref.watch(selectedColorsProvider)[
                                    'color${index + 1}'],
                              ),
                              child: Align(
                                  alignment: const Alignment(0.7, 0.5),
                                  child: Transform.rotate(
                                    angle: -0.2,
                                    child: Text(
                                      'color${index + 1}',
                                    ),
                                  )),
                            ),
                          );
                        }),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(lightModeProvider.notifier).changeMode();
                    },
                    child: Container(
                        color: ref.watch(lightModeProvider)
                            ? Colors.blue[100]
                            : Colors.blueGrey[900],
                        height: 60,
                        alignment: Alignment.center,
                        child: ref.watch(lightModeProvider)
                            ? const Icon(Icons.sunny,
                                color: Colors.orange, size: 40)
                            : const Icon(Icons.nightlight_round_sharp,
                                color: Colors.yellow, size: 40)),
                  ),
                ),
              ],
            ),
            Container(
                width: double.infinity,
                height: 2,
                decoration: BoxDecoration(
                    // border: Border(
                    // top: BorderSide(color: Colors.white, width: 0.5),
                    // ),
                    gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.3),
                    Colors.white.withOpacity(0.3)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ))),
            Expanded(
              child: PageView(controller: _pageViewController, children: [
                RandomPage(),
                ColorSelectPage(),
                ColorCheckPage(),
                ColorListPage(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
