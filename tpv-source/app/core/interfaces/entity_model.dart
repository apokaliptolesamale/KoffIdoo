// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:convert';
import 'dart:math';

//import '/app/modules/operation/widgets/layout_exporting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../../../app/core/services/logger_service.dart';
import '../cache/custom_cache_manager.dart';

typedef Caster<T> = T Function(dynamic value);

typedef JsonReader<T> = T Function(String key, dynamic data, T defaultValue);

typedef XmlReader<T> = T Function(String tag, XmlNode node, T defaultValue);

abstract class ColumnMetaModel {
  dynamic operator [](index);
  String getColumnName();
  String getDataIndex();
  Function(String dataIndex, dynamic value) getRender();
  String getToolTip();
  bool isVisible();
  int setColumnIndex(int index);
  String setColumnName(String newName);
  String setDataIndex(String newDataIndex);
  Function(String dataIndex, dynamic value) setRender(
      Function(String dataIndex, dynamic value) renderFunction);
  String setToolTip(String newToolTip);

  bool setVisible(bool isVisible);
}

class DefaultColumnMetaModel implements ColumnMetaModel {
  String columnName;
  String dataIndex;
  String toolTip;
  bool visible;
  int? columnIndex;
  Function(String dataIndex, dynamic value)? onRender;

  DefaultColumnMetaModel({
    required this.columnName,
    required this.dataIndex,
    required this.toolTip,
    required this.visible,
    this.onRender,
    this.columnIndex = 0,
  });

  @override
  dynamic operator [](index) {
    switch (index) {
      case "columnName":
        return columnName;
      case "dataIndex":
        return dataIndex;
      case "toolTip":
        return toolTip;
      case "visible":
        return visible;
    }
    return columnName;
  }

  @override
  String getColumnName() {
    return columnName;
  }

  @override
  String getDataIndex() {
    return dataIndex;
  }

  @override
  Function(String dataIndex, dynamic value) getRender() {
    return onRender ??
        (dataIndex, value) {
          return Container(child: Text(value));
        };
  }

  @override
  String getToolTip() {
    return toolTip;
  }

  @override
  bool isVisible() {
    return visible;
  }

  @override
  int setColumnIndex(int index) {
    return columnIndex = index;
  }

  @override
  String setColumnName(String newName) {
    return columnName = newName;
  }

  @override
  String setDataIndex(String newDataIndex) {
    return dataIndex = newDataIndex;
  }

  @override
  Function(String dataIndex, dynamic value) setRender(
      Function(String dataIndex, dynamic value) renderFunction) {
    return onRender = renderFunction;
  }

  @override
  String setToolTip(String newToolTip) {
    return toolTip = newToolTip;
  }

  @override
  bool setVisible(bool isVisible) {
    return visible = isVisible;
  }
}

class DefaultEntityModelList<T> implements EntityModelList<T> {
  final List<T> elements = const [];

  const DefaultEntityModelList();

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return this;
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!elements.contains(element)) elements.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return this;
  }

  @override
  List<T> getList() {
    return elements;
  }
}

abstract class EntityEventModel extends Object with ChangeNotifier {
  @override
  bool get hasListeners {
    return super.hasListeners == true;
  }

