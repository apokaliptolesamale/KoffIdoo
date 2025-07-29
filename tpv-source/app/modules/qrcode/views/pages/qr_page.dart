// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

import '/app/core/config/assets.dart';
import '../../../../widgets/images/background_image.dart';

class ShowQrPageView extends StatefulWidget {
  //OrderModel order;

  ShowQrPageView({
    Key? key,
    //required this.order,
  }) : super(key: key);

  @override
  _ShowQrPageViewState createState() => _ShowQrPageViewState();
}

class _ShowQrPageViewState extends State<ShowQrPageView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.all(14),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 10,
                ),
                Container(
                  child: Text(
                    'Escáner QR',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Container(
                        child: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.black,
                      size: 60,
                    )),
                  ),
                ),
                //END QR
                Container(
                  child: Text(
                    'Escáner de código de barra',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Container(
                        child: Icon(
                      Icons.bar_chart,
                      color: Colors.black,
                      size: 60,
                    )),
                  ),
                ),
                //BARCODE END
                Container(
                  child: Text(
                    'PIN',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    width: 120,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        '1234',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    )),
              ],
            )),
          ),
        )
      ],
    );
  }
}
