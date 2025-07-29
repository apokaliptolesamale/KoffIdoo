// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';

import 'package:xml/xml.dart';

import '/app/core/services/logger_service.dart';
import '/app/widgets/utils/custom_datetime_converter.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/warranty.dart';

WarrantyList warrantyListModelFromJson(String str) =>
    WarrantyList.fromJson(json.decode(str));

WarrantyModel warrantyModelFromJson(String str) =>
    WarrantyModel.fromJson(json.decode(str));

String warrantyModelToJson(WarrantyModel data) => json.encode(data.toJson());

class WarrantyList<T extends WarrantyModel> implements EntityModelList<T> {
  final List<T> warrantys;

  WarrantyList({
    required this.warrantys,
  });

  factory WarrantyList.fromJson(Map<String, dynamic> json) => WarrantyList(
        warrantys: List<T>.from(json.containsKey("warrantys")
            ? json["warrantys"].map((x) => WarrantyModel.fromJson(x))
            : []),
      );

  factory WarrantyList.fromRange(WarrantyList<T> list, int start, int end) {
    final List<T> ls =
        0 <= start && start <= end && end <= list.getList().length
            ? list.getList().sublist(start, end)
            : 0 <= start && start <= end && end > list.getList().length
                ? list.getList()
                : [];
    return WarrantyList(
      warrantys: ls,
    );
  }
  factory WarrantyList.fromStringJson(String strJson) => WarrantyList(
        warrantys: List<T>.from(json
            .decode(strJson)["warrantys"]
            .map((x) => WarrantyModel.fromJson(x))),
      );

  factory WarrantyList.fromXml(XmlElement element,
          WarrantyList<T> Function(XmlElement el) process) =>
      process(element);

  //
  factory WarrantyList.fromXmlDocument(
          XmlDocument doc, WarrantyList<T> Function(XmlElement el) process) =>
      process(doc.rootElement);

  factory WarrantyList.fromXmlElement(XmlElement element) {
    return WarrantyList.fromXml(element, (el) {
      WarrantyList<T> list = WarrantyList.fromJson({});
      el.childElements.forEach((elementColection) {
        final model = WarrantyModel.fromXmlElement(elementColection);
        list.add(model as T);
      });

      return list;
    });
  }

  factory WarrantyList.fromXmlStringElement(String xml) {
    return WarrantyList.fromXml(XmlDocument.parse(xml).rootElement, (el) {
      return WarrantyList.fromJson({});
    });
  }

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return WarrantyList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!warrantys.contains(element)) warrantys.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return WarrantyList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => warrantys;

  Map<String, dynamic> toJson() => {
        "warrantys": List<dynamic>.from(warrantys.map((x) => x.toJson())),
      };
}

class WarrantyModel extends Warranty implements EntityModel {
  @override
  String? warrantyId;
  @override
  String? productIdService;
  @override
  String? orderIdService;
  @override
  String? firstSerialNumber;
  @override
  String? secondSerialNumber;
  @override
  String? code;
  @override
  String? article;
  @override
  double? price;
  @override
  String? tradeName;
  @override
  String? province;
  @override
  String? mark;
  @override
  String? ci;
  @override
  DateTime? time;
  @override
  DateTime createdAt;
  @override
  String? paymentType;
  @override
  String? clientName;
  @override
  String? email;
  @override
  String? phoneNumber;
  @override
  DateTime? updatedAt;
  @override
  String? status;
  @override
  String? model;
  @override
  String? folio;
  @override
  String? qrWarranty;
  @override
  String? seller;

  @override
  String? address;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  WarrantyModel({
    this.warrantyId,
    this.orderIdService,
    this.productIdService,
    this.firstSerialNumber,
    this.secondSerialNumber,
    this.code,
    this.article,
    this.price,
    this.tradeName,
    this.province,
    this.mark,
    this.ci,
    this.time,
    required this.createdAt,
    this.paymentType,
    this.clientName,
    this.email,
    this.phoneNumber,
    this.updatedAt,
    this.status,
    this.model,
    this.folio,
    this.qrWarranty,
    this.seller,
    this.address,
  }) : super(
          warrantyId: warrantyId,
          orderIdService: orderIdService,
          productIdService: productIdService,
          firstSerialNumber: firstSerialNumber,
          secondSerialNumber: secondSerialNumber,
          code: code,
          article: article,
          price: price,
          tradeName: tradeName,
          province: province,
          mark: mark,
          ci: ci,
          time: time,
          createdAt: createdAt,
          paymentType: paymentType,
          clientName: clientName,
          email: email,
          phoneNumber: phoneNumber,
          updatedAt: updatedAt,
          status: status,
          model: model,
          folio: folio,
          qrWarranty: qrWarranty,
          seller: seller,
          address: address,
        );

