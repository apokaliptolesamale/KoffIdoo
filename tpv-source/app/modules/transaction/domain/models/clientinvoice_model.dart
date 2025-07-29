// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '/app/modules/transaction/domain/models/invoice_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/clientinvoice.dart';

ClientInvoiceList clientinvoiceListModelFromJson(String str) =>
    ClientInvoiceList.fromJson(json.decode(str));

ClientInvoiceModel clientinvoiceModelFromJson(String str) =>
    ClientInvoiceModel.fromJson(json.decode(str));

String clientinvoiceModelToJson(ClientInvoiceModel data) =>
    json.encode(data.toJson());

ClientInvoiceModel clientinvoiceModelFromEtecsaJson(String str) =>
    ClientInvoiceModel.fromEtecsaJson(json.decode(str));

String etecsaModelToJson(ClientInvoiceModel data) => json.encode(data.toJson());

class ClientInvoiceList<T extends ClientInvoiceModel>
    implements EntityModelList<T> {
  final List<T> clientinvoices;

  ClientInvoiceList({
    required this.clientinvoices,
  });

  factory ClientInvoiceList.fromEmpty() => ClientInvoiceList(
        clientinvoices:
            List<T>.from([].map((x) => ClientInvoiceList.fromJson(x))),
      );

/*factory CardList.fromJson(Map<String, dynamic> json) => CardList(
        cards: List<T>.from(json["card"].map((x) => CardModel.fromJson(x))),
      ); */

  factory ClientInvoiceList.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("client")) {
      return ClientInvoiceList(
        clientinvoices: List<T>.from(
            json["client"].map((x) => ClientInvoiceModel.fromJson(x))),
      );
    } else if (json.containsKey("debtResponse")) {
      return ClientInvoiceList(
        clientinvoices: List<T>.from(
            json["debtResponse"].map((x) => ClientInvoiceModel.fromJson(x))),
      );
    }
    return ClientInvoiceList(clientinvoices: []);
  }

  factory ClientInvoiceList.fromEtecsaJson(Map<String, dynamic> json) {
    log("ESTE ES JSON en ClientInvoiceList.fromEtecsaJson >>>>>>>>>>>>>>>>>>>>>>>>>>>$json");
    log("ESTE ES JSON datalist en ClientInvoiceList.fromEtecsaJson >>>>>>>>>>>>>>>>>>>>>>>>>>>${json["datalist"]}");
    log("ESTE ES JSON datalist data en ClientInvoiceList.fromEtecsaJson >>>>>>>>>>>>>>>>>>>>>>>>>>>${json["datalist"]["data"]}");
    return ClientInvoiceList(
      clientinvoices: List<T>.from(
          // json["datalist"]["data"].map((x) => DatumList.fromJson(x) funcionaaaaaaaaaaaaaaaa
          // json["datalist"].map((x) => DataJson.fromJson(x)
          // json.map((json) => Datum.fromJson(json)
          json["datalist"]["data"]
              .map((x) => ClientInvoiceModel.fromEtecsaJson(x)
                  // ClientInvoiceModel.fromEtecsaJson(x)
                  )
          // [ClientInvoiceModel.fromEtecsaJson(json)]
          ),
    );
  }

  factory ClientInvoiceList.fromStringJson(String strJson) =>
      ClientInvoiceList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return ClientInvoiceList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!clientinvoices.contains(element)) clientinvoices.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return ClientInvoiceList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => clientinvoices;

  Map<String, dynamic> toJson() => {
        "clientinvoices":
            List<dynamic>.from(clientinvoices.map((x) => x.toJson())),
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
class ClientInvoiceModel extends ClientInvoice implements EntityModel {
  @override
  final String? clientId;
  @override
  final InvoiceList<InvoiceModel>? invoices;
  @override
  final InvoiceList<InvoiceModel>? gasInvoices;
  @override
  String? merchantAlias;
  @override
  String? resultmsg;
  @override
  String? success;
  @override
  String? name;
  @override
  Datalist? datalist;
  @override
  String? gasClientId;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  ClientInvoiceModel(
      {this.gasInvoices,
      this.clientId,
      this.invoices,
      this.merchantAlias,
      this.resultmsg,
      this.success,
      this.name,
      this.datalist,
      this.gasClientId})
      : super(
            gasClientId: gasClientId,
            gasInvoices: gasInvoices,
            clientId: clientId,
            invoices: invoices,
            merchantAlias: merchantAlias,
            datalist: datalist,
            name: name,
            success: success,
            resultmsg: resultmsg);

  factory ClientInvoiceModel.fromJson(Map<String, dynamic> json) {
    return ClientInvoiceModel(
      gasClientId: getValueFrom("clientId", json, ""),
      clientId: getValueFrom("client_id", json, ""),
      invoices: InvoiceList.fromJson(json),
      merchantAlias: getValueFrom("merchant_alias", json, ""),
    );
  }
  factory ClientInvoiceModel.fromEtecsaJson(Map<String, dynamic> json) =>
      ClientInvoiceModel(
        resultmsg: json["resultmsg"],
        success: json["success"],
        name: json["name"],
        datalist: Datalist.fromJson(json["datalist"]),
      );
  Map<String, dynamic> toEtecsaJson() => {
        "resultmsg": resultmsg,
        "success": success,
        "name": name,
        "datalist": datalist!.toJson(),
      };

  factory ClientInvoiceModel.fromXml(XmlElement element,
          ClientInvoiceModel Function(XmlElement el) process) =>
      process(element);

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
        return ClientInvoiceList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return ClientInvoiceList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return ClientInvoiceList.fromJson({});
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
    return {"id_clientinvoice": "ID"};
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

  @override
  Map<String, dynamic> toJson() => {
        "id_clientinvoice": clientId,
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
    String key,
    Map<dynamic, dynamic> json,
    T defaultValue, {
    JsonReader<T>? reader,
  }) {
    return EntityModel.getValueFromJson<T>(
      key,
      json,
      defaultValue,
      reader: reader,
    );
  }
}

class Datalist {
  List<dynamic> data;

  Datalist({
    required this.data,
  });

  factory Datalist.fromJson(Map<String, dynamic> json) => Datalist(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int currentDebt;
  int cons;
  int serviceName;
  int realImport;
  String number;
  String currency;
  int conversionRate;
  String partnerName;
  String errorMsg;
  String storeName;
  bool isValid;
  String expireDate;
  String serviceType;
  int fcuo;
  String contractEid;
  int unpaidDebt;
  int comi;
  String address;
  int monthlyInvoiced;
  String accountStateEid;
  int imps;
  String emittedDate;
  int storeCode;
  int toPay;
  String invoiceEid;
  String yearMonth;
  int currentUnpaidDebt;
  double discount;

  Datum({
    required this.currentDebt,
    required this.cons,
    required this.serviceName,
    required this.realImport,
    required this.number,
    required this.currency,
    required this.conversionRate,
    required this.partnerName,
    required this.errorMsg,
    required this.storeName,
    required this.isValid,
    required this.expireDate,
    required this.serviceType,
    required this.fcuo,
    required this.contractEid,
    required this.unpaidDebt,
    required this.comi,
    required this.address,
    required this.monthlyInvoiced,
    required this.accountStateEid,
    required this.imps,
    required this.emittedDate,
    required this.storeCode,
    required this.toPay,
    required this.invoiceEid,
    required this.yearMonth,
    required this.currentUnpaidDebt,
    required this.discount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        currentDebt: json["current_debt"],
        cons: json["cons"],
        serviceName: json["service_name"],
        realImport: json["real_import"],
        number: json["number"],
        currency: json["currency"],
        conversionRate: json["conversion_rate"],
        partnerName: json["partner_name"],
        errorMsg: json["error_msg"],
        storeName: json["store_name"],
        isValid: json["is_valid"],
        expireDate: json["expire_date"],
        serviceType: json["service_type"],
        fcuo: json["fcuo"],
        contractEid: json["contract_eid"],
        unpaidDebt: json["unpaid_debt"],
        comi: json["comi"],
        address: json["address"],
        monthlyInvoiced: json["monthly_invoiced"],
        accountStateEid: json["account_state_eid"],
        imps: json["imps"],
        emittedDate: json["emitted_date"],
        storeCode: json["store_code"],
        toPay: json["to_pay"],
        invoiceEid: json["invoice_eid"],
        yearMonth: json["year_month"],
        currentUnpaidDebt: json["current_unpaid_debt"],
        discount: json["discount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "current_debt": currentDebt,
        "cons": cons,
        "service_name": serviceName,
        "real_import": realImport,
        "number": number,
        "currency": currency,
        "conversion_rate": conversionRate,
        "partner_name": partnerName,
        "error_msg": errorMsg,
        "store_name": storeName,
        "is_valid": isValid,
        "expire_date": expireDate,
        "service_type": serviceType,
        "fcuo": fcuo,
        "contract_eid": contractEid,
        "unpaid_debt": unpaidDebt,
        "comi": comi,
        "address": address,
        "monthly_invoiced": monthlyInvoiced,
        "account_state_eid": accountStateEid,
        "imps": imps,
        "emitted_date": emittedDate,
        "store_code": storeCode,
        "to_pay": toPay,
        "invoice_eid": invoiceEid,
        "year_month": yearMonth,
        "current_unpaid_debt": currentUnpaidDebt,
        "discount": discount,
      };
}
