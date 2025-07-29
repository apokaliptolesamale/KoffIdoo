import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/gift_controller.dart';

class FriendsView extends GetView<GiftController> {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            iconSize: size.height / 30,
          )
        ],
        title: Text(
          'Mis Amigos',
          style: TextStyle(fontSize: size.width / 20),
        ),
        leading: IconButton(
            iconSize: size.width / 20,
            splashRadius: 20,
            onPressed: (() => Get.back()),
            icon: const Icon(Icons.arrow_back_ios)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/fondo_inicio_2.png"),
                  fit: BoxFit.fill)),
        ),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    //Get.toNamed(Routes.REGALARVIEW);
                  },
                  leading: ClipRRect(
                    child: Image.asset('assets/images/im_foto_usuario.png',
                        height: size.height / 15),
                  ),
                  title: Text(
                    'Esperando por API de amigos, en proceso',
                    style: TextStyle(fontSize: size.height / 60),
                  ),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