  factory WarrantyModel.fromJson(Map<String, dynamic> json) => WarrantyModel(
        warrantyId: getValueFrom<String?>("warrantyId", json, null),
        orderIdService: getValueFrom<String?>("orderIdService", json, null),
        productIdService: getValueFrom<String?>("productIdService", json, null),
        firstSerialNumber:
            getValueFrom<String?>("firstSerialNumber", json, null),
        secondSerialNumber:
            getValueFrom<String?>("secondSerialNumber", json, null),
        code: getValueFrom<String?>(
          "code",
          json,
          null,
          reader: (key, data, dv) {
            return json.containsKey(key) ? json[key].toString() : dv;
          },
        ),
        article: getValueFrom<String?>("article", json, null),
        price:
            getValueFrom<double?>("price", json, 0.0, reader: (key, json, dv) {
          return json.containsKey(key)
              ? double.parse(json[key].toString())
              : dv;
        }),
        tradeName: getValueFrom<String?>("tradeName", json, null),
        province: getValueFrom<String?>("province", json, null),
        mark: getValueFrom<String?>("mark", json, null),
        ci: getValueFrom<String?>("ci", json, null),
        time: getValueFrom<DateTime?>("time", json, null,
            reader: (key, json, dv) {
          if (json.containsKey(key) && json[key].toString().isNotEmpty) {
            return CustomDateTimeConverter.from(json[key]);
          } else {
            log("Se ha detectado un valor vacío cuando realmente se esperaba obtener un dato.");
            return dv;
          }
        }),
        createdAt: getValueFrom<DateTime>("createdAt", json, DateTime.now(),
            reader: (key, json, dv) {
          if (json.containsKey(key)) {
            if (json[key] is String && json[key].toString().isNotEmpty) {
              return CustomDateTimeConverter.from(json[key]);
            } else if (json[key] is DateTime) {
              return json[key];
            }
            return dv;
          } else {
            log("Se ha detectado un valor vacío cuando realmente se esperaba obtener un dato.");
            return dv;
          }
        }),
        paymentType: getValueFrom<String?>("paymentType", json, null),
        clientName: getValueFrom<String?>("clientName", json, null),
        email: getValueFrom<String?>("email", json, "-"),
        phoneNumber: getValueFrom<String?>("phoneNumber", json, null),
        updatedAt: getValueFrom<DateTime?>("updatedAt", json, null,
            reader: (key, json, dv) {
          if (json.containsKey(key)) {
            if (json[key] is String && json[key].toString().isNotEmpty) {
              return CustomDateTimeConverter.from(json[key]);
            } else if (json[key] is DateTime) {
              return json[key];
            }
            return dv;
          } else {
            return dv;
          }
        }),
        status: getValueFrom<String?>("status", json, null),
        model: getValueFrom<String?>("model", json, null),
        folio: getValueFrom<String?>("folio", json, null),
        qrWarranty: getValueFrom<String?>("qrWarranty", json, null),
        seller: getValueFrom<String?>("seller", json, null),
        address: getValueFrom<String?>("address", json, null),
      );

