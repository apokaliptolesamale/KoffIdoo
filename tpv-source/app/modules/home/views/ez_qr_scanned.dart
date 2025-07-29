import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/services/logger_service.dart';

import '../../../widgets/utils/size_constraints.dart';
import '../../security/widgets/main_app_bar.dart';

class EzQrScannedView extends StatefulWidget {
  final Barcode barcode;
  // final BarcodeFormat formatCode;
  // final dynamic rawBytes;
  const EzQrScannedView({
    Key? key,
    required this.barcode,
    // required this.formatCode,
    // required this.rawBytes
  }) : super(key: key);

  @override
  State<EzQrScannedView> createState() => _EzQrScannedViewState();
}

class _EzQrScannedViewState extends State<EzQrScannedView> {
  String code = "";
  late Barcode? barcode;
  dynamic rawBytes;

  dynamic parseCoded;

  @override
  void initState() {
    parseCode();
    super.initState();
  }

  parseCode() {
    barcode = widget.barcode;
    var aux = barcode!.format;
    var tmp = barcode!.code;
    var aux2 = barcode!.rawBytes;
    var aux3 = base64Encode(aux2!);
    code = aux3;
    var aux4 = base64Decode(code);
    rawBytes = String.fromCharCodes(aux4);
    // formatCode = widget.formatCode;
    // rawBytes = widget.rawBytes;
    log("ESTE ES BARCODE>>>>>>>>>>>>>>>>>$barcode");
    log("ESTE ES AUX>>>>>>>>>>>>>>>>>$aux");
    log("ESTE ES TMP>>>>>>>>>>>>>>>>>$tmp");
    // var aux2 = base64Decode(tmp!);

    // log("ESTE ES AUX2>>>>>>>>>>>>>>>>>$aux2");
    // log("ESTE ES AUX CON BASE64DECODE>>>>>>>$aux");

    // var tmp = String.fromCharCodes(aux);

    // log("ESTE ES TMP CON STRINGFROMCHARCODES>>>>>>>$tmp");

    // parseCoded = tmp;
  }

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Container(
      color: Colors.white,
      height: size.getHeight,
      child: Column(
        children: [
          MainAppBar(
            size: size,
            widgets: [
              LogoEZ(size: size),
            ],
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    /*0546d50280d5b14d5dabf7946d234eef3c codigo cuando es poniendo dinero */
                    /*02ed16e39c9a1342f389d80235e2044ffb codigo cuando es sin definir monto */
                    Text(barcode!.rawBytes.toString()),
                    Text(code),
                    Text(rawBytes),
                    // Text(code),
                    // Text(formatCode.toString()),
                    // Text(rawBytes),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