  @override
  void addListener(void Function() listener) {
    super.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void removeListener(void Function() listener) {
    super.removeListener(listener);
  }
}

abstract class EntityModel {
  Map<String, ColumnMetaModel>? metaModel;
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();
  set setMetaModel(Map<String, ColumnMetaModel> metaModel);
  EntityModelList createModelListFrom(dynamic data);
  Map<String, ColumnMetaModel> getColumnMetaModel();
  Map<String, String> getColumnNames();
  List<String> getColumnNamesList();
  Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue);
  Map<String, String> getVisibleColumnNames();
  Map<String, dynamic> toJson();
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, dynamic valueSearch, dynamic newValue);
  static T getAttributeValueFromXml<T>(
    String name,
    XmlNode node,
    T defaultValue, {
    XmlReader<T>? reader,
  }) {
    try {
      if (reader != null) {
        return reader(name, node, defaultValue);
      }
      final attr = node.getAttribute(name);
      final hasAttribute = attr != null;
      T result = hasAttribute ? attr as T : defaultValue;
      return result;
    } catch (e) {
      log("Exception on: ${node.toString()} for key=$name throw exception-> $e\nDetail:${e.runtimeType}");
    }
    return defaultValue;
  }

  static StreamController<EntityModel> getController({
    required EntityModel entity,
    void Function()? onListen,
    void Function()? onPause,
    void Function()? onResume,
    FutureOr<void> Function()? onCancel,
  }) {
    StreamController<EntityModel> ctl =
        _ModelStreamController<EntityModel>(entity)._controller;
    ctl.onListen = onListen;
    ctl.onCancel = onCancel;
    ctl.onPause = onPause;
    ctl.onResume = onResume;
    return ctl;
  }

  static T getValueFrom<T>(
    String key,
    dynamic data,
    T defaultValue, {
    JsonReader<T>? reader,
    Caster<T>? cast,
  }) {
    try {
      if (reader != null) {
        return reader(key, data, defaultValue);
      }
      if (data is T) return data;
      if (data is Map) return getValueFromJson(key, data, defaultValue);
      if (data is String) return getValueFromString(key, data, defaultValue);
      return defaultValue;
    } catch (e) {
      log("Exception on: ${data.toString()} for key=$key throw exception-> $e\nDetail:${e.runtimeType}");
    }
    return defaultValue;
  }

  static T getValueFromJson<T>(
    String key,
    Map<dynamic, dynamic> json,
    T defaultValue, {
    JsonReader<T>? reader,
    Caster<T>? cast,
  }) {
    try {
      if (reader != null) {
        return reader(key, json, defaultValue);
      }
      final result = json.containsKey(key) && json[key] != null
          ? (cast != null ? cast(json[key]) : json[key])
          : defaultValue;
      return result;
    } catch (e, s) {
      s.printError();
      s.printInfo();
      e.printError();
      e.printInfo();
      log("Exception on: ${json.toString()} for key=$key throw exception-> $e\nDetail:${e.runtimeType}");
    }
    return defaultValue;
  }

  static T getValueFromString<T>(
    String key,
    String str,
    T defaultValue, {
    JsonReader<T>? reader,
    Caster<T>? cast,
  }) {
    try {
      final Map<dynamic, dynamic> data = json.decode(str);
      if (reader != null) {
        return reader(key, data, defaultValue);
      }
      final result = data.containsKey(key) && data[key] != null
          ? (cast != null ? cast(data[key]) : data[key])
          : defaultValue;
      return result;
    } catch (e) {
      log("Exception on: ${json.toString()} for key=$key throw exception-> $e\nDetail:${e.runtimeType}");
    }
    return defaultValue;
  }

  static T getValueFromXml<T>(
    String tag,
    XmlNode node,
    T defaultValue, {
    XmlReader<T>? reader,
  }) {
    try {
      if (reader != null) {
        return reader(tag, node, defaultValue);
      }
      final element = node.getElement(tag);
      T result = element != null ? element.text as T : defaultValue;
      return result;
    } catch (e) {
      log("Exception on: ${node.toString()} for key=$tag throw exception-> $e\nDetail:${e.runtimeType}");
    }
    return defaultValue;
  }
}

abstract class EntityModelList<T> {
  int get getTotal => getList().length;
  EntityModelList<T> add(T element);
  EntityModelList<T> fromJson(Map<String, dynamic> json);
  EntityModelList<T> fromList(List<T> list);
  EntityModelList<T> fromStringJson(String strJson);
  List<T> getList();

  static Future<T> fromXmlServiceUrl<T>(
      String url,
      String parentTagName,
      Future<T> Function(XmlDocument doc, XmlElement el) process,
      Future<T> Function() onError) async {
    final content = await CustomCacheManager.getHttpContent(url);
    XmlDocument doc = XmlDocument.parse(content!);
    final element = doc.getElement(parentTagName);
    if (element != null) {
      return process(doc, element);
    }
    return onError();
  }

  static Future<T> getJsonFromXMLUrl<T>(
      String url,
      Future<T> Function(XmlDocument result) process,
      Future<T> Function() onError) async {
    try {
      var response = await http.get(Uri.parse(url));
      final XmlDocument doc = XmlDocument.parse(response.body);
      return process(doc);
    } catch (e) {
      log(e);
    }
    return onError();
  }
}

class FlexibleEntityModelList<T> implements EntityModelList<T> {
  List<T> elements = List<T>.empty(growable: true);

  FlexibleEntityModelList();

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return this;
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!elements.contains(element)) elements.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return this;
  }

  @override
  List<T> getList() {
    return elements;
  }
}

//Custom List implementation
class MyList<E> {
  // Internal list to store the elements
  final List<E> _list = [];

  @override
  late E first;

  @override
  late E last;

  // Implementing the abstract method
  @override
  bool get isEmpty => _list.isEmpty;

  // Implementing the abstract method
  @override
  bool get isNotEmpty => _list.isNotEmpty;

  // Implementing the abstract method
  @override
  Iterator<E> get iterator => _list.iterator;

  // Implementing the abstract getter
  @override
  int get length => _list.length;

  // Implementing the abstract getter
  @override
  set length(int newLength) {
    _list.length = newLength;
  }

  // Implementing the abstract method
  @override
  Iterable<E> get reversed => _list.reversed;

  // Implementing the abstract method
  @override
  E get single => _list.single;

  @override
  List<E> operator +(List<E> other) {
    // TODO: implement +
    throw UnimplementedError();
  }

  // Implementing the abstract operator
  @override
  E operator [](int index) => _list[index];

  // Implementing the abstract operator
  @override
  void operator []=(int index, E value) {
    _list[index] = value;
  }

  // Implementing the abstract method
  @override
  void add(E element) {
    _list.add(element);
  }

  // Implementing the abstract method
  @override
  void addAll(Iterable<E> elements) {
    _list.addAll(elements);
  }

