// ignore_for_file: constant_identifier_names, unused_element, prefer_final_fields, prefer_for_elements_to_map_fromiterable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '/app/routes/app_pages.dart';
import '../core/helpers/functions.dart';

class Routes {
  static Routes? _instance;
  static final Routes getInstance = _instance ?? Routes._internal();

  static get foundInLastSearch => AppPages().foundInLastSearch;

  Map<String, String> _routeMap = {};

  factory Routes() => getInstance;

  Routes._internal() {
    log("Iniciando instancia de Router.");
  }

  Map<String, String> get getRouteMap => _routeMap;

  Routes addRoute(String keyRoute, String route) {
    _routeMap.putIfAbsent(keyRoute, () => route);
    return this;
  }

  GetPage getByRoute(String route) {
    return AppPages.getByRoute(route);
  }

  GetPage getPageByKeyRoute(String keyRoute) {
    String route = Routes.getInstance.getPath(keyRoute);
    return AppPages.getByRoute(route);
  }

  String getPath(String keyRoute) {
    return _routeMap.containsKey(keyRoute) ? _routeMap[keyRoute] ?? "/" : "/";
  }

  Widget getWidgetByKeyRoute(String keyRoute) {
    String route = Routes.getInstance.getPath(keyRoute);
    GetPage page = Routes.getInstance.getByRoute(route);
    return page.page();
  }

  void goTo(String keyRoute) {
    String route = Routes.getInstance.getPath(keyRoute);
    final page = getByRoute(route);
    Get.to(page.page);
  }

  Future<T?>? navigateTo<T>(String keyRoute) {
    String route = Routes.getInstance.getPath(keyRoute);
    final page = getByRoute(route);
    return Get.to(page.page);
  }

  bool pageExists(String keyRoute) {
    return _routeMap.containsKey(keyRoute);
  }

  Routes reload() {
    Map<String, String> tmp = AppPages()
        .routes
        .asMap()
        .map((key, value) => MapEntry(value.keyMap, value.name));
    tmp.map((key, value) {
      bool containsKey = _routeMap.containsKey(key);
      final containsValue =
          !containsKey ? getKeyByValue(_routeMap, value) : null;
      if (containsValue != null) {
        _routeMap.addIf(true, containsValue, value);
        return MapEntry(key, value);
      }
      return MapEntry("key", "value");
    }).values;
    return this;
  }

  bool replaceRoute(String keyRoute, String newRoute) {
    return _routeMap.containsKey(keyRoute) && newRoute.isNotEmpty
        ? (_routeMap[keyRoute] = newRoute) != ""
        : false;
  }
}