  factory WarrantyModel.fromXmlElement(XmlElement el) {
    //log(el.toXmlString(pretty: true));
    final model = WarrantyModel(
      warrantyId: EntityModel.getValueFromXml("warrantyId", el, null),
      orderIdService:
          EntityModel.getValueFromXml<String?>("orderIdService", el, null),
      productIdService:
          EntityModel.getValueFromXml<String?>("productIdService", el, null),
      firstSerialNumber:
          EntityModel.getValueFromXml("firstSerialNumber", el, null),
      secondSerialNumber:
          EntityModel.getValueFromXml("secondSerialNumber", el, null),
      article: EntityModel.getValueFromXml("article", el, null),
      price: EntityModel.getValueFromXml(
        "price",
        el,
        0.0,
        reader: (tag, node, defaultValue) {
          final element = node.getElement(tag);
          if (element != null) {
            return double.parse(element.text);
          }
          return defaultValue;
        },
      ),
      tradeName: EntityModel.getValueFromXml("tradeName", el, null),
      province: EntityModel.getValueFromXml("province", el, null),
      mark: EntityModel.getValueFromXml("mark", el, null),
      ci: EntityModel.getValueFromXml("ci", el, null),
      time: EntityModel.getValueFromXml(
        "time",
        el,
        null,
        reader: (tag, node, defaultValue) {
          final element = node.getElement(tag);
          if (element != null && element.text.isNotEmpty) {
            return CustomDateTimeConverter.from(element.text);
          }
          log("Se ha detectado un valor vacío cuando realmente se esperaba obtener un dato.\nNo existe tiempo de garantía asociado.");
          return defaultValue;
        },
      ),
      createdAt: EntityModel.getValueFromXml(
        "createdAt",
        el,
        DateTime.now(),
        reader: (tag, node, defaultValue) {
          final element = node.getElement(tag);
          if (element != null && element.text.isNotEmpty) {
            return CustomDateTimeConverter.from(element.text);
          }
          log("Se ha detectado un valor vacío cuando realmente se esperaba obtener un dato.");
          return defaultValue;
        },
      ),
      paymentType: EntityModel.getValueFromXml("paymentType", el, null),
      clientName: EntityModel.getValueFromXml("clientName", el, null),
      email: EntityModel.getValueFromXml("email", el, null),
      phoneNumber: EntityModel.getValueFromXml("phoneNumber", el, null),
      updatedAt: EntityModel.getValueFromXml("updatedAt", el, null,
          reader: (tag, node, defaultValue) {
        final element = node.getElement(tag);
        if (element != null) {
          return CustomDateTimeConverter.from(element.text);
        }
        return defaultValue;
      }),
      status: EntityModel.getValueFromXml("status", el, null),
      code: EntityModel.getValueFromXml("code", el, null),
      folio: EntityModel.getValueFromXml("folio", el, null),
      model: EntityModel.getValueFromXml("model", el, null),
      seller: EntityModel.getValueFromXml("seller", el, null),
      qrWarranty: EntityModel.getValueFromXml("qrWarranty", el, null),
      address: EntityModel.getValueFromXml("address", el, null),
    );
    return model;
  }
  factory WarrantyModel.fromXmlStringElement(String xml) {
    return WarrantyModel.fromXmlElement(XmlDocument.parse(xml).rootElement);
  }

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return WarrantyList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return WarrantyList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return WarrantyList.fromJson({});
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
      "warrantyId": "ID",
      "firstSerialNumber": "Número de serie-1",
      "secondSerialNumber": "Número de serie-2",
      "code": "Código",
      "article": "Artículo",
      "price": "Precio",
      "tradeName": "Nombre comercial",
      "province": "Provincia",
      "mark": "Marca",
      "ci": "Carnet de Identidad",
      "time": "Tiempo de Garantía",
      "createdAt": "Fecha creación",
      "paymentType": "Tipo de pago",
      "clientName": "Nombre del cliente",
      "email": "Correo",
      "phoneNumber": "Teléfono",
      "updatedAt": "Fecha de actualización",
      "status": "Estado",
      "model": "Modelo",
      "folio": "Folio",
      "qrCode": "Código Qr",
      "seller": "Sello",
      "address": "Dirección"
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

  int getWarranttyInDays() {
    if (time == null || (time != null && time!.isAfter(createdAt))) {
      return 0;
    }
    log("Tiempo de garantía=$time");
    return time!.compareTo(DateTime.now());
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> tmp = {
      "warrantyId": warrantyId,
      "firstSerialNumber": firstSerialNumber,
      "secondSerialNumber": secondSerialNumber,
      "code": code,
      "article": article,
      "price": price,
      "tradeName": tradeName,
      "province": province,
      "mark": mark,
      "ci": ci,
      "time": time != null ? time!.toIso8601String() : null,
      "createdAt": createdAt.toIso8601String(),
      "paymentType": paymentType,
      "clientName": clientName,
      "email": email,
      "phoneNumber": phoneNumber,
      "updatedAt": updatedAt != null ? updatedAt!.toIso8601String() : null,
      "status": status,
      "model": model,
      "folio": folio,
      "qrWarranty": qrWarranty,
      "seller": seller,
      "address": address
    };
    tmp.removeWhere((key, value) => value == null);
    return tmp;
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
          {JsonReader<T>? reader}) =>
      EntityModel.getValueFromJson<T>(key, json, defaultValue, reader: reader);
}
