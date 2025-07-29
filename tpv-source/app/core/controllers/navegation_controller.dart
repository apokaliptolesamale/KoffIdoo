import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();
  static final NavigationController instance =
      NavigationController._createInstance();

  NavigationController._createInstance();

  factory NavigationController() {
    return Get.find();
  }

  Future<dynamic> navidateTo(String routeName) {
    return navigationKey.currentState!.pushNamed(routeName);
  }

  goBack() => navigationKey.currentState!.pop();
}
