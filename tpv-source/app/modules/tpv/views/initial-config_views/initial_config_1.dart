import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InitialConfig1 extends StatelessWidget {
  const InitialConfig1({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: const Text(
                'Hola!',
                style: TextStyle(fontSize: 45),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.8,
              child: const FittedBox(
                child: Text(
                  'Vamos a configurar el TPV por primera vez',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Lottie.asset('assets/images/animations/ft1.zip')),
          ],
        ),
      ),
    );
  }
}
