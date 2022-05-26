import 'package:flutter/material.dart';

///
///
/// If no item cart this class showing
///
class NoItemCart extends StatelessWidget {
  NoItemCart({required this.message});
  String message;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: mediaQueryData.padding.top + 50.0),
            ),
            Image.asset(
              "assets/image/emptyCart.png",
              height: 300.0,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              message,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black54,
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}
