import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';

class InitiaConfig3 extends StatefulWidget {
  const InitiaConfig3({key});

  @override
  State<InitiaConfig3> createState() => _InitiaConfig3State();
}

class _InitiaConfig3State extends State<InitiaConfig3> {
  String storeName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        resizeToAvoidBottomInset: false,
        body: OrientationBuilder(builder: (BuildContext context, orientation) {
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.18
                      : MediaQuery.of(context).size.height * 0.25,
                  child: LottieBuilder.asset(
                      'assets/images/animations/tpv_from_config_screen.zip',
                      height: 150),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const FittedBox(
                    child: Text(
                      'Sobre el TPV',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: minimalistDecoration,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Nombre local del TPV',
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Introduzca un nombre';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        value.toString();
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: minimalistDecoration,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la tienda',
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Introduzca un nombre';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        storeName = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
