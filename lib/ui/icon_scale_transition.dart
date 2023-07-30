import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomIconTransition extends HookWidget {
  const CustomIconTransition({
    super.key,
    required this.value,
    required this.icon1,
    required this.icon2,
    required this.onPressed,
  });
  final bool value;
  final Widget icon1;
  final Widget icon2;
  final Future Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final scaleController = useAnimationController(
      duration: const Duration(
        milliseconds: 300,
      ),
      reverseDuration: const Duration(milliseconds: 200),
      initialValue: 0,
      lowerBound: 0,
      upperBound: 1,
    )..fling();
    return ScaleTransition(
      scale: scaleController,
      child: IconButton(
        onPressed: () {
          scaleController.reverse();
          Future.delayed(
            const Duration(milliseconds: 300),
            () {
              onPressed!().then((value) => scaleController.fling());
            },
          );
        },
        icon: value ? icon1 : icon2,
      ),
    );
  }
}
