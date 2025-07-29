// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches

import 'dart:async';
import 'dart:convert';

import '/app/core/services/logger_service.dart';
import '/app/modules/product/domain/entities/any_image.dart';
import '/app/modules/product/domain/entities/category.dart';
import '/app/modules/product/domain/models/any_images_model.dart';
import '/app/modules/product/domain/models/category_model.dart';
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
        products: json.containsKey("products")
            ? List<T>.from(
                json["products"].map((x) => ProductModel.fromJson(x)))
            : [],
      );

  factory ProductList.fromModels(List<T> models) => ProductList(
        products: models,
      );
  factory ProductList.fromStringJson(String strJson) {
    return ProductList(
      products: List<T>.from(json
          .decode(strJson)["products"]
          .map((x) => ProductModel.fromJson(x))),
    );
  }

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
}

class ProductModel extends Product implements EntityModel {
  @override
  String? code;

  @override
  String? qrCode;

  @override
  String? mark;

  @override
  String? model;

  @override
  String categoryName;

  @override
  String idProduct;

  @override
  String idOrder;

  @override
  String idOrderService;

  @override
  String name;

  @override
  String? description;

  @override
  String? shortDescription;

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
  int warrantyTime;

  @override
  int quantity;

  @override
  List<String> size;

  @override
  List<Category> categories;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  Map<String, dynamic> _orderPayload = {};

  Map<String, dynamic> _warrantyPayload = {};

  @override
  String idWarranty;

