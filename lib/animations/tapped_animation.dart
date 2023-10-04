import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class TappedAnimation extends HookWidget {
  final Widget child;
  final bool isTapped;

  const TappedAnimation(
      {super.key, required this.child, required this.isTapped});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    useAnimation(animationController);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Align(
          alignment: animation.value,
          child: widget.child,
        );
      },
    );
  }
}
