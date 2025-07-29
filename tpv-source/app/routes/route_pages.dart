// ignore_for_file: must_be_immutable

import 'package:get/get.dart';

import 'app_pages.dart';

class RoutePages {
  static final RoutePages instance =
      !Get.isRegistered() ? RoutePages._internal(0) : Get.find();

  int index;

  List<String> listOfPages = [
    "/warranty/home",
    "/orders",
    "/orders/order-info",
    "/warranty/product-info",
  ];

  RoutePages({
    required this.index,
    this.listOfPages = const [
      "/warranty/home",
      "/orders",
      "/orders/order-info",
      "/warranty/product-info",
    ],
  });
  factory RoutePages.fromRoute(String route, {List<String>? listOfPages}) {
    final gpr = RoutePages(index: 0);
    gpr.listOfPages = listOfPages ?? [];
    var index = gpr.index;
    route =
        route.contains('?') ? route.substring(0, route.indexOf("?")) : route;
    for (var element in gpr.listOfPages) {
      if (route.startsWith(element)) break;
      index++;
    }
    if (index < gpr.listOfPages.length) {
      gpr.setIndex = index;
    }
    return gpr;
  }

  RoutePages._internal(this.index);

  set setIndex(int newIndex) {
    index = newIndex >= 0 ? newIndex : 0;
  }

  GetPage<dynamic> getByIndex(int newIndex) {
    return AppPages.getByIndex(index = newIndex);
  }

  GetPage<dynamic> getByName(String name) {
    return AppPages.getByName(name);
  }

  navegate({
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      Get.toNamed(listOfPages[index],
          arguments: arguments,
          id: id,
          preventDuplicates: preventDuplicates,
          parameters: parameters);
}
