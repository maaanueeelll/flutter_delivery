import 'package:badges/badges.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import '/models/userModel.dart';
import '/models/cartModel.dart';
import '/Library/no_connection.dart';
import '/Screen/OnBoarding_Screen/Choose_Login.dart';
import '/Screen/B1_Home_Screen/B1_Home_Screen_T2.dart';
import '/Screen/B2_Favorite_Screen/B2_Favorite_Screen.dart';
import '/Screen/B4_Cart_Screen/B4_Cart_Screen.dart';
import '/Screen/B5_Profile_Screen/B5_Profile_Screen.dart';

class BottomNavigationBarT2 extends StatefulWidget {
  const BottomNavigationBarT2({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarT2State createState() => _BottomNavigationBarT2State();
}

class _BottomNavigationBarT2State extends State<BottomNavigationBarT2> {
  int currentIndex = 0;
  int currentPage = 0;
  CartModel? _cart;

  /// Set a type current number a layout class

  Widget callPage(int current) {
    switch (current) {
      case 0:
        return HomeScreenT2();
      case 1:
        return FavoriteScreenT2();
      case 2:
        return MyOrderScreenT2();
      case 3:
        return const ProfileScreenT2();
      case 4:
        return const ChooseLogin();
      default:
        return HomeScreenT2();
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchCartFromPref().then((CartModel res) {
      setState(() {
        _cart = res;
      });
    });

    super.initState();
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: fetchUserdataFromPref(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: ConnectionNotifierToggler(
              onConnectionStatusChanged: (connected) {
                /// that means it is still in the initialization phase.
                if (connected == null) return;
              },
              connected: callPage(currentPage),
              disconnected: const NoConnection(),
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white70,
                // textTheme: Theme.of(context).textTheme.copyWith(
                //       caption: const TextStyle(color: Colors.white),
                //     ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                fixedColor: Colors.amber.shade700,
                elevation: 1,
                onTap: (value) {
                  if (value == 1 || value == 3) {
                    if (snapshot.data!.username != '') {
                      currentIndex = value;
                      currentPage = value;
                    } else {
                      currentIndex = value;
                      currentPage = 4;
                    }
                  } else {
                    currentIndex = value;
                    currentPage = value;
                  }

                  fetchCartFromPref().then((CartModel res) {
                    setState(() {
                      _cart = res;
                    });
                  });

                  setState(() {});
                },
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_rounded,
                        size: 20.0,
                      ),
                      label: 'Home'),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite_rounded,
                      size: 20.0,
                    ),
                    label: "Favoriti",
                  ),
                  //  BottomNavigationBarItem(
                  //    icon: Icon(Icons.grain),
                  //    label: "Category",
                  //  ),
                  BottomNavigationBarItem(
                    icon: _cart!.items!.isNotEmpty
                        ? Badge(
                            badgeContent: Text(_cart!.items!.length.toString()),
                            badgeColor: Colors.red.shade400,
                            padding: const EdgeInsets.all(3),
                            child: const Icon(
                              Icons.shopping_cart_rounded,
                              size: 20.0,
                            ),
                          )
                        : const Icon(
                            Icons.shopping_cart_rounded,
                            size: 20.0,
                          ),
                    label: "Carrello",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_rounded,
                      size: 20.0,
                    ),
                    label: "Profilo",
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: ConnectionNotifierToggler(
              onConnectionStatusChanged: (connected) {
                if (connected == null) return;
                // print(connected);
              },
              connected: Center(
                child: CircularProgressIndicator(
                  color: Colors.amber.shade700,
                ),
              ),
              disconnected: const NoConnection(),
            ),
          );
        }
      },
    );
  }
}
