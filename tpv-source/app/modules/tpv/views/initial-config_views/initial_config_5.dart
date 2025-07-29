import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class InitialConfig5 extends StatefulWidget {
  const InitialConfig5({key});

  @override
  State<InitialConfig5> createState() => _InitialConfig5State();
}

class _InitialConfig5State extends State<InitialConfig5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(builder: (BuildContext context, orientation) {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'El TPV esta listo para vender!',
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.65
                      : MediaQuery.of(context).size.height * 0.60,
                  child:
                      LottieBuilder.asset('assets/images/animations/ft4.zip'),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/tpv-home');
                    },
                    child: Text('Comenzar'))
              ],
            ),
          ),
        );
      }),
    );
  }
}
