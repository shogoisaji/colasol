import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class SelectTargetAnimation extends StatelessWidget {
  final Widget child;

  SelectTargetAnimation({super.key, required this.child});

  final scaleX = MovieTweenProperty<double>();
  final scaleY = MovieTweenProperty<double>();

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(scaleY, 5.0.tweenTo(0.0),
          duration: (Random().nextInt(1000) + 1000).milliseconds,
          curve: Curves.easeIn);

    return LoopAnimationBuilder<Movie>(
      duration: tween.duration,
      tween: tween,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, scaleY.from(value)),
          child: child,
        );
      },
      child: child,
    );
  }
}
