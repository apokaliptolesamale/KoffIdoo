// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

import '../qrflutter/qr_flutter.dart';

class QRGenerator extends StatefulWidget {
  ImageProvider<Object>? embeddedImage;
  QrEmbeddedImageStyle? embeddedImageStyle;
  double? size;
  String data;

  QRGenerator({
    Key? key,
    required this.data,
    this.embeddedImage,
    this.embeddedImageStyle,
    this.size = 100,
  }) : super(key: key);

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<QRGenerator> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: widget.data,
              size: widget.size,
              /*embeddedImage: widget.embeddedImage ??
                  AssetImage(ASSETS_IMAGES_WARRANTY_ICONS_WARRANTY_LOGO_PNG),
              embeddedImageStyle: widget.embeddedImageStyle ??
                  QrEmbeddedImageStyle(
                    size: Size(80, 80),
                  ),*/
            ),
          ],
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
  }
}
