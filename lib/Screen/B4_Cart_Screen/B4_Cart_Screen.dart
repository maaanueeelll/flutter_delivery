import 'package:cached_network_image/cached_network_image.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:food_template/Library/no_connection.dart';
import '../../Library/snackbar_message.dart';
import '/Library/no_item_cart.dart';
import '/constants.dart';
import '/models/cartModel.dart';
import '/models/restaurantModel.dart';
import '/models/userModel.dart';
import 'Step_Order/1_Delivery_option.dart';

class MyOrderScreenT2 extends StatefulWidget {
  MyOrderScreenT2({Key? key}) : super(key: key);

  @override
  _MyOrderScreenT2State createState() => _MyOrderScreenT2State();
}

class _MyOrderScreenT2State extends State<MyOrderScreenT2> {
  Restaurant? _restaurant;
  CartModel? _cart;
  User? _user;
  bool ignoring = true;
  bool _isLoading = false;
  String? _firebaseToken = '';

  @override
  void initState() {
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
    fetchFirebaseTokenFromPref().then((String res) {
      setState(() {
        _firebaseToken = res;
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
                    "Carrello",
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
                  connected: _cart!.items!.isNotEmpty
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: _cart!.items!.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 13,
                                      right: 13,
                                      bottom: 5.0,
                                    ),
//                     /// Background Constructor for card
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black12.withOpacity(0.1),
                                            blurRadius: 3.5,
                                            spreadRadius: 0.4,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(10.0),
//                                   /// Image item
                                                child: Container(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://${BASE_URL + _cart!.items![position].imageUrl}',
                                                    fit: BoxFit.cover,
                                                    width: 130,
                                                    height: 130,
                                                    //placeholder: (context, url) => CircularProgressIndicator(),
                                                    placeholder:
                                                        (context, url) =>
                                                            const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: Text(
                                                        'caricamento..',
                                                        style: TextStyle(
                                                            fontFamily: "Sofia",
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white38,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      radius: 130,
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          left: 15,
                                                          right: 5),
                                                  child: Column(
                                                    /// Text Information Item
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        _cart!.items![position]
                                                            .name
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: "Sans",
                                                          color: Colors.black87,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          _cart!
                                                              .items![position]
                                                              .ingredients
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 30.0),
                                                        child: Text(
                                                            '${_cart!.items![position].price} €'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10.0,
                                                                left: 0.0),
                                                        child: Container(
                                                          width: 112.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.white70,
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12
                                                                  .withOpacity(
                                                                      0.1),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              /// Decrease of value item
                                                              InkWell(
                                                                onTap: () {
                                                                  _cart!.cartItems[position].quantity >
                                                                          1
                                                                      ? _cart!
                                                                          .cartItems[
                                                                              position]
                                                                          .quantity--
                                                                      : _cart!
                                                                          .cartItems
                                                                          .remove(
                                                                              _cart!.cartItems[position]);
                                                                  saveCartPrefs(
                                                                      _cart!);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: const Center(
                                                                      child: Text(
                                                                          "-")),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18.0),
                                                                child: Text(_cart!
                                                                    .items![
                                                                        position]
                                                                    .quantity
                                                                    .toString()),
                                                              ),
//                                               /// Increasing value of item
                                                              InkWell(
                                                                onTap: () {
                                                                  _cart!
                                                                      .cartItems[
                                                                          position]
                                                                      .quantity++;
                                                                  saveCartPrefs(
                                                                      _cart!);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 28.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      left:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: const Center(
                                                                      child: Text(
                                                                          "+")),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                  );
                                },
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.black12.withOpacity(0.1),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
//                   //           /// Total price of item buy
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Consegna: ${_restaurant!.deliveryFees.toString()} €',
                                          style: const TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              fontFamily: "Sans"),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          _cart!.total > 0
                                              ? "Totale " +
                                                  (_restaurant!.deliveryFees +
                                                          _cart!.total)
                                                      .toString() +
                                                  " €"
                                              : 'Totale 0.0 €',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.5,
                                              fontFamily: "Sans"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: InkWell(
                                          onTap: () {
                                            if (_cart != null) {
                                              if (_cart!.cartItems.isNotEmpty) {
                                                _cart!.cartItems.clear();
                                                saveCartPrefs(_cart!);
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: const Icon(
                                              Icons.delete_rounded,
                                              color: Colors.black87,
                                              size: 30),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_user!.username != '') {
                                            _cart!.stripeAccountId =
                                                _restaurant!.stripeAccountId;
                                            _cart!.restaurant =
                                                _restaurant!.id.toString();
                                            _cart!.restaurantName =
                                                _restaurant!.name;
                                            _cart!.user = _user!.id.toString();
                                            _cart!.firebaseToken =
                                                _firebaseToken!;
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    DeliveryScreenT2(
                                                  cart: _cart,
                                                  user: _user,
                                                  restaurant: _restaurant,
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              snackBarMessage(
                                                  'Accedi per ordinare!'),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Container(
                                            height: 40.0,
                                            width: 120.0,
                                            decoration: BoxDecoration(
                                              color: Colors.amber.shade700,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Procedi",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Sofia",
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : NoItemCart(message: 'Il carrello è vuoto'),
                  disconnected: const NoConnection(),
                ),
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