  @override
  bool any(bool Function(E element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Map<int, E> asMap() {
    // TODO: implement asMap
    throw UnimplementedError();
  }

  @override
  List<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  // Implementing the abstract method
  @override
  void clear() {
    _list.clear();
  }

  // Implementing the abstract method
  @override
  bool contains(Object? element) => _list.contains(element);

  // Implementing the abstract method

  @override
  E elementAt(int index) => _list.elementAt(index);

  @override
  bool every(bool Function(E element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) toElements) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  // Implementing the abstract method
  @override
  void fillRange(int start, int end, [E? fillValue]) {
    _list.fillRange(start, end, fillValue);
  }

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  // Implementing the abstract method
  @override
  Iterable<E> followedBy(Iterable<E> other) => _list.followedBy(other);

  // Implementing the abstract method
  @override
  void forEach(void Function(E element) f) {
    _list.forEach(f);
  }

  @override
  Iterable<E> getRange(int start, int end) {
    // TODO: implement getRange
    throw UnimplementedError();
  }

  // Implementing the abstract method
  @override
  int indexOf(E element, [int start = 0]) => _list.indexOf(element, start);

  // Implementing the abstract method
  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) =>
      _list.indexWhere(test, start);

  // Implementing the abstract method
  @override
  void insert(int index, E element) {
    _list.insert(index, element);
  }

  // Implementing the abstract method
  @override
  void insertAll(int index, Iterable<E> iterable) {
    _list.insertAll(index, iterable);
  }

  // Implementing the abstract method
  @override
  String join([String separator = '']) => _list.join(separator);

  // Implementing the abstract method
  @override
  int lastIndexOf(E element, [int? start]) => _list.lastIndexOf(element, start);

  // Implementing the abstract method
  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) =>
      _list.lastIndexWhere(test, start);

  // Implementing the abstract method
  @override
  E lastWhere(bool Function(E element) test, {E Function()? orElse}) =>
      _list.lastWhere(test, orElse: orElse);

  // Implementing the abstract method
  @override
  Iterable<T> map<T>(T Function(E element) f) => _list.map(f);

  // Implementing the abstract method
  @override
  E reduce(E Function(E value, E element) combine) => _list.reduce(combine);

  // Implementing the abstractmethod
  @override
  bool remove(Object? value) {
    _list.remove(value);
    return true;
  }

  // Implementing the abstract method
  @override
  E removeAt(int index) => _list.removeAt(index);

  // Implementing the abstract method
  @override
  E removeLast() => _list.removeLast();

  // Implementing the abstract method
  @override
  void removeRange(int start, int end) {
    _list.removeRange(start, end);
  }

  // Implementing the abstract method
  @override
  void removeWhere(bool Function(E element) test) {
    _list.removeWhere(test);
  }

  // Implementing the abstract method
  @override
  void replaceRange(int start, int end, Iterable<E> iterable) {
    _list.replaceRange(start, end, iterable);
  }

  // Implementing the abstract method
  @override
  void retainWhere(bool Function(E element) test) {
    _list.retainWhere(test);
  }

  // Implementing the abstract method
  @override
  void setAll(int index, Iterable<E> iterable) {
    _list.setAll(index, iterable);
  }

  // Implementing the abstract method
  @override
  void setRange(int start, int end, Iterable<E> iterable, [int? skipCount]) {
    _list.setRange(start, end, iterable, skipCount ?? 0);
  }

  // Implementing the abstract method
  @override
  void shuffle([Random? random]) {
    _list.shuffle(random);
  }

  // Implementing the abstract method
  @override
  E singleWhere(bool Function(E element) test, {E Function()? orElse}) =>
      _list.singleWhere(test, orElse: orElse);

  // Implementing the abstract method
  @override
  Iterable<E> skip(int count) => _list.skip(count);

  // Implementing the abstract method
  @override
  Iterable<E> skipWhile(bool Function(E value) test) => _list.skipWhile(test);

  @override
  void sort([int Function(E a, E b)? compare]) {
    // TODO: implement sort
  }

  // Implementing the abstract method
  @override
  List<E> sublist(int start, [int? end]) => _list.sublist(start, end);

  // Implementing the abstract method
  @override
  Iterable<E> take(int count) => _list.take(count);

  // Implementing the abstract method
  @override
  Iterable<E> takeWhile(bool Function(E value) test) => _list.takeWhile(test);

  // Implementing the abstract method
  @override
  List<E> toList({bool growable = true}) => _list.toList(growable: growable);

  // Implementing the abstract method
  @override
  Set<E> toSet() => _list.toSet();

  // Implementing the abstract method
  @override
  Iterable<E> where(bool Function(E element) test) => _list.where(test);

  // Implementing the abstract method
  @override
  Iterable<T> whereType<T>() => _list.whereType<T>();
}

class _ModelStreamController<Type> {
  StreamController<Type> _controller = StreamController<Type>();
  Type subject;
  _ModelStreamController(this.subject);

  addListener(Function(Type) listener) {
    _controller.stream.listen(listener);
  }
}
