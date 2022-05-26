import 'package:food_template/Library/intro_views_flutter-2.4.0/lib/Constants/constants.dart';

/// This is view model for the skip and done buttons.

class PageButtonViewModel {
  final double slidePercent;
  final int totalPages;
  final int activePageIndex;
  final SlideDirection slideDirection;

  PageButtonViewModel({
    required this.slidePercent,
    required this.totalPages,
    required this.activePageIndex,
    required this.slideDirection,
  });
}
