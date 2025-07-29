import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


import '../../../widgets/utils/size_constraints.dart';
import 'ez_qr_scanned.dart';

class EzQrScanView extends StatefulWidget {
  EzQrScanView({
    Key? key,
  }) : super(key: key);

  @override
  State<EzQrScanView> createState() => _EzQrScanViewState();
}

class _EzQrScanViewState extends State<EzQrScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escanear QR"),
        leading: IconButton(
            iconSize: 25,
            splashRadius: 25,
            onPressed: (() => Get.back()),
            icon: const Icon(Icons.arrow_back_ios)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                  fit: BoxFit.fill)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.lightGreen, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            Get.to(() => EzQrScannedView(
                  barcode: result!,
                  // formatCode: formatCode,
                  // rawBytes: rawBytes,
                ));
          },
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.pauseCamera();
        Get.snackbar("Atencion!!!", "QR escaneado con exito");
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
