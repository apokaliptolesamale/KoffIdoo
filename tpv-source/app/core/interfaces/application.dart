import '../../../app/core/interfaces/module.dart';

abstract class Application<T> {
  final List<Module<T>> _modules = [];

  List<Module<T>> get applicationModules => _modules;

  String getApplicationDescription();

  String getApplicationId();

  List<Module<T>> getApplicationModules();

  String getApplicationName();

  Future initApplicationModules();
}
