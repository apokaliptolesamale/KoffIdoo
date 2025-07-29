// ignore_for_file: prefer_final_fields

import '../../../app/core/interfaces/app_page.dart';
import '../../../app/core/interfaces/module.dart';
import '../../../app/core/interfaces/router.dart';

class RouterServiceImpl<T> implements Router<T> {
  List<Module<T>> _modules = [];
  List<CustomAppPageImpl<T>> _pages = [];
  @override
  bool exists(Module<T> module) => _modules.contains(module);

  @override
  List<Module<T>> getModules() => _modules;

  @override
  List<CustomAppPageImpl<T>> getPages() => _pages;

  @override
  Router<T> registry(Module<T> newModule, {bool requistryIfNotExists = true}) {
    final contains = _modules.contains(newModule);
    if ((requistryIfNotExists && !contains) || !contains) {
      _modules.add(newModule);
      _pages.addAll(newModule.loadRoutes());
    }
    return this;
  }
}
