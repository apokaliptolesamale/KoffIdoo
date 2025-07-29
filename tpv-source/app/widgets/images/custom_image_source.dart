// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app/core/services/logger_service.dart';
import '../../../app/widgets/images/network_image_ssl.dart';
import '../../../app/widgets/promise/custom_future_builder.dart';
import '../../core/config/assets.dart';
import '../../core/helpers/functions.dart';

class CustomImageResource extends StatefulWidget {
  String url;
  bool container = false;
  BuildContext context;
  CustomImageResource({
    Key? key,
    required this.url,
    required this.context,
    container = false,
  }) : super(key: key);

  @override
  State<CustomImageResource> createState() => _CustomImageResourceState();
  static Widget buildFromUrl(
    BuildContext context,
    String path, {
    bool container = false,
  }) {
    final isremote = isUrlRemote(path);

    if (isremote) {
      try {
        //Uri? uri = Uri.tryParse(path);
        //final provider = getImageProvider(File(path));
        final provider = NetworkImageSSL(path);
        return Image(image: provider);
        /* if (provider is AssetImage) return Image(image: provider);

        if (uri != null) {
          return CustomFutureBuilder(
            future: HttpClient().getUrl(uri),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                log(snapshot.data ?? "");
                return !container
                    ? Image.network(
                        path,
                      )
                    : Container(
                        margin: const EdgeInsets.all(6.0),
                        child: Image.network(
                          path,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                return Image(
                    image: AssetImage(
                  ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
                ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Image(
                    image: AssetImage(
                  ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
                ));
              } else {
                return Image(
                    image: AssetImage(
                  ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
                ));
              }
            },
          );
        }*/
      } on Exception catch (ex) {
        log(ex.toString());
      }
      return Image(
          image: AssetImage(
        ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
      ));
    }
    //Locales
    try {
      File(path).exists();

      return CustomFutureBuilder(
        context: context,
        future: File(path).exists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError &&
              snapshot.data == true) {
            return !container
                ? Image(image: AssetImage(path))
                : Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
          } else if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError &&
              snapshot.data == false) {
            return Image(
                image: AssetImage(
              ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Image(
                image: AssetImage(
              ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
            ));
          } else {
            return Image(
                image: AssetImage(
              ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
            ));
          }
        },
      );
    } on Exception {
      //log(11111111);
    }
    return Image(
        image: AssetImage(
      ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
    ));
  }

  static ImageProvider getImageProvider(File f) {
    return f.existsSync()
        ? FileImage(f) as ImageProvider
        : AssetImage(ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG);
  }
}

class _CustomImageResourceState extends State<CustomImageResource> {
  @override
  Widget build(BuildContext context) {
    return CustomImageResource.buildFromUrl(context, widget.url,
        container: widget.container);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
  }
}
