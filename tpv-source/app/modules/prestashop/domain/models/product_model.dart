// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:xml/xml.dart';

import '/app/modules/prestashop/domain/entities/any_image.dart';
import '/app/modules/prestashop/domain/entities/category.dart';
import '/app/modules/prestashop/domain/models/any_images_model.dart';
import '/app/modules/prestashop/domain/models/category_model.dart';
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

  factory ProductList.fromStringJson(String strJson) =>
      ProductList.fromJson(json.decode(strJson));

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
  String code;
  @override
  String idProduct;

  @override
  String idOrder;

  @override
  String name;

  @override
  String description;

  @override
  String shortDescription;

  @override
  List<AnyImage> images;

  @override
  double regularPrice;

  @override
  double salePrice;

  @override
  double discount;

  @override
  bool ifItemAvailable;

  @override
  bool ifAddedToCart;

  @override
  int stockQuantity;

  @override
  int quantity;

  @override
  List<String> size;

  @override
  List<Category> categories;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  @override
  String idWarranty;

  ProductModel({
    required this.name,
    this.idWarranty = "",
    this.code = "",
    this.description = "Sin descripción",
    this.idProduct = "",
    this.idOrder = "-",
    this.shortDescription = "Sin descripción",
    this.images = const [],
    this.size = const [],
    this.categories = const [],
    this.regularPrice = 0.00,
    this.salePrice = 0.00,
    this.ifAddedToCart = false,
    this.stockQuantity = 0,
    this.ifItemAvailable = false,
    this.discount = 0,
    this.quantity = 0,
  }) : super(
          idProduct: idProduct,
          idWarranty: idWarranty,
          code: code,
          idOrder: idOrder,
          name: name,
          description: description,
          shortDescription: shortDescription,
          images: images,
          categories: categories,
          discount: discount,
          ifAddedToCart: ifAddedToCart,
          ifItemAvailable: ifItemAvailable,
          quantity: quantity,
          regularPrice: regularPrice,
          salePrice: salePrice,
          size: size,
          stockQuantity: stockQuantity,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProduct: getValueFrom<String>("idProduct", json, "-1"),
        idOrder: getValueFrom<String>("idOrder", json, "-1"),
        code: getValueFrom<String>("code", json, "",
            reader: (key, json, defaultValue) {
          return json.containsKey(key) ? json[key].toString() : "";
        }),
        name: getValueFrom<String>("name", json, "Sin nombre"),
        description:
            getValueFrom<String>("description", json, "Sin descripción"),
        shortDescription:
            getValueFrom<String>("description", json, "Sin descripción"),
        discount: getValueFrom<double>("discount", json, 0.0),
        ifAddedToCart: getValueFrom<bool>("ifAddedToCart", json, false),
        ifItemAvailable: getValueFrom<bool>("ifItemAvailable", json, false),
        quantity: getValueFrom<int>("quantity", json, 0),
        regularPrice: getValueFrom<double>("regularPrice", json, 0.00),
        salePrice: getValueFrom<double>("salePrice", json, 0.00),
        size: getValueFrom<List<String>>("size", json, [],
            reader: (key, json, defaultValue) {
          return json.containsKey(key) ? List<String>.from(json["size"]) : [];
        }),
        stockQuantity: getValueFrom<int>("stockQuantity", json, 0),
        categories: CategoryList.fromJson(json).getList() as List<Category>,
        images: AnyImageList.fromJson(json).getList() as List<AnyImage>,
      );

  factory ProductModel.fromXml(
          XmlElement element, ProductModel Function(XmlElement el) process) =>
      process(element);

  factory ProductModel.loadFromXml(XmlElement element) =>
      ProductModel.fromXml(element, (el) {
        return ProductModel(
            code: el.getElement("reference")!.text,
            quantity: int.parse(el.getElement("quantity")!.text),
            salePrice: double.parse(el.getElement("price")!.text),
            shortDescription: el.getElement("description_short")!.text,
            idProduct: el.getElement("id")!.text,
            name: el.getElement("name")!.text,
            description: el.getElement("description")!.text,
            images: <AnyImage>[
              AnyImageModel(
                id: "img-${el.getElement("id")!.text}",
                imageDescription:
                    "Imagen del producto:${el.getElement("name")!.text}",
                imageURL: el
                    .getElement("id_default_image")!
                    .getAttribute("xlink:href")
                    .toString(),
                alt: el.getElement("name")!.text,
                title:
                    "Código del Producto: ${el.getElement("reference")!.text}",
              ) as AnyImage
            ]);
      });
  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  bool get hasWarranty => idWarranty.isNotEmpty;

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
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

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    //Map<String, String> colNames = getColumnNames();
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
      "id": "Id Producto",
      "idOrder": "Id de Orden",
      "name": "Nombre",
      "description": "Descripción",
      "images": "Imágenes",
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
        "idWarranty": idWarranty,
        "code": code,
        "idOrder": idOrder,
        "name": name,
        "description": description,
        "images": images
            .map((e) => (e as AnyImageModel))
            .map((e) => e.toJson())
            .toList()
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
  static T getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T defaultValue,
      {JsonReader<T>? reader}) {
    if (defaultValue != null && defaultValue is ServerException) {
      throw defaultValue;
    }
    try {
      return EntityModel.getValueFromJson<T>(key, json, defaultValue);
    } on Exception {
      throw CastErrorException();
    }
  }
}
