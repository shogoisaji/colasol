import 'package:colasol/config/config.dart';
import 'package:colasol/model/color_model.dart';
import 'package:colasol/model/original_coordinate.dart';
import 'package:colasol/model/scale_type.dart';
import 'package:colasol/pages/color_list_page.dart';
import 'package:colasol/pages/color_select_page.dart';
import 'package:colasol/pages/color_test_page.dart';
import 'package:colasol/pages/setting_page.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:colasol/utils/color_util.dart';
import 'package:colasol/widgets/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  // final ScaleType scaleType = ScaleType.scale1;
  OriginalCoordinate initialCoordinate = OriginalCoordinate(0, 0);
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
    ScaleType scaleType = ScaleType.scale1;
    OriginalCoordinate selectedCoordinate = OriginalCoordinate(500, 500);
    Color selectedColor = Colors.white24;
    return Scaffold(
      floatingActionButton: Container(
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32), color: MyTheme.blueGrey),
        child: Visibility(
          visible: ref.watch(bottomNavigationBarIndexProvider) == 0,
          child: FloatingActionButton(
            hoverColor: Colors.transparent,
            hoverElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              ref.read(selectedColorsProvider.notifier).resetColor();
            },
            child: const Center(
              child: Text(
                'RESET',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(bottomNavigationBarIndexProvider),
        onTap: (int index) {
          ref.read(bottomNavigationBarIndexProvider.notifier).setIndex(index);
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
        items: <BottomNavigationBarItem>[
          customBottomNavigationItem(const Icon(Icons.grid_on)),
          customBottomNavigationItem(const Icon(Icons.assignment)),
          customBottomNavigationItem(const Icon(Icons.brush)),
          customBottomNavigationItem(const Icon(Icons.settings)),
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
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          color: ref.watch(
                              selectedColorsProvider)['color${index + 1}'],
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
                ColorSelectPage(),
                ColorListPage(),
                ColorTestPagge(),
                SettingPage(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
