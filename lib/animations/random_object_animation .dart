import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class RandomObjectAnimation extends StatelessWidget {
  final Widget child;

  RandomObjectAnimation({super.key, required this.child});

  final scaleY = MovieTweenProperty<double>();
  final scaleX = MovieTweenProperty<double>();

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(scaleY, 0.0.tweenTo(10.0),
          duration: (Random().nextInt(2000) + 2000).milliseconds,
          curve: Curves.easeIn)
      ..tween(scaleX, 0.0.tweenTo(5.0),
          duration: (Random().nextInt(1000) + 1000).milliseconds,
          curve: Curves.easeIn);

    return MirrorAnimationBuilder<Movie>(
      duration: tween.duration,
      tween: tween,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(scaleX.from(value), scaleY.from(value)),
          child: child,
        );
      },
      child: child,
    );
  }
}
