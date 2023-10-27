import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class OnceScaleUpAnimation extends StatelessWidget {
  final Widget child;

  OnceScaleUpAnimation({required this.child});

  final scaleX = MovieTweenProperty<double>();

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(scaleX, 0.5.tweenTo(2),
          duration: 500.milliseconds, curve: Curves.easeIn);

    return PlayAnimationBuilder<Movie>(
      duration: tween.duration,
      tween: tween,
      builder: (context, value, child) {
        return Transform.scale(
          scale: scaleX.from(value),
          child: child,
        );
      },
      child: child,
    );
  }
}
