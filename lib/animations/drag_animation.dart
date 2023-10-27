import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class DragAnimation extends StatelessWidget {
  final Widget child;

  DragAnimation({super.key, required this.child});

  final scaleX = MovieTweenProperty<double>();
  final scaleY = MovieTweenProperty<double>();

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(scaleX, 1.5.tweenTo(2.2),
          duration: 700.milliseconds, curve: Curves.easeIn);

    return LoopAnimationBuilder<Movie>(
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
