import 'package:colasol/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TappedAnimation extends HookConsumerWidget {
  final Widget child;
  final AnimationController controller;

  const TappedAnimation({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    useAnimation(animationController);

    final isTap = useState(ref.watch(tapStateProvider));

    void handleTapChange(bool isNewTap) {
      if (isNewTap) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }

    useEffect(() {
      animationController.forward();

      handleTapChange(isTap.value);
      return null;
    }, [isTap.value]);

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(animationController.value * 200,
                animationController.value * 200),
            child: child,
          );
        });
  }
}
