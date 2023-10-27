import 'package:colasol/model/color_hsv.dart';
import 'package:colasol/state/state.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorCodePage extends ConsumerWidget {
  const ColorCodePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onShareHex(BuildContext context) {
      var selectedColors = ref.watch(selectedColorsProvider);
      String shareText = '';
      for (Color color in selectedColors.values) {
        shareText = '$shareText$color\n';
      }
      Clipboard.setData(ClipboardData(text: shareText));
      // snack bar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.copy,
              color: Colors.white,
            ),
            Text(
              'Copy',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: MyTheme.blue,
      ));
    }

    void onShareRGB(BuildContext context) {
      var selectedColors = ref.watch(selectedColorsProvider);
      String shareText = '';
      for (Color color in selectedColors.values) {
        String rgb = '(${color.red},${color.green},${color.blue})';
        shareText = '$shareText$rgb\n';
      }
      Clipboard.setData(ClipboardData(text: shareText));
      // snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copy,
                color: Colors.white,
              ),
              Text(
                'Copy',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: MyTheme.blue,
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 335,
                  width: MediaQuery.of(context).size.width / 1.7,
                  padding: const EdgeInsets.all(24),
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'H e x',
                          style: TextStyle(fontSize: 24, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            Color selectedColor = ref.watch(
                                    selectedColorsProvider)['color${index + 1}']
                                as Color;

                            return Align(
                              child: Container(
                                height: 50,
                                color: selectedColor,
                                child: Center(
                                    child: SelectableText(
                                  style: TextStyle(
                                      color: ColorHelper()
                                              .isDarkColor(selectedColor)
                                          ? Colors.white
                                          : Colors.black),
                                  selectedColor.value.toRadixString(16) == '0'
                                      ? '000000'
                                      : selectedColor.value
                                          .toRadixString(16)
                                          .substring(2),
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
                  width: 12,
                ),
                InkWell(
                  onTap: () {
                    onShareHex(context);
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyTheme.lightGrey1,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1.0,
                              blurRadius: 5,
                              offset: const Offset(2.5, 2.5),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(1.0),
                              spreadRadius: 1.5,
                              blurRadius: 3,
                              offset: const Offset(-2.5, -2.5),
                            ),
                          ]),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 28,
                      )),
                )
              ]),
          const SizedBox(
            height: 32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 335,
                width: MediaQuery.of(context).size.width / 1.7,
                padding: const EdgeInsets.all(24),
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('R G B',
                          style: TextStyle(fontSize: 24, color: Colors.grey)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          Color selectedColor = ref.watch(
                                  selectedColorsProvider)['color${index + 1}']
                              as Color;
                          return Align(
                            child: Container(
                                height: 50,
                                color: selectedColor,
                                child: Center(
                                  child: SelectableText(
                                    style: TextStyle(
                                        color: ColorHelper()
                                                .isDarkColor(selectedColor)
                                            ? Colors.white
                                            : Colors.black),
                                    '(${selectedColor.red}, ${selectedColor.green}, ${selectedColor.blue})',
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  onShareRGB(context);
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyTheme.lightGrey1,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1.0,
                            blurRadius: 5,
                            offset: const Offset(2.5, 2.5),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(1.0),
                            spreadRadius: 1.5,
                            blurRadius: 3,
                            offset: const Offset(-2.5, -2.5),
                          ),
                        ]),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 28,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
