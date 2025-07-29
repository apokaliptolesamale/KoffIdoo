// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class SideBar extends GetResponsiveView<HomeController> {
  final Widget sideBarContainer;

  SideBar({Key? key, required this.sideBarContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sideBarContainer;
  }
}
