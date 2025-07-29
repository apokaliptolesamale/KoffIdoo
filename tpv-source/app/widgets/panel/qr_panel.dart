// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/app/core/constants/style.dart';
import '../../../app/core/services/logger_service.dart';
//import '../../../app/modules/warranty/views/colors.dart';
import '../../../app/widgets/dialog/custom_dialog.dart';
import '../../../app/widgets/images/base64_image.dart';
import '../../../app/widgets/utils/size_constraints.dart';

typedef HandlerCallBack = Function(QrPanel panel, BuildContext context);

class QrPanel extends StatelessWidget {
  final String title;
  final String description;
  final String urlQr;
  final String logo;
  final String? base64;
  final bool loadFromUrl;
  HandlerCallBack? handler;
  BuildContext context;

  late CustomDialogBox? dialog;
  QrPanel({
    Key? key,
    required this.context,
    required this.title,
    required this.description,
    required this.urlQr,
    required this.logo,
    this.base64,
    this.loadFromUrl = true,
    this.handler,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    this.context = context;
    handler ??= (QrPanel panel, BuildContext ctl) {
      Navigator.of(context).pop();
    };
    final size = SizeConstraints(context: context);
    log("Loading url image from: $urlQr");
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (urlQr.isNotEmpty && Uri.tryParse(urlQr) != null) {
                dialog = CustomDialogBox(
                  context: context,
                  title: title,
                  description: description,
                  content: Container(
                    width: size.getWidthByPercent(50),
                    height: size.getHeightByPercent(50),
                    //padding: EdgeInsets.all(10),
                    child: Base64Image(
                      base64: base64 ?? "",
                      url: urlQr,
                      fromUrl: loadFromUrl,
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: Constants.padding / 2,
                    top: Constants.avatarRadius / 2 + Constants.padding / 2,
                    right: Constants.padding / 2,
                    bottom: Constants.padding / 2,
                  ),
                  actions: [
                    //Orden #
                    getQrWindowAcceptBotton()
                  ],
                  logo: Image.asset(logo),
                ).show();
              }
            },
            child: Container(
              width: 90,
              height: 90,
              padding: EdgeInsets.only(left: 12, top: 12),
              child: Base64Image(
                base64: "",
                url: urlQr,
                fromUrl: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(title),
          )
        ],
      ),
    );
  }

  Widget getQrWindowAcceptBotton() {
    return Container(
      height: 40,
      width: 250,
      margin: EdgeInsets.only(top: 30),
      child: MaterialButton(
        onPressed: () {
          if (dialog != null) {
            dialog!.close();
          }
        },
        shape: StadiumBorder(),
        color: aceptBottonColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3.0,
          ),
          child: Text(
            "Aceptar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
