import 'package:flutter/material.dart';

import '../../core/config/assets.dart';
import '../images/custom_image_source.dart';

class CustomCircleAvatar extends StatefulWidget {
  CustomCircleAvatar({Key? key}) : super(key: key);

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: CircleAvatar(
        radius: 16.0,
        child: ClipRRect(
          child: CustomImageResource.buildFromUrl(
            context,
            ASSETS_IMAGES_ICONS_APP_CUENTA_PNG,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
