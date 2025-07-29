// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/app/modules/tpv/controllers/tpv_controller.dart';
import '/app/modules/tpv/views/initial-config_views/initial_config_1.dart';
import '/app/modules/tpv/views/initial-config_views/initial_config_2.dart';
import '/app/modules/tpv/views/initial-config_views/initial_config_3.dart';
import '/app/modules/tpv/views/initial-config_views/initial_config_4.dart';
import '/app/modules/tpv/views/initial-config_views/initial_config_5.dart';

class FirstTimeConfigView extends GetResponsiveView<TpvController> {
  bool onLastPage = false;
  PageController pageController = PageController();
  String? storeName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: OrientationBuilder(builder: (BuildContext context, orientation) {
          return Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  onLastPage = (index == 4);
                  TpvController().update();
                },
                children: const [
                  InitialConfig1(),
                  InitialConfig2(),
                  InitiaConfig3(),
                  InitialConfig4(),
                  InitialConfig5(),
                ],
              ),
              Container(
                  alignment: orientation == Orientation.portrait
                      ? const Alignment(0, 1.0)
                      : const Alignment(0, 1.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            pageController.jumpToPage(4);
                          },
                          child: Text('Saltar')),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 5,
                        effect: const WormEffect(),
                      ),
                      onLastPage
                          ? TextButton(
                              onPressed: () {
                                Get.toNamed('/tpv-home');
                              },
                              child: Text('Comenzar'))
                          : TextButton(
                              onPressed: () {
                                pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: Text('Siguiente')),
                      // SizedBox(
                      //   height: 100,
                      //   width: 100,
                      //   child: onLastPage
                      //       ? IconButton(
                      //           onPressed: () {
                      //             Get.toNamed('/tpv-home');
                      //           },
                      //           icon: Icon(
                      //             Icons.done,
                      //             size: 30,
                      //           ))
                      //       : IconButton(
                      //           onPressed: () {
                      //             if (onLastPage) {
                      //               Get.toNamed('/tpv-home');
                      //             } else {
                      //               pageController.nextPage(
                      //                   duration:
                      //                       const Duration(milliseconds: 500),
                      //                   curve: Curves.easeIn);
                      //             }
                      //           },
                      //           icon: Icon(
                      //             Icons.arrow_right_alt_sharp,
                      //             size: 30,
                      //           )),
                      // ),
                    ],
                  )),
            ],
          );
        }));
  }
}
