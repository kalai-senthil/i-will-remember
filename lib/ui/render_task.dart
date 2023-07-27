import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder/models/tasks.dart';

class RenderTask extends HookWidget {
  const RenderTask({super.key, required this.task, required this.index});
  final Tasks task;
  final int index;
  @override
  Widget build(BuildContext context) {
    final slide = useAnimationController(
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    final fade = useAnimationController(
      duration: const Duration(
        milliseconds: 500,
      ),
      initialValue: 0,
      lowerBound: 0,
      upperBound: 1,
    );
    final slideAnimation = useMemoized(() =>
        Tween(begin: const Offset(0, .5), end: Offset.zero).animate(slide));
    final fadeAnimation =
        useMemoized(() => Tween(begin: 0.0, end: 1.0).animate(fade));
    useEffect(() {
      Future.delayed(
          Duration(
            milliseconds: (index + 1) * 100,
          ), () {
        slide.forward();
        fade.forward();
      });
      return null;
    }, [slide]);
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: ListTile(
          leading: const Icon(
            Icons.check_circle_outlined,
          ),
          title: Text(
            task.task,
            style: GoogleFonts.quicksand(
              decoration: task.enabled
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
        ),
      ),
    );
  }
}
