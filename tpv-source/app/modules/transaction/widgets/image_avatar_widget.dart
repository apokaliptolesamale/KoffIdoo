
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final String? defaultImage;

  const ImageAvatarWidget(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      this.defaultImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(NetworkImage(imageUrl), context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (snapshot.error is Response &&
                (snapshot.error as Response).statusCode == 404) {
              return CircleAvatar(
                radius: radius,
                child: Image.asset(
                  "assets/images/backgrounds/enzona/im_foto_usuario.png",
                  scale: 0.1,
                ),
              );
            } else {
              return CircleAvatar(
                radius: radius,
                child: Image.asset(
                  "assets/images/backgrounds/enzona/im_foto_usuario.png",
                  scale: 0.1,
                ),
              );
            }
          } else {
            return CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(imageUrl),
            );
          }
        } else if (snapshot.error != null) {
          return CircleAvatar(
            radius: radius,
            child: Image.asset(
              "assets/images/backgrounds/enzona/im_foto_usuario.png",
              scale: 0.1,
            ),
          );
        } else {
          return CircleAvatar(
            radius: radius,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
