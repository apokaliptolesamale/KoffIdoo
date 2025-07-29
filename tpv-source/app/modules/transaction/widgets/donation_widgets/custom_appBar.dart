import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DonationCustomAppBar extends StatelessWidget {
  final String title;
  const DonationCustomAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      leading: IconButton(
          iconSize: 25,
          splashRadius: 25,
          onPressed: (() => Get.back()),
          icon: const Icon(Icons.arrow_back_ios)),
      backgroundColor: Colors.blue,
      expandedHeight: size.height / 3,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            EdgeInsets.only(bottom: size.height / 50, right: size.width / 3),
        centerTitle: true,
        title: Container(
            //color: Colors.black12,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Text(title, style: TextStyle(fontSize: size.height / 40))),
        background: Image.asset(
          'assets/images/backgrounds/enzona/fondo_donar2.png',
          fit: BoxFit.cover,
        ),
        /*  FadeInImage(
          placeholder: AssetImage('assets/No_Image.jpg'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ), */
      ),
    );
  }
}
