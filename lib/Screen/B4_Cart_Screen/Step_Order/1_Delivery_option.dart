import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:food_template/Screen/B4_Cart_Screen/Step_Order/2_Time_Screen.dart';
import 'package:intl/intl.dart';
import '/models/cartModel.dart';
import '/models/restaurantModel.dart';
import '/models/userModel.dart';
import '/Library/no_connection.dart';

class DeliveryScreenT2 extends StatefulWidget {
  DeliveryScreenT2({
    Key? key,
    required this.cart,
    required this.user,
    required this.restaurant,
  }) : super(key: key);

  CartModel? cart;
  final User? user;
  final Restaurant? restaurant;
  @override
  _DeliveryScreenT2State createState() => _DeliveryScreenT2State();
}

class _DeliveryScreenT2State extends State<DeliveryScreenT2> {
  bool enabled = true;
  bool pickUp = false;
  late CartModel? _cart;
  late User? _user;
  late Restaurant? _restaurant;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _cart = widget.cart;
    _user = widget.user;
    _restaurant = widget.restaurant;
    _userController.text = '${_user!.firstName} ${_user!.lastName}';
    _cityController.text = _user!.city;
    _addressController.text = _user!.address;
    _telephoneController.text = _user!.telephone;
    _noteController.text = '';
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
        title: const Text(
          "Indirizzo di consegna",
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
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                InputDataField(
                  title: 'NOME COMPLETO',
                  type: 'text',
                  inputController: _userController,
                  enabled: enabled,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputDataField(
                  title: 'INDIRIZZO',
                  type: 'text',
                  inputController: _addressController,
                  enabled: enabled,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputDataField(
                  title: 'CITTA',
                  type: 'text',
                  inputController: _cityController,
                  enabled: enabled,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputDataField(
                  title: 'TELEFONO',
                  type: 'number',
                  inputController: _telephoneController,
                  enabled: enabled,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputDataField(
                  title: 'NOTE CONSEGNA',
                  type: 'text',
                  inputController: _noteController,
                  enabled: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Ritiro io in negozio',
                      style: TextStyle(fontSize: 17.0),
                    ), //Text
                    const SizedBox(
                      width: 10,
                    ),
                    Checkbox(
                      value: pickUp,
                      onChanged: (bool? value) {
                        setState(() {
                          pickUp = value!;
                          if (pickUp) {
                            _cart!.pickup = true;
                            _cart!.deliveryFee = 0;
                            _cart!.deliverType = 'TO-GO';
                          } else {
                            _cart!.pickup = false;
                            _cart!.deliveryFee = _restaurant!.deliveryFees;
                            _cart!.deliverType = 'CONSEGNA';
                          }

                          if (enabled) {
                            enabled = false;
                          } else {
                            enabled = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    _cart!.note = _noteController.text;
                    _cart!.address = _addressController.text;
                    _cart!.city = _cityController.text;
                    _cart!.telephone = _telephoneController.text;
                    _cart!.email = _user!.email;
                    _cart!.fullName = _userController.text;
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => TimeScreenT2(
                          user: _user,
                          restaurant: _restaurant,
                          cart: _cart,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 55.0,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Selziona l'orario",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sofia",
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        color: Colors.amber.shade700),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        disconnected: const NoConnection(),
      ),
    );
  }
}

class InputDataField extends StatelessWidget {
  InputDataField({
    Key? key,
    required this.title,
    required this.type,
    required this.inputController,
    required this.enabled,
  }) : super(key: key);
  String title, type;
  TextEditingController inputController;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w600,
              color: Colors.black54),
        ),
        TextFormField(
          textAlign: TextAlign.start,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          autofocus: false,
          enabled: enabled,
          controller: inputController,
          decoration: InputDecoration(
            hintText: inputController.text,
            hintStyle: const TextStyle(
                fontFamily: "Sofia",
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 17.0),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
