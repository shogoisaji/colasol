import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:colasol/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorListPagge extends ConsumerWidget {
  const ColorListPagge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Container(
            height: 298,
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: MyTheme.lightGrey1,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1.0,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(1.0),
                    spreadRadius: 1.5,
                    blurRadius: 3,
                    offset: const Offset(-3, -3),
                  ),
                ]),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      Color selectedColor =
                          ref.watch(selectedColorsProvider)['color${index + 1}']
                              as Color;
                      return Align(
                        child: Container(
                          height: 50,
                          color: selectedColor,
                          child: Center(
                              child: Text(
                            selectedColor.value.toRadixString(16),
                          )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            height: 298,
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: MyTheme.lightGrey1,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1.0,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(1.0),
                    spreadRadius: 1.5,
                    blurRadius: 3,
                    offset: const Offset(-3, -3),
                  ),
                ]),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      Color selectedColor =
                          ref.watch(selectedColorsProvider)['color${index + 1}']
                              as Color;
                      return Align(
                        child: Container(
                            height: 50,
                            color: selectedColor,
                            child: Center(
                              child: Text(
                                'RGB(${selectedColor.red}, ${selectedColor.green}, ${selectedColor.blue})',
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
