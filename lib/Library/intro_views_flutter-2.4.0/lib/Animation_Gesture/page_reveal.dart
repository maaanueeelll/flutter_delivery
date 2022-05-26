import 'package:flutter/material.dart';
import 'package:food_template/Library/intro_views_flutter-2.4.0/lib/Clipper/circular_reveal_clipper.dart';

/// This class reveals the next page in the circular form.

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;

  //Constructor
  PageReveal({
    required this.revealPercent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    //ClipOval cuts the page to circular shape.
    return new ClipOval(
      clipper: new CircularRevealClipper(revealPercent: revealPercent),
      child: child,
    );
  }
}
