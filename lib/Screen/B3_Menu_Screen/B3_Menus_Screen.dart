import 'package:cached_network_image/cached_network_image.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/Library/no_connection.dart';
import '/models/menuModel.dart';
import '/models/productModel.dart';
import '/constants.dart';
import '/models/cartModel.dart';
import '/models/restaurantModel.dart';
import '/Screen/B1_Home_Screen/Component_Detail_Food/Food_Detail_Screen.dart';

Future<bool> checkCart(Product prod) async {
  CartModel cart = await fetchCartFromPref();
  bool check = true;
  if (cart.cartItems.isNotEmpty) {
    for (var element in cart.cartItems) {
      if (element.id == prod.id) {
        // DO NOTHING
        check = false;
      }
    }
  }
  if (check) {
    cart.cartItems.add(prod);
    saveCartPrefs(cart);
  }
  return check;
}

class MenuFoodList extends StatefulWidget {
  Menu menu;
  MenuFoodList({
    Key? key,
    required this.menu,
  });

  @override
  _MenuFoodListState createState() => _MenuFoodListState();
}

class _MenuFoodListState extends State<MenuFoodList> {
  Restaurant? _restaurant;
  CartModel? _cart;
  @override
  void initState() {
    // TODO: implement initState
    fetchRestaurantFromPref().then((Restaurant res) {
      setState(() {
        _restaurant = res;
      });
      fetchCartFromPref().then((CartModel res) {
        setState(() {
          _cart = res;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
        title: Text(
          widget.menu.name,
          style: const TextStyle(
              color: Colors.black54,
              fontFamily: "Sofia",
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
        ),
        elevation: 1,
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
        },
        connected: FutureBuilder<List<Product>>(
          future: fetchProducts(http.Client(), widget.menu.id),
          builder: (context, snapshot) {
            // print(snapshot.error);
            if (snapshot.hasData) {
              if (_cart!.cartItems.isNotEmpty) {
                for (var elementCart in _cart!.cartItems) {
                  for (var elementMenu in snapshot.data!) {
                    if (elementCart.id == elementMenu.id) {
                      elementMenu.isInCart = true;
                    }
                  }
                }
              }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 10.0),
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 10,
                            bottom: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      FoodDetailT2(
                                          product: snapshot.data![index]),
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );

                              // PageRouteBuilder(
                              //   pageBuilder: (_, __, ___) => FoodDetailT2(
                              //       product: snapshot.data![index]),
                              //   transitionDuration:
                              //       const Duration(milliseconds: 500),
                              //   transitionsBuilder: (_,
                              //       Animation<double> animation,
                              //       __,
                              //       Widget child) {
                              //     return Opacity(
                              //       opacity: animation.value,
                              //       child: child,
                              //     );
                              //   },
                              // ),
                              //);
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 150.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          color:
                                              Colors.black12.withOpacity(0.03),
                                          spreadRadius: 10.0),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Hero(
                                          tag:
                                              'hero-tag-${snapshot.data![index].id}',
                                          child: Material(
                                            child: Container(
                                              height: 130.0,
                                              width: 130.0,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://${BASE_URL + snapshot.data![index].imageUrl}',
                                                fit: BoxFit.cover,
                                                //placeholder: (context, url) => CircularProgressIndicator(),
                                                placeholder: (context, url) =>
                                                    const CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Text(
                                                    'caricamento..',
                                                    style: TextStyle(
                                                        fontFamily: "Sofia",
                                                        fontSize: 16,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  radius: 150,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10.0,
                                          right: 5.0,
                                          left: 20.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            SizedBox(
                                              width: 150.0,
                                              child: Text(
                                                snapshot.data![index].name,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: "Sofia",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  snapshot
                                                      .data![index].ingredients,
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: "Sofia",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: buildRating(snapshot
                                                      .data![index].rating
                                                      .toInt()),
                                                ),
                                                Text(
                                                  snapshot.data![index].rating >
                                                          0.0
                                                      ? "(" +
                                                          snapshot.data![index]
                                                              .rating
                                                              .toString() +
                                                          ")"
                                                      : "(no rating)",
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: "Sofia",
                                                    fontSize: 12.5,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Text(
                                                '${snapshot.data![index].price.toString()} €',
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: "Sofia",
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 100, right: 10),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        bool check = await checkCart(
                                            snapshot.data![index]);

                                        if (check == true) {
                                          snapshot.data![index].isInCart = true;
                                          // _cart = fetchCartFromPref();
                                          fetchCartFromPref()
                                              .then((CartModel res) {
                                            setState(() {
                                              _cart = res;
                                            });
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: snapshot.data![index].isInCart
                                            ? Colors.black54
                                            : Colors.amber.shade700,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: Text(
                                        snapshot.data![index].isInCart
                                            ? 'In carrello'
                                            : 'Ordina',
                                        style: TextStyle(
                                          color: snapshot.data![index].isInCart
                                              ? Colors.white
                                              : Colors.black87,
                                          fontFamily: "Sofia",
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber.shade700,
                ),
              );
            }
          },
        ),
        disconnected: const NoConnection(),
      ),
    );
  }

  List<Widget> buildRating(int rating) {
    List<Widget> stars = [];
    for (int i = 0; i < rating; i++) {
      stars.add(
        const Icon(
          Icons.star,
          size: 18.0,
          color: Colors.yellow,
        ),
      );
    }
    return stars;
  }
}
