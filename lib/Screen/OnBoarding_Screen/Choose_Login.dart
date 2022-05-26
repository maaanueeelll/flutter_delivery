import 'package:flutter/material.dart';
import '/Screen/Login_Screen/SignIn_Screen.dart';

class ChooseLogin extends StatefulWidget {
  const ChooseLogin({Key? key}) : super(key: key);

  @override
  _ChooseLoginState createState() => _ChooseLoginState();
}

class _ChooseLoginState extends State<ChooseLogin>
    with TickerProviderStateMixin {
  /// Declare Animation
  late AnimationController animationController;
  var tapLogin = 0;
  var tapSignup = 0;

  @override

  /// Declare animation in initState
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            tapLogin = 0;
            tapSignup = 0;
          });
        }
      });
    super.initState();
  }

  /// To dispose animation controller
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  /// Play animation set forward reverse
  Future<Null> _Playanimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    mediaQuery.devicePixelRatio;
    mediaQuery.size.height;
    mediaQuery.size.width;
    return FutureBuilder<bool>(
      future: Future.delayed(const Duration(milliseconds: 500), () {
        //  setState(() => ignoring = false);
        return true;
      }),
      builder: (context, snapshot) {
        // print(snapshot.data);
        return (snapshot.hasData)
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset(
                                    "assets/image/chooseBackground.jpeg")
                                .image,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 1.0),
                          // stops: [0.0, 1.0],
                          colors: <Color>[
                            const Color(0xFF1E2026).withOpacity(0.1),
                            const Color(0xFF1E2026).withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),

                      /// Set component layout
                      child: ListView(
                        padding: const EdgeInsets.all(0.0),
                        children: <Widget>[
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 20.0, bottom: 170.0),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "ORDINA\nQUELLO CHE \nVUOI \nDOVE VUOI.",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 37.0,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: "Sofia",
                                                letterSpacing: 1.3),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0,
                                              top: 20.0,
                                              right: 20.0),
                                          child: Text(
                                            "Accedi e ordina comodamente.\nNoi te lo consegnamo!",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w200,
                                                fontFamily: "Sofia",
                                                letterSpacing: 1.3),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 220.0)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      /// To create animation if user tap == animation play (Click to open code)
                                      tapLogin == 0
                                          ? Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                splashColor: Colors.white,
                                                onTap: () {
                                                  setState(() {
                                                    tapLogin = 1;
                                                  });
                                                  _Playanimation();
                                                  // return tapLogin;
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: LayoutBuilder(builder:
                                                      (context, constraint) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: Container(
                                                        height: 52.0,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .amber.shade700,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      80.0),
                                                        ),
                                                        child: const Center(
                                                            child: Text(
                                                          'Accedi',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontFamily:
                                                                  "Sofia",
                                                              letterSpacing:
                                                                  0.9),
                                                        )),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            )
                                          : AnimationSplashSignup(
                                              animationController:
                                                  animationController,
                                            ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 90.0)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //  bottomNavigationBar: const bottomNavBar(),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  title: const Text(
                    "Carrello",
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Sofia",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                  elevation: 1,
                ),
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber.shade700,
                  ),
                ),
              );
      },
    );
  }
}

/// Set Animation Login if user click button login
class AnimationSplashLogin extends StatefulWidget {
  AnimationSplashLogin({
    Key? key,
    required this.animationController,
  })  : animation = Tween(
          end: 900.0,
          begin: 70.0,
        ).animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashLoginState createState() => _AnimationSplashLoginState();
}

/// Set Animation Login if user click button login
class _AnimationSplashLoginState extends State<AnimationSplashLogin> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const SigninTemplate1(),
          ),
        );
        //hello
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}

/// Set Animation signup if user click button signup
class AnimationSplashSignup extends StatefulWidget {
  AnimationSplashSignup({
    Key? key,
    required this.animationController,
  })  : animation = Tween(
          end: 900.0,
          begin: 70.0,
        ).animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashSignupState createState() => _AnimationSplashSignupState();
}

/// Set Animation signup if user click button signup
class _AnimationSplashSignupState extends State<AnimationSplashSignup> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const SigninTemplate1()));
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}
