import 'package:cached_network_image/cached_network_image.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import '/Library/no_item_cart.dart';
import '/Library/snackbar_message.dart';
import '/constants.dart';
import '/models/productModel.dart';
import '/models/restaurantModel.dart';
import '/models/userModel.dart';
import '/models/cartModel.dart';
import '/Library/no_connection.dart';
import '/Screen/B1_Home_Screen/Component_Detail_Food/Food_Detail_Screen.dart';
import 'package:http/http.dart' as http;

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

class FavoriteScreenT2 extends StatefulWidget {
  FavoriteScreenT2({Key? key}) : super(key: key);

  @override
  _FavoriteScreenT2State createState() => _FavoriteScreenT2State();
}

class _FavoriteScreenT2State extends State<FavoriteScreenT2> {
  Restaurant? _restaurant;
  CartModel? _cart;
  User? _user;
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
    fetchUserdataFromPref().then((User user) {
      setState(() {
        _user = user;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  title: const Text(
                    "Favoriti",
                    style: TextStyle(
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
                    future: fetchFavoriteProducts(http.Client(), _restaurant!),
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
                        return snapshot.data!.isNotEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 5.0,
                                    ),
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
                                                  pageBuilder: (_, __, ___) =>
                                                      FoodDetailT2(
                                                    product:
                                                        snapshot.data![index],
                                                  ),
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 600),
                                                  transitionsBuilder: (_,
                                                      Animation<double>
                                                          animation,
                                                      __,
                                                      Widget child) {
                                                    return Opacity(
                                                      opacity: animation.value,
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              );
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
                                                          color: Colors.black12
                                                              .withOpacity(
                                                                  0.03),
                                                          spreadRadius: 10.0),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Hero(
                                                          tag:
                                                              'hero-tag-${snapshot.data![index].id}',
                                                          child: Material(
                                                            child: Container(
                                                              height: 130.0,
                                                              width: 130.0,
                                                              //decoration: BoxDecoration(
                                                              //    image: DecorationImage(
                                                              //        image: Image.network(
                                                              //                'https://${BASE_URL + snapshot.data![index].imageUrl}')
                                                              //            .image,
                                                              //        fit: BoxFit
                                                              //            .cover)),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    'https://${BASE_URL + snapshot.data![index].imageUrl}',
                                                                fit: BoxFit
                                                                    .cover,
                                                                //placeholder: (context, url) => CircularProgressIndicator(),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  child: Text(
                                                                    'caricamento..',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Sofia",
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  radius: 150,
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 20.0,
                                                                right: 5.0,
                                                                left: 20.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            SizedBox(
                                                              width: 150.0,
                                                              child: Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .name,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontFamily:
                                                                        "Sofia",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        18.0),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: buildRating(snapshot
                                                                      .data![
                                                                          index]
                                                                      .rating
                                                                      .toInt()),
                                                                ),
                                                                Text(
                                                                  snapshot.data![index].rating >
                                                                          0.0
                                                                      ? "(" +
                                                                          snapshot
                                                                              .data![index]
                                                                              .rating
                                                                              .toString() +
                                                                          ")"
                                                                      : "(no rating)",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontFamily:
                                                                        "Sofia",
                                                                    fontSize:
                                                                        12.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 25),
                                                              child: Text(
                                                                '${snapshot.data![index].price.toString()} €',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontFamily:
                                                                      "Sofia",
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 100,
                                                            right: 10),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        bool check =
                                                            await checkCart(
                                                                snapshot.data![
                                                                    index]);

                                                        if (check == true) {
                                                          snapshot.data![index]
                                                              .isInCart = true;
                                                          // _cart = fetchCartFromPref();
                                                          fetchCartFromPref()
                                                              .then((CartModel
                                                                  res) {
                                                            setState(() {
                                                              _cart = res;
                                                            });
                                                          });
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: snapshot
                                                                .data![index]
                                                                .isInCart
                                                            ? Colors.black54
                                                            : Colors
                                                                .amber.shade700,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        snapshot.data![index]
                                                                .isInCart
                                                            ? 'In carrello'
                                                            : 'Ordina',
                                                        style: TextStyle(
                                                          color: snapshot
                                                                  .data![index]
                                                                  .isInCart
                                                              ? Colors.white
                                                              : Colors.black87,
                                                          fontFamily: "Sofia",
                                                          fontSize: 12.5,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          bool check =
                                                              await removeFavorite(
                                                                  snapshot.data![
                                                                      index],
                                                                  _user!);
                                                          setState(() {});
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            snackBarMessage(
                                                                'Rimuovo dai preferiti'),
                                                          );
                                                        },
                                                        child: const Icon(
                                                            Icons
                                                                .delete_rounded,
                                                            color:
                                                                Colors.black87,
                                                            size: 30),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          Icons.bookmark,
                                                          color: Colors.red,
                                                          size: 30.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : NoItemCart(message: 'La lista è vuota');
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
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  title: const Text(
                    "Favoriti",
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
