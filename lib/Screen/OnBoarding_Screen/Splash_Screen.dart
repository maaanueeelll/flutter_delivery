import 'dart:async';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'onBoarding_Screen.dart';

Future<bool> showOnboardScreen() async {
  bool check = false;
  const storage = FlutterSecureStorage();
  String? showIntroSplash = await storage.read(key: 'showOnboardScreen');

  if (showIntroSplash != null) {
    check = true ? showIntroSplash == 'true' : false;
    return false;
  } else {
    return false;
  }
}

class SplashScreenTemplate2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ConnectionNotifier(
      child: MaterialApp(
        home: SplashScreenTemplate2Screen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            primaryColorLight: Colors.white,
            // primaryColorBrightness: Brightness.light,
            primaryColor: Colors.white),
      ),
    );
  }
}

class SplashScreenTemplate2Screen extends StatefulWidget {
  @override
  _SplashScreenTemplate2ScreenState createState() =>
      _SplashScreenTemplate2ScreenState();
}

class _SplashScreenTemplate2ScreenState
    extends State<SplashScreenTemplate2Screen> {
  @override
  void _Navigator() async {
    bool check = await showOnboardScreen();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              check ? const BottomNavigationBarT2() : OnboardingScreen(),
          //testing(),
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }),
    );
  }

  /// Set timer SplashScreenTemplate2
  _timer() async {
    return Timer(const Duration(milliseconds: 800), _Navigator);
  }

  @override
  void initState() {
    super.initState();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: Image.asset("assets/image/wholedata_logo_home.png").image,
              fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
