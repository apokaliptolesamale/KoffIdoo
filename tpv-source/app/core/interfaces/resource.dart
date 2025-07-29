import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '/app/core/config/assets.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/module.dart';
import '/app/core/services/module_service.dart';
import '../services/store_service.dart';

List<Module> globalModules = [];

class Resource {
  List<Module> modules = globalModules;
  Map<String, Resource> allResources = {};
  final String type;
  String name;
  List<Resource> contents;

  Resource? parent;

  Resource({
    required this.type,
    required this.name,
    required this.contents,
    this.parent,
  });

  factory Resource.load(Map<String, dynamic> json, Resource? parent) =>
      Resource(
          name: EntityModel.getValueFromJson("name", json, ""),
          type: EntityModel.getValueFromJson("type", json, ""),
          parent: parent,
          contents: EntityModel.getValueFromJson(
            "contents",
            json,
            [],
            reader: (key, data, defaultValue) {
              if (data.containsKey(key)) {
                final List contents = data[key];
                return contents
                    .asMap()
                    .map((key, value) =>
                        MapEntry(key, Resource.load(value, null)))
                    .values
                    .toList();
              }
              return defaultValue;
            },
          ))._init();

  String get getPath => parent == null
      ? "./"
      : "${parent!.getPath}$name${isDirectory ? '/' : ''}";

  List<Module> get getResourceModules => Resource.getModules();

  bool get isDirectory => type == "directory";

  flushModules() {
    modules = [];
  }

  Resource _init() {
    StoreService().getStore("system");
    for (var element in contents) {
      element.parent = this;
    }
    return this;
  }

  static List<Module> getModules() {
    globalModules = [];
    final sysStore = StoreService().getStore("system");
    Resource? resource = sysStore.get("sysResource", null);
    if (resource != null) {
      resource.modules = globalModules;
      List<String> tmp = [];
      List<Resource> modulesColection =
          resource.contents.first.contents.elementAt(2).contents;

      for (var el in modulesColection) {
        if (el.isDirectory && !tmp.contains(el.name)) {
          tmp.add(el.name);
          globalModules.add(ModuleServiceImpl(
            id: el.getPath,
            name: el.name,
            path: el.getPath.replaceAll("./", "../../../"),
            description: "Módulo ${el.name}",
          ).get());
        }
      }
      resource.modules = globalModules;
    }
    return globalModules;
  }

  static Future<Resource> loadFromAssets() async {
    final sysStore = StoreService().getStore("system");
    final content = await rootBundle.loadString(ASSETS_MODELS_PROJECT_JSON);
    final decoded = json.decode(content);
    final resource = Resource.load(decoded[0], null);
    sysStore.add("sysResource", resource);
    return Future.value(resource);
  }
}
