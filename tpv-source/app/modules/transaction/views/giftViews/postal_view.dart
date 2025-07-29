import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../widgets/images/network_image_ssl.dart';
import '../../controllers/gift_controller.dart';

class PostalView extends GetView<GiftController> {
  const PostalView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final imageSslArgument =
        ModalRoute.of(context)!.settings.arguments as String;
    return GetBuilder<GiftController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('PostalView'),
        ),
        body: Center(
          child: Stack(children: [
            Container(
                child: FadeInImage(
                    placeholder: AssetImage('assets/images/postales.png'),
                    image: NetworkImageSSL(
                        '${Constants.mediaHost}$imageSslArgument'))),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 10,
                  //color: Colors.blue,
                  alignment: Alignment.center,
                  //padding: EdgeInsetsDirectional.only(bottom: size.height / 12),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: FadeInImage(
                          width: size.width / 5,
                          fit: BoxFit.cover,
                          placeholder:
                              AssetImage('assets/images/im_foto_usuario.png'),
                          image: NetworkImageSSL(
                              '' //'${Constants.mediaHost}${_.imageByUser}'
                              ) /* NetworkImage(
                                      '${Constants.mediaHost}images/user/avatar/ez_56651781.png') */

                          )),
                ),
                SizedBox(
                  height: size.height / 90,
                ),
                Text(
                  '', // _.recipientName,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Text(
                  '', // _.description,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Text(
                  '', //_.amount + ' ' + _.currency,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
