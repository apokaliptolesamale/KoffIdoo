// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:xml/xml.dart';

import '/app/modules/product/domain/entities/any_image.dart';
import '/app/modules/product/domain/models/any_images_model.dart';
import '../../../../../../../../../app/core/config/errors/exceptions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/product.dart';

ProductList productListModelFromJson(String str) =>
    ProductList.fromJson(json.decode(str));

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductList<T extends ProductModel> implements EntityModelList<T> {
  final List<T> products;

  ProductList({
    required this.products,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        products:
            List<T>.from(json["products"].map((x) => ProductModel.fromJson(x))),
      );

  factory ProductList.fromStringJson(String strJson) => ProductList(
        products: List<T>.from(json
            .decode(strJson)["products"]
            .map((x) => ProductModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return ProductList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!products.contains(element)) products.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return ProductList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => products;

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };

  static Future<T> fromXmlServiceUrl<T>(
      String url,
      String parentTagName,
      Future<T> Function(XmlDocument doc, XmlElement el) process,
      Future<T> Function() onError) async {
    return EntityModelList.fromXmlServiceUrl(
        url, parentTagName, process, onError);
  }

  static Future<T> getJsonFromXMLUrl<T>(
      String url,
      Future<T> Function(XmlDocument result) process,
      Future<T> Function() onError) async {
    return EntityModelList.getJsonFromXMLUrl(url, process, onError);
  }
}

class ProductModel extends Product implements EntityModel {
  @override
  final String? idProduct;

  @override
  final String? idOrder;

  @override
  final String? name;

  @override
  final String? model;
  @override
  final String? code;
  @override
  final String? price;
  @override
  final String? mark;
  @override
  final int? productQuantity;
  @override
  String? idOrderService;
  @override
  List<AnyImage> images;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  ProductModel({
    this.idProduct,
    this.idOrder,
    this.name,
    this.model,
    this.code,
    this.price,
    this.mark,
    this.productQuantity = 0,
    this.images = const [],
    this.idOrderService,
  }) : super(
          idProduct: idProduct,
          idOrder: idOrder,
          name: name,
          model: model,
          code: code,
          price: price,
          mark: mark,
          productQuantity: productQuantity,
          images: images,
          idOrderService: idOrderService,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProduct: EntityModel.getValueFromJson("idProduct", json, null),
        idOrder: EntityModel.getValueFromJson("idOrder", json, null),
        idOrderService: getValueFrom<String?>("idOrderService", json, null),
        name: EntityModel.getValueFromJson("name", json, null),
        model: EntityModel.getValueFromJson("model", json, null),
        code: EntityModel.getValueFromJson("code", json, null,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) ? json[key].toString() : null;
        }),
        price: EntityModel.getValueFromJson("price", json, null,
            reader: ((key, data, defaultValue) {
          if (data.containsKey(key)) return data[key].toString();
          return defaultValue;
        })),
        mark: EntityModel.getValueFromJson("mark", json, null),
        productQuantity:
            EntityModel.getValueFromJson("productQuantity", json, 0),
        images: EntityModel.getValueFromJson<List<AnyImage>>("images", json, [],
            reader: ((key, data, defaultValue) {
          if (data.containsKey(key) && data[key] != null) {
            return (data[key] as List).map((e) => AnyImageModel.fromJson(e))
                as List<AnyImage>;
          }
          return defaultValue;
        })),
      );

  factory ProductModel.fromXml(
          XmlElement element, ProductModel Function(XmlElement el) process) =>
      process(element);

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Object?> get props => [];

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  //method generated by wizard
  T cloneWith<T extends EntityModel>(T other) {
    return ProductModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return ProductList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return ProductList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return ProductList.fromJson({});
  }

  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return ProductModel.fromJson(params) as T;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    ////Map<String, String> colNames = getColumnNames();
    metaModel = metaModel ??
        {
          //TODO Declare here all ColumnMetaModel. you can use class implementation of class "DefaultColumnMetaModel".
        };
    int index = 0;
    metaModel!.forEach((key, value) {
      value.setColumnIndex(index++);
    });
    return metaModel!;
  }

  @override
  Map<String, String> getColumnNames() {
    return {
      "idProduct": "ID",
      "idOrder": "No. Orden",
      "name": "Nombre",
      "model": "Modelo",
      "code": "Código",
      "price": "Precio",
      "mark": "Marca",
      "productQuantity": "Cantidad"
    };
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  StreamController<EntityModel> getController({
    void Function()? onListen,
    void Function()? onPause,
    void Function()? onResume,
    FutureOr<void> Function()? onCancel,
  }) {
    return EntityModel.getController(
      entity: this,
      onListen: onListen,
      onPause: onPause,
      onResume: onResume,
      onCancel: onCancel,
    );
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue) {
    final Map<K1, V1> result = {};
    getColumnMetaModel().map<K1, V1>((key, value) {
      MapEntry<K1, V1> el = MapEntry(value.getDataIndex() as K1, value as V1);
      if (value[searchKey] == searchValue) {
        result.putIfAbsent(value.getDataIndex() as K1, () {
          return value as V1;
        });
      }
      return el;
    });
    return result;
  }

  @override
  Map<String, String> getVisibleColumnNames() {
    Map<String, String> names = {};
    getMeta<String, ColumnMetaModel>("visible", true)
        .map<String, String>((key, value) {
      names.putIfAbsent(key, () => value.getColumnName());
      return MapEntry(key, value.getColumnName());
    });
    return names;
    // throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "idOrder": idOrder,
        "idOrderService": idOrderService,
        "name": name,
        "model": model,
        "code": code,
        "price": price,
        "mark": mark,
        "productQuantity": productQuantity
      };

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, dynamic valueSearch, dynamic newValue) {
    Map<String, ColumnMetaModel> tmp = getColumnMetaModel();
    getMeta<String, ColumnMetaModel>(keySearch, valueSearch)
        .map<String, ColumnMetaModel>((key, value) {
      tmp.putIfAbsent(key, () => value);
      return MapEntry(key, value);
    });
    return metaModel = tmp;
  }

  @override
  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, dynamic defaultValue) {
    if (defaultValue != null && defaultValue is ServerException) {
      throw defaultValue;
    }
    try {
      return EntityModel.getValueFromJson<T?>(key, json, defaultValue);
    } on Exception {
      throw CastErrorException();
    }
  }
}
