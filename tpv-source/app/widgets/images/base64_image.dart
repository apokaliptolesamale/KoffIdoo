// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../../../app/core/interfaces/header_request.dart';
import '../../../app/widgets/promise/custom_future_builder.dart';
import '../../core/config/assets.dart';
import '../../core/helpers/functions.dart';

class Base64Image extends StatefulWidget {
  String base64;
  String? url;
  bool fromUrl;
  double width, height;
  Base64Image({
    Key? key,
    required this.base64,
    this.fromUrl = false,
    this.width = 100,
    this.height = 100,
    this.url,
  }) : super(key: key);

  @override
  State<Base64Image> createState() => _Base64ImageState();
}

class _Base64ImageState extends State<Base64Image>
    with SingleTickerProviderStateMixin {
  Uint8List? data;
  bool isRemote = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.fromUrl) {
      return Container(
        width: widget.width,
        height: widget.height,
        child: Image.memory(
          base64Decode(widget.base64),
        ),
      );
    }
    return CustomFutureBuilder(
      future: getFromUrl(),
      builder: getBuilder(),
      context: context,
    );
  }

  AsyncWidgetBuilder<dynamic> getBuilder() {
    return (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError ||
          snapshot.connectionState == ConnectionState.waiting) {
        return Image(
            image: AssetImage(
          ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
        ));
      }
      return Image.memory(base64Decode(snapshot.data));
    };
  }

  Future<String> getFromUrl() async {
    final header = HeaderRequestImpl(
      idpKey: "apiez",
    );
    final headers = await header.getHeaders();
    //log(getCurl(widget.url!, headers));
    try {
      widget.base64 = isRemote
          ? (await get(
              Uri.parse(widget.url!),
              headers: headers,
            ))
              .body
          : base64String(
              (await rootBundle.load(ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG))
                  .buffer
                  .asUint8List());
    } catch (ex) {
      widget.base64 = base64String(
          (await rootBundle.load(ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG))
              .buffer
              .asUint8List());
    }

    data = Uint8List.fromList(widget.base64.codeUnits);
    return Future.value(widget.base64);
  }

  @override
  initState() {
    isRemote = widget.fromUrl && widget.url != null && widget.url!.isNotEmpty
        ? isUrlRemote(widget.url!)
        : false;

    super.initState();
  }
}
