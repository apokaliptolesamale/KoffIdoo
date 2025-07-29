import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multiselect/multiselect.dart';

import '../../widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';

class InitialConfig2 extends StatefulWidget {
  const InitialConfig2({Key? key}) : super(key: key);
  @override
  State<InitialConfig2> createState() => InitialConfig2State();
}

class InitialConfig2State extends State<InitialConfig2> {
  final String uuid = '';
  final String id = '';
  final String imei = '';
  final String brand = '';
  final String model = '';
  final String type = '';
  final String comercio = '';
  final String status = '';
  List<String> paymentTypes = ['Electronico', 'Caja', 'POS', 'Todos'];
  List<String> selectedPaymentTypes = [];
  String selectedPaymentType = 'Todos';

  @override
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
                        ? MediaQuery.of(context).size.height * 0.15
                        : MediaQuery.of(context).size.height * 0.22,
                    child: LottieBuilder.asset(
                        'assets/images/animations/personal_info.zip')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const FittedBox(
                    child: Text(
                      'Empecemos por lo basico',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: minimalistDecoration,
                  child: DropDownMultiSelect(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      hint: const Text(
                        'Seleccione el metodo de pago',
                        style: TextStyle(color: Colors.black),
                      ),
                      options: paymentTypes,
                      selectedValues: selectedPaymentTypes,
                      onChanged: (value) {
                        if (value == 'Todos') {
                          setState(() {
                            selectedPaymentTypes = ['Todos'];
                          });
                        }
                        setState(() {
                          // selectedPaymentTypes = value;
                        });
                      }),
                ),
              ],
            ),
          );
        }));
  }
}
