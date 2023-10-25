import 'dart:math';

import 'package:flutter/material.dart';

class DropAnimation extends StatefulWidget {
  final Widget child;
  final AnimationController controller;

  DropAnimation({required this.child, required this.controller});

  @override
  _DropAnimationState createState() => _DropAnimationState();
}

class _DropAnimationState extends State<DropAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateYAnimation;

  @override
  void initState() {
    super.initState();

    _opacityAnimation = Tween<double>(
      begin: 0.0, // アニメーション開始時の透明度
      end: 1.0, // アニメーション終了時の透明度
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );

    _translateYAnimation = Tween<double>(
      begin: -30.0, // アニメーション開始時のY座標
      end: 0.0, // アニメーション終了時のY座標
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _translateYAnimation.value),
            child: widget.child,
          ),
        );
      },
    );
  }
}
