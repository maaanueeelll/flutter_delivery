import 'dart:convert';
import 'package:flutter/material.dart';
import '/Library/snackbar_message.dart';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';
import 'package:food_template/models/userModel.dart';
import 'Signup_Screen.dart';

class SigninTemplate1 extends StatefulWidget {
  const SigninTemplate1({Key? key}) : super(key: key);

  @override
  _SigninTemplate1State createState() => _SigninTemplate1State();
}

class _SigninTemplate1State extends State<SigninTemplate1> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: _height,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/image/wholedata_logo_login.png")
                        .image,
                    fit: BoxFit.fitWidth),
              ),
            ),
            Container(
              height: _height,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black12.withOpacity(0.2)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Container(
                height: _height,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  // color: Color(0xFF1E2026)),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "Bentornato!",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 40.0),
                            child: Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.15,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 5.0),
                                child: Theme(
                                  data:
                                      ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'campo obbligatorio';
                                        } else if (value.length < 6) {
                                          return 'lunghezza min. 6 caratteri';
                                        }
                                        return null;
                                      },
                                      controller: _userController,
                                      enabled: _isEnabled,
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: false,
                                          fillColor: Colors.black,
                                          labelText: 'Username',
                                          hintStyle:
                                              TextStyle(color: Colors.black87),
                                          labelStyle: TextStyle(
                                            color: Colors.black54,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.15,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 5.0),
                                child: Theme(
                                  data:
                                      ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'campo obbligatorio';
                                        } else if (value.length < 8) {
                                          return 'lunghezza min. 6 caratteri';
                                        }
                                        return null;
                                      },
                                      controller: _passwordController,
                                      enabled: _isEnabled,
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      autofocus: false,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: 'Password',
                                        hintStyle:
                                            TextStyle(color: Colors.black87),
                                        labelStyle: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 64.0),
                            child: InkWell(
                              onTap: () async {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  _isEnabled = false;
                                  Token token = await login(
                                      _userController.text,
                                      _passwordController.text);
                                  if (token.accessToken != '') {
                                    User user =
                                        await fetchUserdata(token.accessToken);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarMessage('Accesso in corso'),
                                    );
                                    if (!user.isVerified) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Expanded(
                                            child: AlertDialog(
                                              title: const Text(
                                                  'Attivazione account'),
                                              content: const Text(
                                                  "Account non attivato. \nControlla la posta e clicca sul link di attivazione."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    // PERFORM SEND EMAIL

                                                    bool check =
                                                        await sendEmailActivation(
                                                            token.accessToken);
                                                    if (check) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Invia di nuovo',
                                                    style: TextStyle(
                                                        fontFamily: "Sofia",
                                                        color:
                                                            Colors.blueAccent,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Chiudi',
                                                    style: TextStyle(
                                                        fontFamily: "Sofia",
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      bool saved = await saveUserStorage(
                                          jsonEncode(user));
                                      if (saved) {
                                        Navigator.of(context).pushReplacement(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ____) =>
                                                  const BottomNavigationBarT2()),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          snackBarMessage('accesso effettuato'),
                                        );
                                      }
                                    }
                                  } else {
                                    _isEnabled = true;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarMessage(
                                          'Errore accesso, controlla la password e lo username'),
                                    );
                                  }
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 52.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    color: Colors.amber.shade700
                                    // gradient: LinearGradient(colors: [
                                    //   // Color(0xFFFEE140),
                                    //   //Color(0xFFFA709A),
                                    //   Colors.red.shade200,
                                    //   Colors.amber.shade700,
                                    // ]),
                                    ),
                                child: const Center(
                                    child: Text(
                                  "Accedi",
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
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const SignupTemplate1()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Non hai un account?",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black87,
                                fontWeight: FontWeight.w200,
                                fontSize: 15.0),
                          ),
                          Text(
                            " Registrati",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.amber.shade700,
                                fontWeight: FontWeight.w300,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        child: const Text(
                          'indietro',
                          style: TextStyle(
                            fontFamily: "Sofia",
                            //color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                                pageBuilder: (_, __, ____) =>
                                    const BottomNavigationBarT2()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
