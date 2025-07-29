import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../modules/security/data/providers/token_provider.dart';

abstract class SecureGetxController extends GetxController {
  static SecureGetxController instance = Get.find();

  final GlobalKey<NavigatorState> navigationKey = GlobalKey();
  final TokenProvider tokenProvider = Get.find<TokenProvider>();
  late final GetConnectInterface provider;

  Future<dynamic> navidateTo(String routeName) {
    return navigationKey.currentState!.pushNamed(routeName);
  }

  goBack() => navigationKey.currentState!.pop();
}
