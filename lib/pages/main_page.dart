import 'package:colasol/animations/select_target_animation.dart';
import 'package:colasol/pages/color_check_page.dart';
import 'package:colasol/pages/color_code_page.dart';
import 'package:colasol/pages/color_select_page.dart';
import 'package:colasol/pages/random_page.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:colasol/widgets/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  final int maxHorizontal = 50;
  final int maxVertical = 100;
  MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageViewController = PageController();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(bottomNavigationBarIndexProvider),
        onTap: (int index) {
          ref.read(bottomNavigationBarIndexProvider.notifier).setIndex(index);
          pageViewController.animateToPage(index,
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
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1.0,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
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
                                        .read(textObjectListProvider.notifier)
                                        .reset();
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
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 75,
                      decoration: BoxDecoration(
                        color: MyTheme.blueGrey,
                        border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: Colors.black.withOpacity(0.3))),
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SelectTargetAnimation(
                              child: DragTarget(
                                onAccept: (Color color) {
                                  ref
                                      .read(selectedColorsProvider.notifier)
                                      .setColor('color${index + 1}', color);
                                },
                                builder:
                                    (context, candidateData, rejectedData) =>
                                        Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width / 5 -
                                            2,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: ref.watch(lightModeProvider)
                                              ? Colors.white
                                              : Colors.black.withOpacity(0.8)),
                                      color: ref.watch(selectedColorsProvider)[
                                          'color${index + 1}'],
                                    ),
                                    child: Align(
                                        alignment: const Alignment(0.7, 0.5),
                                        child: Transform.rotate(
                                          angle: -0.2,
                                          child: Text(
                                            'color${index + 1}',
                                            style: TextStyle(
                                              color:
                                                  ref.watch(lightModeProvider)
                                                      ? Colors.white
                                                      : Colors.black,
                                              // fontSize: 20,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                  controller: pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RandomPage(),
                    ColorSelectPage(),
                    ColorCheckPage(),
                    ColorCodePage(),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
