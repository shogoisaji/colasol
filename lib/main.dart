import 'package:colasol/pages/main_page.dart';
import 'package:colasol/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: MyTheme.lightGrey2,
          fontFamily: 'NotoSansJP',
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
