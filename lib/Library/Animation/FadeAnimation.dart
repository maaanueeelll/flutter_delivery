import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(
    this.delay,
    this.child,
  );
  @override
  Widget build(BuildContext context) {
    //final tween = MultiTween([
    //  Track("opacity")
    //      .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //  Track("translateY").add(
    //      Duration(milliseconds: 1500), Tween(begin: -30.0, end: 0.0),
    //      curve: Curves.easeOut)
    //]);
    //  final tween = MultiTween(
    //    // [
    //    //  Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //    //   Track("translateY").add(
    //    //     Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //    //     curve: Curves.easeOut)
    //    // ]
//
    //    )
    //  ..add(
    //    AniProps.opacity,
    //    Tween(begin: 0.0, end: 1.0),
    //    const Duration(milliseconds: 300),
    //  )
    //  ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0),
    //      const Duration(milliseconds: 500), Curves.easeOut);
    final tween = Tween<double>(begin: 0, end: 1);

    return PlayAnimation(
      delay: Duration(milliseconds: (900 * delay).round()),
      // duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => const Opacity(
        opacity: 1.0,
      ),
    );
  }
}
