import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:food_template/Library/no_connection.dart';
import 'package:food_template/Library/snackbar_message.dart';
import '3_checkout.dart';
import 'package:food_template/models/restaurantModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:food_template/models/cartModel.dart';
import 'package:food_template/models/userModel.dart';

class TimeScreenT2 extends StatefulWidget {
  TimeScreenT2({
    Key? key,
    this.cart,
    this.user,
    this.restaurant,
  }) : super(key: key);

  CartModel? cart;
  final User? user;
  final Restaurant? restaurant;

  @override
  _TimeScreenT2State createState() => _TimeScreenT2State();
}

class _TimeScreenT2State extends State<TimeScreenT2> {
  bool? _deliveryAsap = false;

  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    _timeController.text = '';
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
                  leading: const BackButton(
                    color: Colors.black54,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  title: const Text(
                    "Seleziona l'orario",
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
                    // print(connected);
                  },
                  connected: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 12.0,
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 30.0,
                                bottom: 50.0),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.white,
                                hintColor: Colors.white.withOpacity(0.1),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 25.0),
                                  _inputData("ORARIO", "time", _timeController),
                                  const SizedBox(height: 20.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CheckboxListTile(
                                      activeColor: Colors.white,
                                      checkColor: Colors.orangeAccent,
                                      value: _deliveryAsap,
                                      onChanged: (value) {
                                        setState(() {
                                          _deliveryAsap = value;
                                        });
                                      },
                                      side: const BorderSide(
                                        // ======> CHANGE THE BORDER COLOR HERE <======
                                        color: Colors.black87,
                                        // Give your checkbox border a custom width
                                        width: 1.5,
                                      ),
                                      title: const Text(
                                        'Consegna appena possibile',
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 40.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (_timeController.text != '') {
                                          widget.cart!.timeDelivery =
                                              _timeController.text;
                                          widget.cart!.deliveryAsap =
                                              _deliveryAsap!;

                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  CheckoutOrder(
                                                cart: widget.cart!,
                                                user: widget.user,
                                                restaurant: widget.restaurant,
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBarMessage(
                                                  "Imposta l'orario!"));
                                        }
                                      },
                                      child: Container(
                                        height: 52.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.amber.shade700,
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          "Vai al pagamento",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Sofia",
                                              letterSpacing: 0.9),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
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
                    "Selezxiona l'orario",
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Sofia",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                  elevation: 1,
                ),
                body: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orangeAccent,
                  ),
                ));
      },
    );
  }

  Widget _inputData(
      String _title, _type, TextEditingController _inputController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _title,
          style: const TextStyle(
              color: Colors.black54,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400),
        ),
        TextFormField(
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: "Sofia",
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 22),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          autofocus: false,
          readOnly: true,
          controller: _inputController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(
                fontFamily: "Sofia",
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 22),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );

            if (pickedTime != null) {
              print(pickedTime.format(context)); //output 10:51 PM
              //DateTime parsedTime =
              //    DateFormat.jm().parse(pickedTime.format(context).toString());
              //converting to DateTime so that we can further format on different pattern.
              //  print(parsedTime); //output 1970-01-01 22:53:00.000
              //String formattedTime = DateFormat('HH:mm').format(parsedTime);
              // String formattedTime = DateFormat('HH:mm').format(pickedTime);
              // print(formattedTime); //output 14:59:00
              //DateFormat() is from intl package, you can format the time on any pattern you need.

              setState(() {
                // _timeController.text =
                //     formattedTime; //set the value of text field.
                _timeController.text = pickedTime.format(context).toString();
              });
            }
          },
        ),
      ],
    );
  }
}
