// ignore_for_file: must_be_immutable

import '../../../../app/widgets/layout/card/white_card.dart';
import '../../../../app/widgets/text/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Dashboard',
              style: CustomLabels.h1,
            ),
          ),
          SizedBox(height: 5),
          WhiteCard(
            title: 'Datos usuario',
            child: Text('Datos...'),
          ),
        ],
      ),
    );
  }
}
