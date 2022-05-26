import 'package:cached_network_image/cached_network_image.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import '/Library/no_connection.dart';
import '/models/productModel.dart';
import '/models/userModel.dart';
import '/Library/snackbar_message.dart';
import '/models/cartModel.dart';
import '/models/restaurantModel.dart';
import '/constants.dart';
//import '/Screen/B1_Home_Screen/Component_Detail_Food/Gallery_Screen.dart';

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

class FoodDetailT2 extends StatefulWidget {
  Product product;
  FoodDetailT2({required this.product});

  @override
  _FoodDetailT2State createState() => _FoodDetailT2State();
}

class _FoodDetailT2State extends State<FoodDetailT2> {
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
    });

    fetchCartFromPref().then((CartModel res) {
      setState(() {
        _cart = res;
      });
    });

    fetchUserdataFromPref().then((User res) {
      setState(() {
        _user = res;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
        title: const Text(
          'Dettaglio',
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
        connected: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              height: _height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.blue.shade50),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CachedNetworkImage(
                    imageUrl: 'https://${BASE_URL + widget.product.imageUrl}',
                    fit: BoxFit.fitWidth,
                    //placeholder: (context, url) => CircularProgressIndicator(),
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text(
                        'caricamento..',
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                      radius: 150,
                    ),
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(
                top: _height / 2.4,
                left: 20,
                right: 20,
                bottom: 40,
              ),
              child: Column(
                children: [
                  ListTile(
                    // leading: Icon(Icons.arrow_drop_down_circle),
                    title: Text(
                      widget.product.name.toString(),
                      style: const TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 20),
                    ),
                    subtitle: Text(
                      widget.product.ingredients.toString(),
                      style: const TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w300,
                          color: Colors.black54,
                          fontSize: 16),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          Icon(
                            Icons.star_border_rounded,
                            color: Colors.amber.shade300,
                          ),
                          Text(
                            '${widget.product.rating}',
                            style: const TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    // buildRating(widget.product.rating.toInt()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.product.description.toString(),
                      style: const TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w300,
                          color: Colors.black54,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              const Text(
                                'Calorie',
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 12),
                              ),
                              Text(
                                widget.product.kcal.toString(),
                                style: const TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          width: 40,
                          thickness: 1,
                          indent: 0,
                          endIndent: 10,
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              const Text(
                                'Promo',
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 12),
                              ),
                              Text(
                                widget.product.isPromo ? 'Si' : 'No',
                                style: const TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          width: 40,
                          thickness: 1,
                          indent: 0,
                          endIndent: 10,
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              const Text(
                                'Prezzo',
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 12),
                              ),
                              Text(
                                '${widget.product.price.toString()} €',
                                style: const TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_user!.username != '') {
                            bool check = await addFavorite(
                                widget.product, _user!, _restaurant!);
                            if (check) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarMessage('Aggiunto ai preferiti'),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarMessage('Effettua il login!'),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          fixedSize: const Size(130, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.lightBlue.shade300,
                        ),
                        child: const Text(
                          'Preferiti',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () async {
                          bool check = await checkCart(widget.product);

                          if (check == true) {
                            widget.product.isInCart = true;
                            // _cart = fetchCartFromPref();
                            fetchCartFromPref().then((CartModel res) {
                              setState(() {
                                _cart = res;
                              });
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          fixedSize: const Size(130, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: widget.product.isInCart
                              ? Colors.black54
                              : Colors.amber.shade700,
                        ),
                        child: Text(
                          widget.product.isInCart ? 'In carrello' : 'Ordina',
                          style: TextStyle(
                              color: widget.product.isInCart
                                  ? Colors.white
                                  : Colors.black87,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
