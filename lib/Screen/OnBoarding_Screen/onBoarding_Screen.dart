import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';
import '/Library/no_connection.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 5.0,
      width: isActive ? 20.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.amber.shade700 : Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    var _textH1 = const TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w600,
        fontSize: 23.0,
        color: Colors.black87);

    var _textH2 = const TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w200,
        fontSize: 16.0,
        color: Colors.black87);

    return Scaffold(
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          // print(connected);
        },
        connected: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: const BoxDecoration(
              //color: Color(0xFF1E2026),
              color: Colors.white70,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 50,
                              left: 50,
                              right: 50,
                            ),
                            child: DropShadowImage(
                              offset: const Offset(10, 10),
                              scale: 1,
                              blurRadius: 12,
                              borderRadius: 20,
                              image: Image(
                                image: Image.asset('assets/image/onboard_1.png')
                                    .image,
                                //  height: 200.0,
                                //  width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Scopri',
                                    style: _textH1,
                                  ),
                                  const SizedBox(height: 35.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      textAlign: TextAlign.center,
                                      style: _textH2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 50,
                              left: 50,
                              right: 50,
                            ),
                            child: DropShadowImage(
                              offset: const Offset(10, 10),
                              scale: 1,
                              blurRadius: 3,
                              borderRadius: 20,
                              image: Image(
                                image: Image.asset('assets/image/onboard_2.png')
                                    .image,
                                //  height: 200.0,
                                //  width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Ordina',
                                    style: _textH1,
                                  ),
                                  const SizedBox(height: 35.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      textAlign: TextAlign.center,
                                      style: _textH2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 50,
                              left: 50,
                              right: 50,
                            ),
                            child: DropShadowImage(
                              offset: const Offset(10, 10),
                              scale: 1,
                              blurRadius: 3,
                              borderRadius: 20,
                              image: Image(
                                image: Image.asset('assets/image/onboard_3.png')
                                    .image,
                                //  height: 200.0,
                                //  width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Bon appetit',
                                    style: _textH1,
                                  ),
                                  const SizedBox(height: 35.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      textAlign: TextAlign.center,
                                      style: _textH2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: Padding(
                    // padding: const EdgeInsets.only(top: 470),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),
                ),
                _currentPage != _numPages - 1
                    ? Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 40.0,
                              left: 10,
                              right: 10,
                            ),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.amber.shade700,
                                border: Border.all(
                                  color: Colors.amber.shade700,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Avanti",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
        disconnected: const NoConnection(),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                      pageBuilder: (_, __, ____) =>
                          const BottomNavigationBarT2()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 47,
                  left: 17,
                  right: 17,
                ),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.amber.shade700,
                    border: Border.all(
                      color: Colors.amber.shade700,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Inizia!",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          letterSpacing: 1.5),
                    ),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }
}
