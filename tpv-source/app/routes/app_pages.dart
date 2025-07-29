// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/app_config.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/core/middlewares/auth_middleware.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/home/views/pages/home_page.dart';
import '/app/modules/index/views/pages/index_page.dart';
import '/app/modules/index/views/pages/root_page.dart';
import '/app/routes/app_routes.dart';
import '/globlal_constants.dart';

export 'app_routes.dart';

class AppPages {
  static AppPages? _instance;

  static AppPages get getInstance => _instance ?? AppPages._internal();

  final INITIAL = GetPlatform.isAndroid
      ? Routes.getInstance.getPath('WEBVIEW')
      : Routes.getInstance.getPath('INDEX');

  bool _loaded = false;
  bool foundInLastSearch = false;

  final _routes = [
    RootPageImpl.builder(),
    HomeAppPageImpl.builder(
      middlewares: [AuthMidleware()],
    ),
    IndexAppPageImpl.builder(),
  ];

  factory AppPages() => getInstance;

  AppPages._internal() {
    _instance ??= this;
    log("Iniciando instancia de AppPages.");
  }

  List<CustomAppPageImpl<dynamic>> get routes => _routes;

  bool get wasPagesLoaded => _loaded;

  void addAllRoute(List<CustomAppPageImpl> newRoutes, dynamic condition) {
    newRoutes.forEach((element) {
      AppPages().routes.addIf(condition ?? true, element);
    });
    Routes.getInstance.reload();
  }

  void _addRoute(CustomAppPageImpl newRoute, dynamic condition) {
    _routes.addIf(condition ?? true, newRoute);
    Routes.getInstance.reload();
  }

  void _addRouteIfAbsent(CustomAppPageImpl newRoute) {
    final esta = !_contains(newRoute, _routes);
    _routes.addIf(esta, newRoute);
    Routes.getInstance.reload();
  }

  bool _contains(CustomAppPageImpl<dynamic> newRoute,
      List<CustomAppPageImpl<dynamic>> list) {
    for (var i = 0; i < list.length; i++) {
      CustomAppPageImpl<dynamic> el = list.elementAt(i);
      if (el.name == newRoute.name) return true;
    }
    return false;
  }

  static void addAllRouteIfAbsent(List<CustomAppPageImpl> newRoutes) {
    if (newRoutes.isNotEmpty) {
      int c = 0;
      newRoutes.forEach((element) {
        final contain = contains(element, AppPages().routes);
        contain
            ? log("La ruta ${element.name} ya existe...")
            : log("Adicionando rutas inexistentes...");
        !contain ? c++ : null;
        AppPages().routes.addIf(!contain, element);
      });
      log("Se han adicionado $c rutas nuevas.");
    }
    Routes.getInstance.reload();
  }

  static void addRoute(CustomAppPageImpl newRoute, dynamic condition) =>
      AppPages()._addRoute(newRoute, condition);

  static void addRouteIfAbsent(CustomAppPageImpl newRoute) =>
      AppPages()._addRouteIfAbsent(newRoute);

  static Bindings? binding(String name) {
    return AppPages.getByName(name).binding;
  }

  static bool contains(CustomAppPageImpl<dynamic> newRoute,
          List<CustomAppPageImpl<dynamic>> list) =>
      AppPages()._contains(newRoute, list);

  static bool exists(String name) {
    for (var element in AppPages().routes) {
      if (element.name == name) return true;
    }
    return false;
  }

  static GetPage<dynamic> getByIndex(int index) {
    return AppPages().routes[index];
  }

  static GetPage<dynamic> getByName(String name) {
    log("getByName:$name");
    for (var element in AppPages().routes) {
      if (element.name == name) return element;
    }
    return AppPages().routes[2];
  }

  static GetPage<dynamic> getByRoute(String route) {
    log("getByRoute:$route");
    AppPages().foundInLastSearch = false;
    final routes = AppPages().routes;
    for (var element in routes) {
      if (element.name == route || element.name == "/$route") {
        AppPages().foundInLastSearch = true;
        return element;
      }
    }
    log("No existe ruta alguna con el patrón:$route");
    return AppPages().routes[0];
  }

  static Widget getIndex(String name) {
    log("getIndex:$name");
    final loginRoute = ConfigApp.getInstance.configModel!.loginRoute;
    if (loginRoute != name) {
      return AppPages.getIndexView();
    }
    return IndexAppPageImpl.builder().page();
  }

  static GetPage<dynamic> getIndexPageByRoute(String route) {
    final page = getByRoute(route);
    return page;
  }

  static Widget getIndexView() {
    String route = ConfigApp.getInstance.configModel!.loginRoute;
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    if (service != null) {
      final isActive = service.active;
      final ignore = service.ignoreOnError;
      if (!isActive || ignore) if (!isActive || ignore) {
        log("Se detectó que la configuración de seguridad está desactivada. Se navegará automáticamente hacia el home.");
        route = ConfigApp.getInstance.configModel!.homePageRoute;
      }
    }
    final indexPage = getIndexPageByRoute(route);
    final indexView = indexPage.page();
    return indexView;
  }

  static List<CustomAppPageImpl> getRoutePages() {
    if (!AppPages()._loaded && AppPages().routes.isNotEmpty) {
      var c = 0;
      AppPages().routes.forEach((element) {
        element.index = c;
        c++;
      });
      AppPages()._loaded = true;
    }
    return AppPages().routes;
  }

  static Map<String, Widget Function(BuildContext)> getRoutes(
      BuildContext context) {
    Map<String, Widget Function(BuildContext)> mapRoutes = {
      "/": (context) => getByRoute("/index").page()
    };

    for (var element in AppPages().routes) {
      mapRoutes.putIfAbsent(
          element.name,
          () => (context) {
                return element.page();
              });
    }
    return mapRoutes;
  }

  static bool hasTitle(String name) {
    return getByName(name).title != null;
  }

  static Widget page(String name) {
    return getByName(name).page();
  }

  static List<GetPage<dynamic>> pagesWithTitle() {
    List<GetPage<dynamic>> pages = [];
    for (var element in AppPages().routes) {
      if (element.title != null) {
        pages.add(element);
      }
    }
    return pages;
  }

  static List<String> paths() {
    List<String> paths = [];
    for (var element in AppPages().routes) {
      paths.add(element.title ?? element.name);
    }
    return paths;
  }

  static List<String> titles() {
    List<String> paths = [];
    for (var element in AppPages().routes) {
      if (element.title != null) {
        paths.add(element.title!);
      }
    }
    return paths;
  }
}
