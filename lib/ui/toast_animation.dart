import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ToastAnimation extends HookWidget {
  const ToastAnimation({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final sv = useAnimationController(
      duration: const Duration(milliseconds: 400),
      lowerBound: 0,
      initialValue: 0,
      upperBound: 1,
    )..fling();
    return ScaleTransition(
      scale: sv,
      child: child,
    );
  }
}
