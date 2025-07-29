import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart' as mobileScaner;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../widgets/utils/size_constraints.dart';
import '../bindings/transfer_binding.dart';
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
  Color? colorFloatingBoton = Colors.grey;
  bool? flashStatus = false;
  // mobileScaner.MobileScannerController cameraController =
  //     mobileScaner.MobileScannerController();

  // @override
  // void initState() async {

  //   // flashStatus = await controller!.getFlashStatus();a
  //   super.initState();
  // }

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
        actions: [
          IconButton(
              onPressed: () async {
                flashStatus = await controller!.getFlashStatus();
                if (flashStatus == false) {
                  setState(() {
                    controller!.toggleFlash();
                    flashStatus = !flashStatus!;
                  });
                } else {
                  setState(() {
                    controller!.toggleFlash();
                    flashStatus = !flashStatus!;
                  });
                  // controller!.toggleFlash();
                  // flashStatus = !flashStatus!;
                }
              },
              icon: flashStatus == false
                  ? Icon(Icons.flash_off)
                  : Icon(Icons.flash_on))
        ],
        // actions: [
        // IconButton(
        //   color: Colors.white,
        //   icon:
        //   ValueListenableBuilder(
        //     valueListenable: ,
        //     builder: (context, state, child) {
        //       switch (state as mobileScaner.TorchState) {
        //         case mobileScaner.TorchState.off:
        //           return const Icon(Icons.flash_off, color: Colors.grey);
        //         case mobileScaner.TorchState.on:
        //           return const Icon(Icons.flash_on, color: Colors.yellow);
        //       }
        //     },
        //   ),
        //   iconSize: 32.0,
        //   onPressed: () => cameraController.toggleTorch(),
        // ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              overlay: QrScannerOverlayShape(borderColor: Colors.red),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: colorFloatingBoton, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            Get.to(
                () => EzQrScannedView(
                      code: result!.code!,
                      // formatCode: formatCode,
                      // rawBytes: rawBytes,
                    ),
                binding: TransferBinding());
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
        colorFloatingBoton = Colors.lightGreenAccent;
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
