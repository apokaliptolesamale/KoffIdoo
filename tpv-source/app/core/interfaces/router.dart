import '/app/core/services/logger_service.dart';

import '../../../app/core/interfaces/app_page.dart';
import '../../../app/core/interfaces/module.dart';

abstract class Router<T> {
  bool exists(Module<T> module);
  List<Module<T>> getModules();
  List<CustomAppPageImpl<T>> getPages();
  Router registry(Module<T> newModule, {bool requistryIfNotExists = true});

  static String redirectUri(String path) {
    final currentUri = Uri.base;
    final redirectUri = Uri(
      host: currentUri.host,
      scheme: currentUri.scheme,
      port: currentUri.port,
      path: path,
    );
    log("Redireccionando hacia: $path");
    return redirectUri.toString();
  }
}
