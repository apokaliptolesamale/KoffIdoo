import '/app/core/services/logger_service.dart';
import '../../../app/core/interfaces/app_page.dart';
import '../../../app/core/interfaces/module.dart';

class ModuleServiceImpl<T> implements Module<T> {
  final String id, name, path, description;
  late List<CustomAppPageImpl<T>> _pages;

  ModuleServiceImpl({
    required this.id,
    required this.name,
    required this.path,
    required this.description,
  }) {
    log("Inicializando módulo $name en la aplicación");
  }

  @override
  List<CustomAppPageImpl<T>> get getPages => _pages;

  Module get() {
    return this;
  }

  @override
  String getDescription() => description;

  @override
  String getId() => id;

  @override
  String getName() => name;

  @override
  List<CustomAppPageImpl<T>> loadRoutes() {
    return _pages;
  }
}
