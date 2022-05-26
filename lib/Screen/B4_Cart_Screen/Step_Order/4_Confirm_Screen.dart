import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_template/Library/no_connection.dart';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';
import 'package:food_template/constants.dart';
import 'package:food_template/models/cartModel.dart';

class ConfirmScreenT2 extends StatefulWidget {
  ConfirmScreenT2({
    Key? key,
    required this.cart,
  }) : super(key: key);
  CartModel cart;

  @override
  _ConfirmScreenT2State createState() => _ConfirmScreenT2State();
}

class _ConfirmScreenT2State extends State<ConfirmScreenT2> {
  CartModel? _cart;

  @override
  void initState() {
    // TODO: implement initState
    _cart = widget.cart;
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
                    "Conferma ordine",
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
                  connected: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 0.1,
                        color: Colors.white70,
                      ),
                      Expanded(
                        child: Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 20.0),
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "Articoli ordinati",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: "Sofia",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.5),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _cart!.items!.length,
                                      itemBuilder: (context, position) {
                                        return Slidable(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 13.0,
                                                right: 13.0,
                                                bottom: 10.0),

                                            /// Background Constructor for card
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),

                                                      /// Image item
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.1),
                                                                boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black12
                                                                      .withOpacity(
                                                                          0.1),
                                                                  blurRadius:
                                                                      0.5,
                                                                  spreadRadius:
                                                                      0.1)
                                                            ]),
                                                        child: Image.network(
                                                          'https://${BASE_URL + _cart!.items![position].imageUrl}',
                                                          height: 90,
                                                          width: 90,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5.0,
                                                                left: 10.0,
                                                                right: 5.0),
                                                        child: Column(
                                                          /// Text Information Item
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 200.0,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Text(
                                                                  _cart!
                                                                      .items![
                                                                          position]
                                                                      .name,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontFamily:
                                                                          "Sofia",
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          17.0),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 8.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          15.0),
                                                                  child: Text(
                                                                    "€ "
                                                                    '${_cart!.items![position].price}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black87,
                                                                        fontFamily:
                                                                            "Sofia",
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 18.0,
                                                                      left:
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: 100,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            color:
                                                                                Colors.transparent),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: <
                                                                          Widget>[
                                                                        /// Decrease of value item

                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 18.0),
                                                                          child:
                                                                              Text(
                                                                            'Nr. ${_cart!.items![position].quantity.toString()}',
                                                                            style: const TextStyle(
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontFamily: "Sofia",
                                                                                fontSize: 18.0),
                                                                          ),
                                                                        ),

                                                                        /// Increasing value of item
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
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
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 100.0),
                        child: InkWell(
                          onTap: () {
                            CartModel _cart = CartModel(0.0, []);
                            saveCartPrefs(_cart);
                            Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ____) =>
                                        const BottomNavigationBarT2()));
                          },
                          child: Container(
                            height: 52.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade700,
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: const Center(
                                child: Text(
                              "Torna alla home",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Sofia",
                                  letterSpacing: 0.9),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  disconnected: const NoConnection(),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  title: const Text(
                    "Conferma ordine",
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
                ));
      },
    );
  }
}
