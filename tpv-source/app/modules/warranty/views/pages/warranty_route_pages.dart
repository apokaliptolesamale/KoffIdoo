// ignore_for_file: must_be_immutable

import 'package:get/get.dart';

import '/app/routes/app_pages.dart';

class WarrantyRoutePages {
  static final WarrantyRoutePages instance =
      !Get.isRegistered() ? WarrantyRoutePages._internal(0) : Get.find();

  int index;

  List<String> listOfPages = [
    "/warranty/home",
    "/order/orders",
    "/order/order-info",
    "/product/product-info",
    "/warranty/add-warranty",
  ];

  WarrantyRoutePages({
    required this.index,
  });
  factory WarrantyRoutePages.fromRoute(String route) {
    final gpr = WarrantyRoutePages(index: 0);
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

  WarrantyRoutePages._internal(this.index);

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
      Get.toNamed(
        listOfPages[index],
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );
}
