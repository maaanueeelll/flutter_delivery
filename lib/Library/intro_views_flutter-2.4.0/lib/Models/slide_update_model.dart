
import 'package:food_template/Library/intro_views_flutter-2.4.0/lib/Constants/constants.dart';

// model for slide update

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;

  SlideUpdate(
    this.direction,
    this.slidePercent,
    this.updateType,
  );
}
