import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';

class GlobalParams {
  static GlobalParams instance =
      !Get.isRegistered() ? GlobalParams._internal() : Get.find();
  final Map<String, String> _params = {};

  GlobalParams._internal() {
    log("Inicializando instancia de registro de GlobalParams");
  }
  dynamic operator [](index) {
    return containsKey(index) ? _params[index] : null;
  }

  GlobalParams add(
    String key,
    String param, {
    bool replace = true,
  }) {
    if (replace && _params.containsKey(key)) {
      _params[key] = param;
    } else {
      _params.putIfAbsent(key, () => param);
    }
    return this;
  }

  GlobalParams addAll(
    Map<String, String> collection, {
    bool replace = true,
  }) {
    collection.map((key, value) {
      add(
        key,
        value,
        replace: replace,
      );
      return MapEntry(key, value);
    });
    return this;
  }

  GlobalParams clear() {
    _params.clear();
    return this;
  }

  bool containsKey(String key) => _params.containsKey(key);

  String? get(String key) => containsKey(key) ? _params[key] : null;

  Map<String, String> getAll() {
    Map<String, String> temp =
        Get.parameters.map((key, value) => MapEntry(key, value ?? ""));
    temp.removeWhere((key, value) => value.isEmpty);
    _params.addAll(temp);
    return _params;
  }
}
