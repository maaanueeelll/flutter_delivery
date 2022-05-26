import 'dart:async';
import 'dart:convert';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:food_template/Library/no_connection.dart';
import 'package:food_template/Library/snackbar_message.dart';
import 'package:food_template/Screen/B4_Cart_Screen/Step_Order/4_Confirm_Screen.dart';
import '/Screen/widgets/loading_button.dart';
//import '/Screen/widgets/response_card.dart';
import '/constants.dart';
import '/models/cartModel.dart';
import '/models/restaurantModel.dart';
import '/models/userModel.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';
import 'package:http/http.dart' as http;

class CheckoutOrder extends StatefulWidget {
  CheckoutOrder({
    Key? key,
    required this.cart,
    required this.user,
    required this.restaurant,
  }) : super(key: key);

  CartModel? cart;
  final User? user;
  final Restaurant? restaurant;

  @override
  _CheckoutOrderState createState() => _CheckoutOrderState();
}

class _CheckoutOrderState extends State<CheckoutOrder> {
  CardFieldInputDetails? _card;
  bool? _saveCard = false;
  bool _isLoading = false;
  String _email = '';

  /// Duration for popup card if user succes to payment
  StartTime() async {
    return Timer(const Duration(milliseconds: 1450), navigator);
  }

  /// Navigation to route after user succes payment
  void navigator() {
    Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, __, ___) => BottomNavigationBarT2()));
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
                  leading: const BackButton(
                    color: Colors.black54,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  title: const Text(
                    "Checkout",
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
                  connected: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              'TOTALE ORDINE : ${widget.cart!.total + widget.cart!.deliveryFee}€',
                              style: const TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0)),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.black54,
                                fontFamily: "Sofia",
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            initialValue: widget.cart!.email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: 'Email', labelText: 'Email'),
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CardField(
                            autofocus: true,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontFamily: "Sofia",
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            onCardChanged: (card) {
                              setState(() {
                                _card = card;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: CheckboxListTile(
                            value: _saveCard,
                            onChanged: (value) {
                              setState(() {
                                _saveCard = value;
                              });
                            },
                            title: const Text(
                              'Memorizza la carta',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Sofia",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: LoadingButton(
                            onPressed: () async {
                              if (_card?.complete == true) {
                                widget.cart!.onlinePayment = true;
                                widget.cart!.paymentType = 'CARTA DI CREDITO';
                                bool check = await _handlePayPress();
                                if (check) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarMessage("Pagamento confermato"));
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ____) =>
                                          ConfirmScreenT2(
                                        cart: widget.cart!,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarMessage(
                                          "Errore durante l'invio della richiesta"));
                                }
                              }
                              throw Exception('Card not complete');
                            },
                            text: 'Acquista ora',
                          ),
                        ),

                        if (Stripe.instance.isApplePaySupported.value)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 20),
                            child: ApplePayButton(
                              cornerRadius: 20,
                              onPressed: _handleApplePayPress,
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 30.0,
                          ),
                          child: InkWell(
                            onTap: () async {
                              /// TODO LOGIC FOR ONLINE PAYMENT
                              if (_isLoading == false) {
                                setState(() {
                                  _isLoading = true;
                                });
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  content: CircularProgressIndicator(
                                    color: Colors.amber.shade700,
                                  ),
                                );
                                widget.cart!.onlinePayment = false;
                                widget.cart!.paymentType = 'CONTANTI';
                                final response =
                                    await insertOrder(widget.cart!);
                                if (response.containsKey('error')) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarMessage(
                                          "Errore durante l'invio della richiesta"));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarMessage('Ordine inviato'));

                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ____) =>
                                          ConfirmScreenT2(
                                        cart: widget.cart!,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              height: 32.0,
                              width: double.infinity,
                              child: const Center(
                                  child: Text(
                                "Paga alla consegna",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Sofia",
                                    letterSpacing: 0.9),
                              )),
                            ),
                          ),
                        ),
                        //  if (_card != null)
                        //    ResponseCard(
                        //      response: _card!.toJson().toPrettyString(),
                        //    ),
                      ],
                    ),
                  ),
                  disconnected: const NoConnection(),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: const BackButton(
                    color: Colors.black54,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  title: const Text(
                    "Checkout",
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

  Future<void> _handleApplePayPress() async {
    Stripe.publishableKey = STRIPE_PUB_KEY;
    Stripe.stripeAccountId = widget.cart!.stripeAccountId;
    Stripe.merchantIdentifier = 'wWholedata.io';
    await Stripe.instance.applySettings();

    try {
      // 1. Present Apple Pay sheet
      await Stripe.instance.presentApplePay(
        ApplePayPresentParams(
          cartItems: [
            ApplePayCartSummaryItem(
              label: 'WHOLEDATA ORDER',
              amount: widget.cart!.total.toString(),
            ),
          ],
          country: 'IT',
          currency: 'EUR',
        ),
      );

      // 2. fetch Intent Client Secret from backend
      final clientSecret = await insertOrder(widget.cart!);

      // 2. Confirm apple pay payment
      await Stripe.instance
          .confirmApplePayPayment(clientSecret['client_secret']);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Apple Pay payment succesfully completed')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<bool> _handlePayPress() async {
    Stripe.publishableKey = STRIPE_PUB_KEY;
    Stripe.stripeAccountId = widget.cart!.stripeAccountId;

    try {
      await Stripe.instance.applySettings();
      // 1. fetch Intent Client Secret from backend
      final clientSecret = await insertOrder(widget.cart!);
      // 2. Gather customer billing information (ex. email)
      final billingDetails = BillingDetails(
        email: widget.cart!.email,
        phone: widget.cart!.telephone,
        name: widget.cart!.fullName,
        address: Address(
          city: widget.cart!.city,
          country: 'IT',
          line1: widget.cart!.address,
          line2: '',
          state: 'Italia',
          postalCode: '',
        ),
      );

      final paymentIntent = await Stripe.instance.confirmPayment(
        clientSecret['client_secret'],
        PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(billingDetails: billingDetails),
          options: PaymentMethodOptions(
            setupFutureUsage:
                _saveCard == true ? PaymentIntentsFutureUsage.OffSession : null,
          ),
        ),
      );
      var res = paymentIntent.toJson();
      if (res['status'] == 'Succeeded') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
