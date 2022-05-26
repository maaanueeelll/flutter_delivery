import 'package:flutter/material.dart';
import '/Screen/Bottom_Nav_Bar/Bottom_Navigation_Bar.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Opppsss! \nqualcosa è andato storto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Sofia",
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset('assets/image/no_connection.png'),
          const Text(
            'Opppsss! \nqualcosa è andato storto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Sofia",
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                    pageBuilder: (_, __, ____) => BottomNavigationBarT2()),
              );
            },
            child: const Text(
              'Riprova',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
