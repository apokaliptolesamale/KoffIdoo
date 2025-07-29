import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/tpv/controllers/tpv_controller.dart';

class CustomOrientationBuilder extends StatefulWidget {
  const CustomOrientationBuilder({Key? key}) : super(key: key);

  @override
  State<CustomOrientationBuilder> createState() =>
      _CustomOrientationBuilderState();
}

class TpvOpeningView extends GetResponsiveView<TpvController> {
  TpvOpeningView({
    Key? key,
  }) : super(
            key: key,
            settings: const ResponsiveScreenSettings(
              desktopChangePoint: 800,
              tabletChangePoint: 700,
              watchChangePoint: 600,
            ));

  @override
  Widget build(BuildContext context) {
    return CustomOrientationBuilder();
  }
}

class _CustomOrientationBuilderState extends State<CustomOrientationBuilder> {
  int totalCash = 0,
      cant1 = 0,
      cant3 = 0,
      cant5 = 0,
      cant10 = 0,
      cant20 = 0,
      cant50 = 0,
      cant100 = 0,
      cant200 = 0,
      cant500 = 0,
      cant1000 = 0,
      tempNumber = 0;

  TpvController tpvController = Get.find<TpvController>();
  @override
  Widget build(BuildContext context) {
    totalCash = setTotalCash();
    return Scaffold(
        backgroundColor: const Color(0xFFDCE4E7),
        drawer: const Drawer(
          backgroundColor: Color(0xFFDCE4E7),
        ),
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: const Color(0xFFDCE4E7),
            actions: [
              Row(
                children: const [
                  Text(
                    'XETID',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.store,
                    color: Colors.black,
                  )
                ],
              )
            ]),
        body: OrientationBuilder(builder: (((context, orientation) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [Text('Fecha'), Text('Hora')],
                    )
                  ],
                ),
                Text(
                  'Apertura',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                openingWidget(context),
                Divider(
                  color: Colors.lightBlue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total en caja'),
                    Text('$totalCash CUP'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    TextButton(
                        onPressed: () {
                          //go to the next page
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.055,
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 4, top: 4),
                          decoration: BoxDecoration(
                              color: Color(0xFF5091C9),
                              borderRadius: BorderRadius.circular(22)),
                          child: const FittedBox(
                            child: Text(
                              'Aceptar',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ),
          );
        }))));
  }

  Widget openingWidget(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Billetes'),
              Text('Cantidades'),
              Text('Total'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('1'),
              TextButton(
                onPressed: () {
                  setAmount(cant1);
                },
                child: Text(cant1.toString()),
              ),
              Text((1 * cant1).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('3'),
              TextButton(
                  onPressed: (setAmount(cant3)), child: Text(cant3.toString())),
              Text((3 * cant3).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('5'),
              TextButton(
                  onPressed: () {
                    setAmount(cant5);
                  },
                  child: Text(cant5.toString())),
              Text((5 * cant5).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('10'),
              TextButton(
                  onPressed: (setAmount(cant10)),
                  child: Text(cant10.toString())),
              Text((10 * cant10).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('20'),
              TextButton(
                  onPressed: (setAmount(cant20)),
                  child: Text(cant20.toString())),
              Text((20 * cant20).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('50'),
              TextButton(
                  onPressed: () {
                    setAmount;
                  },
                  child: Text(cant50.toString())),
              Text((50 * cant50).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('100'),
              TextButton(
                  onPressed: setAmount(cant100),
                  child: Text(cant100.toString())),
              Text((100 * cant100).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('200'),
              TextButton(
                  onPressed: setAmount(cant200),
                  child: Text(cant200.toString())),
              Text((200 * cant200).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('500'),
              TextButton(
                  onPressed: setAmount(cant500),
                  child: Text(cant500.toString())),
              Text((500 * cant500).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('1000'),
              TextButton(
                  onPressed: setAmount(cant1000),
                  child: Text(cant1000.toString())),
              Text((1000 * cant1000).toString()),
            ],
          ),
        ],
      ),
    );
  }

  int setTotalCash() {
    int tC = 0;
    tC = cant1 +
        cant3 * 3 +
        cant5 * 5 +
        cant10 * 10 +
        cant20 * 20 +
        cant50 * 50 +
        cant100 * 100 +
        cant200 * 200 +
        cant500 * 500 +
        cant1000 * 1000;
    return tC;
  }

  setAmount(int denomination) async {
    TextEditingController amountController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Amount'),
          content: TextFormField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Amount'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                setState(() {
                  int amount = int.tryParse(amountController.text) ?? 0;
                  switch (denomination) {
                    case 1:
                      cant1 = amount;
                      break;
                    case 3:
                      cant3 = amount;
                      break;
                    case 5:
                      cant5 = amount;
                      break;
                    case 10:
                      cant10 = amount;
                      break;
                    case 20:
                      cant20 = amount;
                      break;
                    case 50:
                      cant50 = amount;
                      break;
                    case 100:
                      cant100 = amount;
                      break;
                    case 200:
                      cant200 = amount;
                      break;
                    case 500:
                      cant500 = amount;
                      break;
                    case 1000:
                      cant1000 = amount;
                      break;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
