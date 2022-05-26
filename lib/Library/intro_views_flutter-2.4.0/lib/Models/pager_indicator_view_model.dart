
import 'package:food_template/Library/intro_views_flutter-2.4.0/lib/Constants/constants.dart';
import 'package:food_template/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';

//view model for page indicator

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
    this.pages,
    this.activeIndex,
    this.slideDirection,
    this.slidePercent,
  );
}
