// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/payment.dart';

/* 
 final cfgController = Get.find<ConfigController>();
              final unidades = cfgController.getComercialUnits(
                  mas.consumerKey, "Unidades Comerciales TRD");
              unidades.then((value) {
                setState(() {
                  loadingUnits = false;
                  unidadesComerciales =
                      value.fold((l) => NomencladorList.fromEmpty(), (result) {
                    final list = result.getList().first;
                    return list;
                  });
                });
              });
 */


class Service2Pay {
  
  final int value;
  final String name;

  Service2Pay(
    this.value,
    this.name,  );

    
}
class ServicesPayment {
  // Electricidad
  static final Service2Pay electricidad = Service2Pay(2222, "Electricidad");

  // gas
  static final Service2Pay gas = Service2Pay(1111, "Gas"); 
  // gas
  static final Service2Pay onat = Service2Pay(3333, "Onat"); 

  static final List<Service2Pay> services = [
    electricidad,
    gas, 
    onat
  ];

  static Service2Pay? byValue(int value) {
    for (var element in ServicesPayment.services) {
      if (element.value == value) return element;
    }
    return null;
  }
   static Service2Pay? byName(String name) {
    for (var element in ServicesPayment.services) {
      if (element.name.toLowerCase() == name.toLowerCase()) return element;
    }
    return null;
  }
   static int byCodeName(String name) {
   final service=byName(name);
    return service==null? -1:service.value;
  }

  static bool exists(int value) => byValue(value) != null;
}

PaymentList paymentListModelFromJson(String str) =>
    PaymentList.fromJson(json.decode(str));

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentList<T extends PaymentModel> implements EntityModelList<T> {
  final List<T> payments;

  PaymentList({
    required this.payments,
  });

  factory PaymentList.fromJson(Map<String, dynamic> json) => PaymentList(
        payments:
            List<T>.from(json["payments"].map((x) => PaymentModel.fromJson(x))),
      );

  factory PaymentList.fromStringJson(String strJson) =>
      PaymentList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return PaymentList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!payments.contains(element)) payments.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return PaymentList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => payments;

  Map<String, dynamic> toJson() => {
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
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

@JsonSerializable()
class PaymentModel extends Payment implements EntityModel {
  @override
  String? merchantUuId;
  @override
  String? merchantName;
  @override
  String? merchantAlias;
  @override
  String? merchantAvatar;
  @override
  String? merchantOpId;
  @override
  String? transactionUuId;
  @override
  String? statusCode;
  @override
  DateTime? transactionCreatedAt;
  @override
  DateTime? transactionUpdatedAt;
  @override
  String? transctionSignature;
  @override
  String? leaf;
  @override
  String? refundedAmount;
  @override
  String? currency;
  @override
  String? transactionDescription;
  @override
  String? transactionDenom;
  @override
  String? transactionCode;
  @override
  String? comission;
  @override
  String? terminalId;
  @override
  String? invoiceNumber;
  @override
  String? userName;
  @override
  String? name;
  @override
  String? lastName;
  @override
  String? avatar;
  @override
  Map<String, dynamic>? items;
  @override
  Map<String, dynamic>? invoiceService;
  @override
  String? verified;
  @override
  String? userUuid;
  PaymentModel({
    this.merchantUuId,
    this.merchantName,
    this.merchantAlias,
    this.merchantAvatar,
    this.merchantOpId,
    this.transactionUuId,
    this.statusCode,
    this.transactionCreatedAt,
    this.transactionUpdatedAt,
    this.transctionSignature,
    this.leaf,
    this.refundedAmount,
    this.currency,
    this.transactionDescription,
    this.transactionDenom,
    this.transactionCode,
    this.comission,
    this.terminalId,
    this.invoiceNumber,
    this.userName,
    this.name,
    this.lastName,
    this.avatar,
    this.items,
    this.invoiceService,
    this.verified,
    this.userUuid,
  }) : super(
            merchantUuId: merchantUuId,
            merchantName: merchantName,
            merchantAlias: merchantAlias,
            merchantAvatar: merchantAvatar,
            merchantOpId: merchantOpId,
            transactionUuId: transactionUuId,
            statusCode: statusCode,
            transactionCreatedAt: transactionCreatedAt,
            transactionUpdatedAt: transactionUpdatedAt,
            transctionSignature: transctionSignature,
            leaf: leaf,
            refundedAmount: refundedAmount,
            currency: currency,
            transactionDescription: transactionDescription,
            transactionDenom: transactionDenom,
            transactionCode: transactionCode,
            comission: comission,
            terminalId: terminalId,
            invoiceNumber: invoiceNumber,
            userName: userName,
            name: name,
            lastName: lastName,
            avatar: avatar,
            items: items,
            invoiceService: invoiceService,
            verified: verified,
            userUuid: userUuid);

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        avatar: getValueFrom("avatar", json, ""),
        currency: getValueFrom("currency", json, ""),
        comission: getValueFrom("comission", json, ""),
        invoiceNumber: getValueFrom("invoiceNumber", json, ""),
        invoiceService: json["invoiceService"],
        items: json["items"],
        lastName: getValueFrom("lastName", json, ""),
        leaf: getValueFrom("leaf", json, ""),
        merchantAlias: getValueFrom("merchantAlias", json, ""),
        merchantAvatar: getValueFrom("merchantAvatar", json, ""),
        merchantName: getValueFrom("merchantName", json, ""),
        merchantOpId: getValueFrom("merchantOpId", json, ""),
        merchantUuId: getValueFrom("merchantUuId", json, ""),
        name: getValueFrom("name", json, ""),
        refundedAmount: getValueFrom("refundedAmount", json, ""),
        statusCode: getValueFrom("statusCode", json, ""),
        terminalId: getValueFrom("terminalId", json, ""),
        transactionCode: getValueFrom("transactionCode", json, ""),
        transactionCreatedAt: DateTime.parse(json["transactionCreatedAt"]),
        transactionDenom: getValueFrom("transactionDenom", json, ""),
        transactionDescription:
            getValueFrom("transactionDescription", json, ""),
        transactionUpdatedAt: DateTime.parse(json["transactionUpdatedAt"]),
        transactionUuId: getValueFrom("transactionUuId", json, ""),
        transctionSignature: getValueFrom("transctionSignature", json, ""),
        userName: getValueFrom("userName", json, ""),
        userUuid: getValueFrom("userUuid", json, ""),
        verified: getValueFrom("verified", json, ""),
      );

  factory PaymentModel.fromXml(
          XmlElement element, PaymentModel Function(XmlElement el) process) =>
      process(element);

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  @override
  Map<String, dynamic> toJson() => {};

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  //method generated by wizard
  @override
  T cloneWith<T extends EntityModel>(T other) {
    return PaymentModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return PaymentList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return PaymentList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return PaymentList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return PaymentModel.fromJson(params) as T;
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
    return {"id_payment": "ID"};
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
        onCancel: onCancel);
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

  /* @override
  Map<String, dynamic> toJson() => {
        "id_payment": idPayment,
      };*/

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
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader);
  }

  @override
  Map<String, ColumnMetaModel>? metaModel;
}
