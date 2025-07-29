// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/widgets/splash/custom_splash.dart';
import 'controllers/splash_controller.dart';

class SplashPage extends GetResponsiveView<SplashController> {
  bool? isNetWorkAvaliable;
  Function()? onReload;
  Widget? backGround;

  SplashPage({
    this.isNetWorkAvaliable = false,
    this.backGround,
    this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      isNetWorkAvaliable: isNetWorkAvaliable!,
      onReload: onReload,
      backGround: backGround,
    );
  }
}
