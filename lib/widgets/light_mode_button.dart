import 'package:colasol/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LightModeButton extends ConsumerWidget {
  const LightModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ref.watch(lightModeProvider)
              ? Colors.blue[50]
              : Colors.blueGrey[900],
          boxShadow: [
            BoxShadow(
              color: ref.watch(lightModeProvider)
                  ? Colors.black.withOpacity(0.4)
                  : Colors.grey.withOpacity(1.0),
              spreadRadius: 3.0,
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ref.watch(lightModeProvider)
            ? const Icon(Icons.sunny, color: Colors.orange, size: 40)
            : const Icon(Icons.nightlight_round_sharp,
                color: Colors.yellow, size: 40));
  }
}