  ProductModel({
    required this.name,
    this.code = "",
    this.qrCode = "",
    this.mark = "",
    this.model = "",
    this.categoryName = "",
    this.description = "",
    this.idWarranty = "",
    this.idProduct = "",
    this.idOrder = "-",
    required this.idOrderService,
    this.shortDescription = "",
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
    this.warrantyTime = 0,
  }) : super(
          idProduct: idProduct,
          code: code,
          qrCode: qrCode,
          categoryName: categoryName,
          mark: mark,
          model: model,
          idOrder: idOrder,
          idOrderService: idOrderService,
          idWarranty: idWarranty,
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
          warrantyTime: warrantyTime,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProduct: getValueFrom<String>("idProduct", json, ""),
        idWarranty: getValueFrom("idWarranty", json, ""),
        code: getValueFrom<String?>("code", json, "",
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? json[key].toString()
              : defaultValue;
        }),
        qrCode: getValueFrom<String?>("qrCode", json, "",
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? json[key].toString()
              : defaultValue;
        }),
        mark: getValueFrom<String?>("mark", json, "",
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? json[key].toString()
              : defaultValue;
        }),
        model: getValueFrom<String?>("model", json, "",
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? json[key].toString()
              : defaultValue;
        }),
        categoryName: getValueFrom<String>("categoryName", json, "",
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? json[key].toString()
              : defaultValue;
        }),
        idOrder: getValueFrom<String>("idOrder", json, ""),
        idOrderService: getValueFrom<String>("idOrderService", json, ""),
        name: getValueFrom<String>("productName", json, ""),
        description: getValueFrom<String>("description", json, ""),
        shortDescription: getValueFrom<String>("description", json, ""),
        discount: getValueFrom<double>("discount", json, 0.0,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? double.parse(json[key].toString())
              : defaultValue;
        }),
        ifAddedToCart: getValueFrom<bool>("ifAddedToCart", json, false,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? json[key]
              : defaultValue;
        }),
        ifItemAvailable: getValueFrom<bool>("ifItemAvailable", json, false,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? json[key]
              : defaultValue;
        }),
        quantity: getValueFrom<int>("quantity", json, 0,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? int.parse(json[key].toString())
              : defaultValue;
        }),
        regularPrice: getValueFrom<double>("regularPrice", json, 0.00,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? double.parse(json[key].toString())
              : defaultValue;
        }),
        salePrice: getValueFrom<double>("salePrice", json, 0.00,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? double.parse(json[key].toString())
              : defaultValue;
        }),
        size: getValueFrom<List<String>>("size", json, [],
            reader: (key, json, defaultValue) {
          return json.containsKey(key)
              ? List<String>.from(json["size"])
              : defaultValue;
        }),
        stockQuantity: getValueFrom<int>("stockQuantity", json, 0,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? int.parse(json[key].toString())
              : defaultValue;
        }),
        warrantyTime: getValueFrom<int>("warrantyTime", json, 0,
            reader: (key, json, defaultValue) {
          return json.containsKey(key) && json[key].toString().isNotEmpty
              ? int.parse(json[key].toString())
              : defaultValue;
        }),
        categories: CategoryList.fromJson(json).getList(),
        images: AnyImageList.fromJson(json).getList(),
      );
  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  Map<String, dynamic> get getOrderPayLoad => _orderPayload;

  Map<String, dynamic> get getWarrantyPayLoad => _warrantyPayload;
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

  ProductModel merge(ProductModel other) {
    ProductModel.updateFromJson(this, other.toJson());
    return this;
  }

  setOrderPayLoad(Map<String, dynamic> orderPayload) {
    _orderPayload = orderPayload;
  }

  setWarrantyPayLoad(Map<String, dynamic> warrantyPayload) {
    _warrantyPayload = warrantyPayload;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "name": name,
      "idProduct": idProduct,
      "code": code,
      "qrCode": qrCode,
      "mark": mark,
      "model": model,
      "categoryName": categoryName,
      "description": description,
      "idWarranty": idWarranty,
      "idOrder": idOrder,
      "idOrderService": idOrderService,
      "shortDescription": shortDescription,
      "images": images
          .map((e) => (e as AnyImageModel))
          .map((e) => e.toJson())
          .toList(),
      "size": size,
      "categories": categories
          .map((e) => (e as CategoryModel))
          .map((e) => e.toJson())
          .toList(),
      "regularPrice": regularPrice,
      "salePrice": salePrice,
      "ifAddedToCart": ifAddedToCart,
      "stockQuantity": stockQuantity,
      "ifItemAvailable": ifItemAvailable,
      "discount": discount,
      "quantity": quantity,
      "warrantyTime": warrantyTime,
    };
    json.removeWhere((key, value) =>
        value == null ||
        ((value is String || value is List || value is Map) && value.isEmpty));
    return json;
  }

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

  static T getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T defaultValue,
      {JsonReader<T>? reader}) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader);
  }

  //Update
  static ProductModel updateFromJson(
      ProductModel product, Map<String, dynamic> json) {
    product.idProduct = getValueFrom<String>("idProduct", json, "");
    product.idWarranty = getValueFrom("idWarranty", json, "");
    product.code = getValueFrom<String?>("code", json, "",
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? json[key].toString()
          : defaultValue;
    });
    product.qrCode = getValueFrom<String?>("qrCode", json, "",
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? json[key].toString()
          : defaultValue;
    });
    product.mark = getValueFrom<String?>("mark", json, "",
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? json[key].toString()
          : defaultValue;
    });
    product.model = getValueFrom<String?>("model", json, "",
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? json[key].toString()
          : defaultValue;
    });
    product.categoryName = getValueFrom<String>("categoryName", json, "",
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? json[key].toString()
          : defaultValue;
    });
    product.idOrder = getValueFrom<String>("idOrder", json, "");
    product.idOrderService = getValueFrom<String>("idOrderService", json, "");
    product.name = getValueFrom<String>("productName", json, "");
    product.description = getValueFrom<String>("description", json, "");
    product.shortDescription = getValueFrom<String>("description", json, "");
    product.discount = getValueFrom<double>("discount", json, 0.0,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? double.parse(json[key].toString())
          : defaultValue;
    });
    product.ifAddedToCart = getValueFrom<bool>("ifAddedToCart", json, false,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? json[key]
          : defaultValue;
    });
    product.ifItemAvailable = getValueFrom<bool>("ifItemAvailable", json, false,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? json[key]
          : defaultValue;
    });
    product.quantity = getValueFrom<int>("quantity", json, 0,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? int.parse(json[key].toString())
          : defaultValue;
    });
    product.regularPrice = getValueFrom<double>("regularPrice", json, 0.00,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? double.parse(json[key].toString())
          : defaultValue;
    });
    product.salePrice = getValueFrom<double>("salePrice", json, 0.00,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? double.parse(json[key].toString())
          : defaultValue;
    });
    product.size = getValueFrom<List<String>>("size", json, [],
        reader: (key, json, defaultValue) {
      return json.containsKey(key)
          ? List<String>.from(json["size"])
          : defaultValue;
    });
    product.stockQuantity = getValueFrom<int>("stockQuantity", json, 0,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? int.parse(json[key].toString())
          : defaultValue;
    });
    product.warrantyTime = getValueFrom<int>("warrantyTime", json, 0,
        reader: (key, json, defaultValue) {
      return json.containsKey(key) && json[key].toString().isNotEmpty
          ? int.parse(json[key].toString())
          : defaultValue;
    });
    product.categories = CategoryList.fromJson(json).getList();
    product.images = AnyImageList.fromJson(json).getList();
    return product;
  }
}
