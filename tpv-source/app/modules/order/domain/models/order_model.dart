// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches

import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:xml/xml.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/order/domain/models/beneficiary_model.dart';
import '/app/modules/order/domain/models/order_detail_model.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../controllers/order_controller.dart';
import '../entities/order.dart';

OrderList orderListModelFromJson(String str) =>
    OrderList.fromJson(json.decode(str));

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderList<T extends OrderModel> implements EntityModelList<T> {
  final List<T> orders;

  OrderList({
    required this.orders,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        orders: json.containsKey("orders")
            ? List<T>.from(json["orders"].map((x) => OrderModel.fromJson(x)))
            : [],
      );

  factory OrderList.fromStringJson(String strJson) =>
      OrderList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) {
    !orders.contains(element) ? orders.add(element) : false;
    return this;
  }

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return OrderList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!orders.contains(element)) orders.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return OrderList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => orders;

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
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

class OrderModel extends Order implements EntityModel {
  @override
  String id;

  @override
  String idOrder;

  @override
  String? pin;

  @override
  String address;
  @override
  String status;
  @override
  String? qrCode;
  @override
  String? userName;
  @override
  BeneficiaryModel? beneficiary;
  @override
  EntityModelList<OrderDetailModel> orderDetail;
  @override
  String? merchantUrl;
  @override
  String? credential;
  @override
  String? driver;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  OrderModel({
    required this.id,
    required this.idOrder,
    required this.address,
    this.orderDetail = const DefaultEntityModelList(),
    required this.status,
    this.qrCode,
    this.beneficiary,
    this.pin,
    this.userName,
    this.driver,
    this.merchantUrl,
    this.credential,
  }) : super(
          id: id,
          idOrder: idOrder,
          beneficiary: beneficiary,
          pin: pin,
          userName: userName,
          address: address,
          orderDetail: orderDetail,
          status: status,
          qrCode: qrCode,
          driver: driver,
          merchantUrl: merchantUrl,
          credential: credential,
        ) {
    //getUncypherCredential();
  }
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: getValueFrom("id", json, "-1"),
        idOrder: getValueFrom("idOrder", json, "-1"),
        beneficiary: getValueFrom(
          "beneficiary",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (json.isNotEmpty && json.containsKey(key)) {
              return BeneficiaryModel.fromJson(json[key]);
            }
            return defaultValue;
          },
        ),
        pin: getValueFrom("pin", json, "Desconocido"),
        userName: getValueFrom("userName", json, "Desconocido"),
        address: getValueFrom("address", json, "Desconocida"),
        status: getValueFrom("status", json, "Desconocido"),
        qrCode: getValueFrom("qrCode", json, "Desconocido"),
        driver: getValueFrom("driver", json, "prestashop"),
        merchantUrl: getValueFrom("merchantUrl", json, "merchantUrl"),
        credential: getValueFrom("credential", json, null),
        orderDetail: OrderDetailList.fromJson(json),
      );
  factory OrderModel.fromStringJson(String str) =>
      OrderModel.fromJson(json.decode(str));
  factory OrderModel.fromXml(
          XmlElement element, OrderModel Function(XmlElement el) process) =>
      process(element);

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Object?> get props => [];

  set setDriver(String newDriver) {
    driver = newDriver;
  }

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  //method generated by wizard

  T cloneWith<T extends EntityModel>(T other) {
    return OrderModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return OrderList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return OrderList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return OrderList.fromJson({});
  }

  String decryptWithRSA(String data, String privateKey) {
    //final privateKey = File(privateKeyFile).readAsStringSync();
    final parser = RSAKeyParser();
    final rsaPrivateKey = parser.parse(privateKey) as RSAPrivateKey;
    final cipher = RSAEngine()
      ..init(false, PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey));
    final encryptedData = base64.decode(data);
    final decryptedData = cipher.process(encryptedData);
    return utf8.decode(decryptedData);
  }

  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return OrderModel.fromJson(params) as T;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    // //Map<String, String> colNames = getColumnNames();
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
      "id": "ID",
      "idOrder": "Orden",
      "beneficiary": "Beneficiario(a)",
      "pin": "PIN",
      "userName": "Usuraio",
      "address": "Dirección",
      "status": "Estado",
      "qrCode": "Qr",
      "driver": "Driver",
      "merchantUrl": "Url del comercio",
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

  Future<String> getUncypherCredential() async {
    final ctl = Get.find<OrderController>();
    final response = await ctl.getOrder.setParamsFromMap({"id": id}).call(null);
    response.fold((l) => null, (order) {
      update(order);
    });
    /*if (credential != null && credential!.isNotEmpty) {
      final encrypted = Encrypted.from64(credential!);
      final uncypher = await SslTlsService.uncypher(
        encrypted,
        certPath: ASSETS_RAW_PRESTASHOPCERT_PEM,
        encodedType: SslTlsEncodeType.base64,
        cypherAlgorithms: CypherAlgorithms.rsa,
        encoding: RSAEncoding.PKCS1,
      );
       final uncypher =
          decryptWithRSA(credential!, ASSETS_RAW_PRESTASHOPCERT_PEM);
      return Future.value(uncypher);
    }*/
    return Future.value("");
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
        "id": id,
        "idOrder": idOrder,
        "beneficiary": beneficiary != null ? beneficiary!.toJson() : {},
        "pin": pin,
        "userName": userName,
        "address": address,
        "status": status,
        "qrCode": qrCode,
        "driver": driver,
        "merchantUrl": merchantUrl,
        "credential": credential,
        "orderDetails": orderDetail.getTotal > 0
            ? orderDetail
                .getList()
                .map((e) => {
                      "idOrderDetail": e.idOrderDetail,
                      "product": {
                        "idProduct": e.product.idProduct,
                        "name": e.product.name,
                        "mark": "",
                        "model": "",
                        "price": e.product.price,
                        "code": ""
                      }
                    })
                .toList()
            : []
      };

  OrderModel update(OrderModel order) {
    id = order.id;
    idOrder = order.idOrder;
    address = order.address;
    orderDetail = order.orderDetail;
    status = order.status;
    qrCode = order.qrCode;
    beneficiary = order.beneficiary;
    pin = order.pin;
    userName = order.userName;
    driver = order.driver;
    merchantUrl = order.merchantUrl;
    credential = order.credential;
    return this;
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
}
