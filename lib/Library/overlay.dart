import 'package:flutter/material.dart';
import 'package:food_template/Library/loader.dart';

class OverlayView extends StatelessWidget {
  const OverlayView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return yourOverLayWidget();
  }

  Container yourOverLayWidget() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close_outlined),
                            onPressed: () {
                              Loader.appLoader.hideLoader();
                            },
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.error_rounded,
                        color: Colors.red,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
