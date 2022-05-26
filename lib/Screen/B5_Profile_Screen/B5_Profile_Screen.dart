import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:food_template/Library/no_connection.dart';
import 'package:food_template/Library/snackbar_message.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';
import '/constants.dart';
import '/models/userModel.dart';

class ProfileScreenT2 extends StatefulWidget {
  const ProfileScreenT2({Key? key}) : super(key: key);

  @override
  _ProfileScreenT2State createState() => _ProfileScreenT2State();
}

class _ProfileScreenT2State extends State<ProfileScreenT2> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipcodeController = TextEditingController();

  bool _isEnabled = true;
  File? _image;
  User? _user;

  /// Get from gallery
  _getImageFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUserdataFromPref().then((User user) {
      setState(() {
        _user = user;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipcodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: fetchUserdataFromPref(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //  print('ERRORE $snapshot.error');
          return const Center(
            child: Text(
              'An error has occurred!',
              style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          _usernameController.text = snapshot.data!.username;
          _firstNameController.text = snapshot.data!.firstName;
          _lastNameController.text = snapshot.data!.lastName;
          _emailController.text = snapshot.data!.email;
          _telephoneController.text = snapshot.data!.telephone;
          _addressController.text = snapshot.data!.address;
          _cityController.text = snapshot.data!.city;
          _zipcodeController.text = snapshot.data!.zipCode;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white70,
              toolbarHeight: 8,
              elevation: 1,
            ),
            body: ConnectionNotifierToggler(
              onConnectionStatusChanged: (connected) {
                /// that means it is still in the initialization phase.
                if (connected == null) return;
                // print(connected);
              },
              connected: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      // const Image(
                      //   image: AssetImage(
                      //       'assets/Template1/image/profileBackground.png'),
                      //   height: 250.0,
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                      //  Container(
                      //    height: 255.0,
                      //    margin: const EdgeInsets.only(top: 0.0, bottom: 105.0),
                      //    decoration: BoxDecoration(
                      //      gradient: LinearGradient(
                      //        begin: const FractionalOffset(0.0, 0.0),
                      //        end: const FractionalOffset(0.0, 1.0),
                      //        // stops: [0.0, 1.0],
                      //        colors: <Color>[
                      //          const Color(0xFF1E2026).withOpacity(0.1),
                      //          const Color(0xFF1E2026).withOpacity(0.3),
                      //          const Color(0xFF1E2026),
                      //          //  Color(0xFF1E2026),
                      //        ],
                      //      ),
                      //    ),
                      //  ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 70,
                            left: 25,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Container(
                                      height: 90.0,
                                      width: 90.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://${BASE_URL + snapshot.data!.imagePath}'),
                                            fit: BoxFit.cover),
                                        color: Colors.white60,
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black12.withOpacity(0.1),
                                            blurRadius: 10.0,
                                            spreadRadius: 7.0,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          // print('TAP ICON');
                                          _getImageFromGallery();
                                          setState(() {});
                                        },
                                        child: ClipOval(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.black87,
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.blueAccent,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 35.0,
                                    top: 20.0,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontFamily: "Sofia",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.0),
                                        ),
                                        Text(
                                          snapshot.data!.email.toString(),
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontFamily: "Sofia",
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ]),
                                ),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 200.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            buildUserInfoDisplay('Username', 'string',
                                _usernameController, false),
                            buildUserInfoDisplay('Nome', 'string',
                                _firstNameController, _isEnabled),
                            buildUserInfoDisplay('Cognome', 'string',
                                _lastNameController, _isEnabled),
                            buildUserInfoDisplay(
                                'Email', 'email', _emailController, _isEnabled),
                            buildUserInfoDisplay('Telefono', 'string',
                                _telephoneController, _isEnabled),
                            buildUserInfoDisplay('Indirizzo', 'string',
                                _addressController, _isEnabled),
                            buildUserInfoDisplay(
                                'Città', 'string', _cityController, _isEnabled),
                            buildUserInfoDisplay('CAP', 'number',
                                _zipcodeController, _isEnabled),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    bool check = await logout();
                                    if (check) {
                                      Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ____) =>
                                                const BottomNavigationBarT2()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        snackBarMessage('Uscita effettuata'),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        snackBarMessage('Qualcosa non va..'),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Esci',
                                    style: TextStyle(
                                        color: Colors.amber.shade700,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      primary: Colors.transparent,
                                      fixedSize: const Size(80, 40)),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      User user = await fetchUserdataFromPref();
                                      if (user.username != '') {
                                        user.firstName =
                                            _firstNameController.text;
                                        user.address = _addressController.text;
                                        user.lastName =
                                            _lastNameController.text;
                                        user.address = _addressController.text;
                                        user.email = _emailController.text;
                                        user.telephone =
                                            _telephoneController.text;
                                        user.address = _addressController.text;
                                        user.city = _cityController.text;
                                        user.zipCode = _zipcodeController.text;

                                        bool check = await updateUserdata(user);
                                        if (check) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            snackBarMessage(
                                                'Aggiornamento effettuato'),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.amber.shade700,
                                      fixedSize: const Size(130, 45)),
                                  child: const Text(
                                    'Salva',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.5,
                                        fontFamily: "Sofia"),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              disconnected: const NoConnection(),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white70,
              toolbarHeight: 8,
              elevation: 1,
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.amber.shade700,
              ),
            ),
          );
        }
      },
    );
  }
}

// Widget builds the display item with the proper formatting to display the user's info
Widget buildUserInfoDisplay(String title, type,
        TextEditingController _inputController, bool _isEnabled) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 350,
            height: 40,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black87,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    //  initialValue: getValue,
                    enabled: _isEnabled,
                    controller: _inputController,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      height: 1.4,
                    ),
                    //style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),
                // Icon(
                //   Icons.keyboard_arrow_right,
                //   color: Colors.grey,
                //   size: 40.0,
                // )
              ],
            ),
          )
        ],
      ),
    );
