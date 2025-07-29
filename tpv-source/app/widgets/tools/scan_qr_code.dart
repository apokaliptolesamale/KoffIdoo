// ignore_for_file: library_private_types_in_public_api, must_be_immutable, camel_case_types

import 'dart:io';

//import '../../../app/widgets/qrscanner/scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../app/core/services/logger_service.dart';

final recognisedCodes = <ExpectedScanResult>[
  ExpectedScanResult('cake', Icons.cake),
  ExpectedScanResult('cocktail', Icons.local_drink_outlined),
  ExpectedScanResult('coffee', Icons.coffee),
  ExpectedScanResult('burger', Icons.fastfood_rounded),
];

onEmptyScanCallBack(Barcode code) {}

typedef onScanCallBack = Function(Barcode code);

class ExpectedScanResult {
  final String type;
  final IconData icon;

  ExpectedScanResult(
    this.type,
    this.icon,
  );
}

class QRCodeView extends StatefulWidget {
  onScanCallBack onScan;
  String callBack;

  QRCodeView({Key? key, required this.onScan, this.callBack = "/"})
      : super(key: key);

  @override
  _QRCodeViewState createState() => _QRCodeViewState();
}

class _Either<L, R> {
  final L? left;
  final R? right;

  _Either(this.left, this.right);
  _Either.Left(L this.left) : right = null;
  _Either.Right(R this.right) : left = null;
}

class _QRCodeViewState extends State<QRCodeView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Barcode? result;
  QRViewController? controller;
  late onScanCallBack onScan;
  int counter = 0;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    try {
      if (controller != null) {
        controller!.pauseCamera();
        /* Future.any([
          Future.delayed(
              Duration(seconds: 5),
              () => _Either.Right(
                    Exception('Client connection timeout after 5 secounds.'),
                  )),
          Future(() async {
            try {
              await controller!.pauseCamera();
              final result = _Either.Left(true);
              controller?.dispose();
              return result;
            } on Exception catch (e) {
              return _Either.Right(e);
            }
          }) //
        ]).then((value) {
          if (value.right != null) {
            throw value.right!;
          }
          return value.left!;
        });*/
      }
    } on CameraException catch (ex) {
      error("Error escanenando el QR. Detalles: ${ex.description}");
    } finally {
      super.dispose();
    }
  }

  @override
  initState() {
    onScan = widget.onScan;
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (controller != null) {
      if (Platform.isAndroid) {
        await controller!.pauseCamera();
      }
      controller!.resumeCamera();
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    //final id = 'QR';

    final qrView = NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        /* Future.microtask(() => QRViewController.updateDimensions(
            qrKey, MethodChannel(globalApplicationId+'/qrview_$id')));
        return false;*/
        return false;
      },
      child: SizeChangedLayoutNotifier(
        key: Key('qr-size-notifier'),
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    );
    return qrView;
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sin permiso')),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
      counter = 0;
      controller.resumeCamera();
    });

    //TODO para implementar cuando la lectura QR en flutter para la web esté implementada de forma estable y funcional.
    //https://github.com/juliuscanute/qr_code_scanner#android-integration
    //final expectedCodes = recognisedCodes.map((e) => e.type);
    controller.scannedDataStream.listen((scanData) async {
      counter++;
      if (Platform.isAndroid) {
        await controller.pauseCamera();
      }
      final value = await onScan(scanData);
      if (counter == 1) {
        result = scanData; //
        setState(() {
          result = scanData;
        });
        //final url = "${widget.callBack}?${getShemaQueryFromMap(value)}";
        //Navigator.of(context).pushNamed(url);
        Get.toNamed(widget.callBack, arguments: value);
      }

      /**
       // If the scanned code matches any of the items in our list...
    if (expectedCodes.any((element) => scanData.code == element)) {
      // ... then we open the page confirming the order with our user
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderPage(
            // Pass in the recognised item to the Order Page
            item: recognisedCodes.firstWhere((element) => element.type == scanData.code),
          ),
        ),
      );
    } 
       
      */
    });
  }
}
