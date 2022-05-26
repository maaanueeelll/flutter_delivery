import 'package:flutter/material.dart';
import '/Library/snackbar_message.dart';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';
import '/models/userModel.dart';
import 'SignIn_Screen.dart';

class SignupTemplate1 extends StatefulWidget {
  const SignupTemplate1({Key? key}) : super(key: key);

  @override
  _SignupTemplate1State createState() => _SignupTemplate1State();
}

class _SignupTemplate1State extends State<SignupTemplate1> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/image/wholedata_logo_login.png"),
                      fit: BoxFit.fitWidth)),
            ),
            Container(
              height: _height,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black12.withOpacity(0.2)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230.0),
              child: Container(
                height: _height,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    color: Colors.grey.shade100),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "Crea il tuo account",
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
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        final validCharacters =
                                            RegExp(r'^[a-z0-9_\-.]+$');
                                        if (value == null ||
                                            value.isEmpty ||
                                            !validCharacters.hasMatch(value) ||
                                            value.length < 6) {
                                          String message =
                                              'Lunghezza minima 6 car. \nCaratteri in minuscolo. \nSono consentiti "_ ."';
                                          return _showDialog(context, message);
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _usernameController,
                                      autocorrect: false,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: true,
                                          fillColor: Colors.transparent,
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
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        String pattern =
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?)*$";
                                        RegExp regex = RegExp(pattern);
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return 'email non valida';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController,
                                      autocorrect: false,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          labelText: 'Email',
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
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 8) {
                                          return 'lunghezza min. 8 caratteri';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _passwordController,
                                      autocorrect: false,
                                      obscureText: true,
                                      autofocus: false,
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
                                          )),
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
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarMessage(
                                        'Creazione utente in corso'),
                                  );
                                  String username = _usernameController.text;
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  bool check = await registerUser(
                                      username, password, email);
                                  if (check) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Expanded(
                                          child: AlertDialog(
                                            title: const Text(
                                                'Attivazione account'),
                                            content: const Text(
                                                "Account creato con successo. \nEffettua l'accesso per completare la registrazione"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    PageRouteBuilder(
                                                        pageBuilder: (_, __,
                                                                ____) =>
                                                            const BottomNavigationBarT2()),
                                                  );
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
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Expanded(
                                          child: AlertDialog(
                                            title: const Text(
                                                'Attivazione account'),
                                            content: const Text(
                                                'Username o indirizzo email già registrati'),
                                            actions: [
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
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarMessage(
                                        'Controlla i campi obbligatori'),
                                  );
                                }
                              },
                              child: Container(
                                height: 52.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    //  gradient: const LinearGradient(colors: [
                                    //    Color(0xFFFEE140),
                                    //    Color(0xFFFA709A),
                                    //  ]),
                                    color: Colors.amber.shade700),
                                child: const Center(
                                    child: Text(
                                  "Registrati",
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
                        String message =
                            'Controlla la posta e clicca sul link che ti abbiamo inviato';

                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const SigninTemplate1()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Hai già un account?",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black87,
                                fontWeight: FontWeight.w200,
                                fontSize: 15.0),
                          ),
                          Text(" Accedi",
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.amber.shade700,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15.0))
                        ],
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

  _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            //title: const Text('Attivazione account'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Chiudi',
                  style: TextStyle(
                      fontFamily: "Sofia",
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
