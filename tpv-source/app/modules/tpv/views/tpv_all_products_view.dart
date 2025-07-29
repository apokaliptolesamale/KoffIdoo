// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/tpv/controllers/tpv_controller.dart';
import '../views/tpv_all_products_mobile_body_view.dart';
import '../views/tpv_all_products_tablet_body_view.dart';

class CustomOrientationBuilder extends StatefulWidget {
  const CustomOrientationBuilder({Key? key}) : super(key: key);

  @override
  State<CustomOrientationBuilder> createState() =>
      _CustomOrientationBuilderState();
}

class TpvAllProductsView extends GetResponsiveView<TpvController> {
  List<ProductModel> listOfSelectedProducts = [];
  TpvAllProductsView({
    Key? key,
  }) : super(
            key: key,
            settings: const ResponsiveScreenSettings(
              desktopChangePoint: 800,
              tabletChangePoint: 700,
              watchChangePoint: 600,
            ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE4E7),
      appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color(0xFFDCE4E7),
          title: TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
          actions: [
            Row(
              children: const [
                Text('XETID', style: TextStyle(color: Colors.black)),
                Icon(
                  Icons.store,
                  color: Colors.black,
                )
              ],
            )
          ]),
      body: CustomOrientationBuilder(),
    );
  }
}

class _CustomOrientationBuilderState extends State<CustomOrientationBuilder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return TpvAllProductsMobileBodyView();
      } else {
        return TpvAllProductsTabletBodyView();
      }
    });
  }
}
