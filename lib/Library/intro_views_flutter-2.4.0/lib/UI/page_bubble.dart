import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_template/Library/intro_views_flutter-2.4.0/lib/Models/page_bubble_view_model.dart';

/// This class contains the UI for page bubble.
class PageBubble extends StatelessWidget {
  //view model
  final PageBubbleViewModel viewModel;

  //Constructor
  PageBubble({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 55.0,
      height: 65.0,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: new Center(
        child: new Padding(
          padding: const EdgeInsets.all(0.5),
          child: new Container(
            width:
                60.0, //This method return in between values according to active percent.
            height: 4.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              //Alpha is used to create fade effect for background color
              color: viewModel.isHollow ? Colors.white24 : Color(0xFFF88421),
              border: new Border.all(
                color: viewModel.isHollow
                    ? viewModel.bubbleBackgroundColor!.withAlpha(
                        (0xFF * (0.1 - viewModel.activePercent)).round())
                    : Colors.white10,
                width: 2.0,
              ), //Border
            ), //BoxDecoration
            child: new Opacity(
              opacity: viewModel.activePercent,
              child: (viewModel.iconAssetPath != null &&
                      viewModel.iconAssetPath != "")
                  // ignore: conflicting_dart_import
                  ? new Image.asset(
                      viewModel.iconAssetPath,
                      color: viewModel.iconColor,
                    )
                  : new Container(),
            ), //opacity
          ), //Container
        ), //Padding
      ), //Center
    ); //Container
  }
}
