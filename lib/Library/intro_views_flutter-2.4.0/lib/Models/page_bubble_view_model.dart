import 'package:flutter/material.dart';

// View Model for page bubble

class PageBubbleViewModel {
  final String iconAssetPath;
  final Color iconColor;
  final bool isHollow;
  final double activePercent;
  final Color? bubbleBackgroundColor;
  final Widget bubbleInner;

  PageBubbleViewModel({
    required this.bubbleInner,
    required this.iconAssetPath,
    required this.iconColor,
    required this.isHollow,
    required this.activePercent,
    this.bubbleBackgroundColor = const Color(0x88FFFFFF),
  }) : assert(bubbleBackgroundColor != null);
}
