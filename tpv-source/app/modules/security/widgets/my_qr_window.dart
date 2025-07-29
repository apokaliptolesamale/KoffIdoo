// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/qrflutter/src/qr_image.dart';
import '../../../widgets/qrflutter/src/qr_versions.dart';
import '../../../widgets/qrflutter/src/types.dart';
import '../domain/models/account_model.dart';
import '/app/modules/security/controllers/account_controller.dart';

import '../../../widgets/utils/size_constraints.dart';

class MyQrWindow extends StatelessWidget {
  // final Cordenate cordenate;

  // AddCardWindow({
  //   Key? key,
  //   required this.cordenate,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Get.find<AccountModel>();

    // Size parentSize = MediaQuery.of(context).size;
    SizeConstraints size = SizeConstraints(context: context);
    return GetBuilder<AccountController>(builder: (controller) {
      return AlertDialog(
        // icon: Icon(Icons.qr_code),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        scrollable: true,
        elevation: 15,
        title: Container(
          child: Center(
            child: Text(
              'Escanee el siguiente código QR para añadirme como amigo.',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: size.getWidthByPercent(4),
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        content: Container(
          height: size.getHeightByPercent(50),
          width: size.getWidthByPercent(65),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(25),
          //   color: Colors.amber,
          // ),
          alignment: Alignment.center,
          // color: Colors.amber,
          // height: 350,
          // width: 350,
          // height: size.getHeightByPercent(30),
          // width: size.getWidthByPercent(50),
          child: QrImage(
            data: account.contactCode,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(30, 30
                  // size.getHeightByPercent(5),
                  // size.getWidthByPercent(8),
                  ),
            ),
            embeddedImage:
                AssetImage('assets/images/backgrounds/enzona/ez.png'),
            // data: "${controller.account.contactCode}",

            version: QrVersions.auto,
            size: 250.0,
          ),
        ),
        // actions: [
        //   RoundedButton(
        //     text: "Aceptar",
        //     press: () {
        //       Get.back();
        //     },
        //   ),
        // ],
      );
    });
  }
}
