// To parse this JSON data, do
//
//     final etecsa = etecsaFromJson(jsonString);

import 'dart:convert';

import '../../../../core/interfaces/entity_model.dart';
import '../entities/etecsa.dart';

EtecsaModel etecsaFromJson(String str) =>
    EtecsaModel.fromJson(json.decode(str));

String etecsaToJson(EtecsaModel data) => json.encode(data.toJson());

class EtecsaModel extends Etecsa implements EntityModel {
  @override
  String? resultmsg;
  @override
  String? success;
  @override
  String? name;
  @override
  Datalist? datalist;

  EtecsaModel({
    required this.resultmsg,
    required this.success,
    required this.name,
    required this.datalist,
  }) : super(
            datalist: datalist,
            name: name,
            success: success,
            resultmsg: resultmsg);

  factory EtecsaModel.fromJson(Map<String, dynamic> json) => EtecsaModel(
        resultmsg: EntityModel.getValueFrom("resultmsg", json, null),
        success: EntityModel.getValueFrom("success", json, null),
        name: EntityModel.getValueFrom("name", json, null),
        datalist: Datalist.fromJson(json["datalist"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "resultmsg": resultmsg,
        "success": success,
        "name": name,
        "datalist": datalist!.toJson(),
      };

  @override
  Map<String, ColumnMetaModel>? metaModel;

  @override
  EntityModelList createModelListFrom(data) {
    // TODO: implement createModelListFrom
    throw UnimplementedError();
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    // TODO: implement getColumnMetaModel
    throw UnimplementedError();
  }

  @override
  Map<String, String> getColumnNames() {
    // TODO: implement getColumnNames
    throw UnimplementedError();
  }

  @override
  List<String> getColumnNamesList() {
    // TODO: implement getColumnNamesList
    throw UnimplementedError();
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, searchValue) {
    // TODO: implement getMeta
    throw UnimplementedError();
  }

  @override
  // TODO: implement getMetaModel
  Map<String, ColumnMetaModel>? get getMetaModel => throw UnimplementedError();

  @override
  Map<String, String> getVisibleColumnNames() {
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  @override
  set setMetaModel(Map<String, ColumnMetaModel> metaModel) {
    // TODO: implement setMetaModel
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }
}

class Datalist {
  List<Datum> data;

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
  String? currentDebt;
  String? cons;
  String? serviceName;
  String? realImport;
  String? number;
  String? currency;
  String? conversionRate;
  String? partnerName;
  String? errorMsg;
  String? storeName;
  String? isValid;
  String? expireDate;
  String? serviceType;
  String? fcuo;
  String? contractEid;
  String? unpaidDebt;
  String? comi;
  String? address;
  String? monthlyInvoiced;
  String? accountStateEid;
  String? imps;
  String? emittedDate;
  String? storeCode;
  String? toPay;
  String? invoiceEid;
  String? yearMonth;
  String? currentUnpaidDebt;
  String? discount;

  Datum({
    this.currentDebt,
    this.cons,
    this.serviceName,
    this.realImport,
    this.number,
    this.currency,
    this.conversionRate,
    this.partnerName,
    this.errorMsg,
    this.storeName,
    this.isValid,
    this.expireDate,
    this.serviceType,
    this.fcuo,
    this.contractEid,
    this.unpaidDebt,
    this.comi,
    this.address,
    this.monthlyInvoiced,
    this.accountStateEid,
    this.imps,
    this.emittedDate,
    this.storeCode,
    this.toPay,
    this.invoiceEid,
    this.yearMonth,
    this.currentUnpaidDebt,
    this.discount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        currentDebt: json.containsKey("current_debt")
            ? json["current_debt"]
            : null, //getValueFrom("current_debt", json, null),
        cons: json.containsKey("cons") ? json["cons"] : null,
        serviceName:
            json.containsKey("service_name") ? json["service_name"] : null,
        realImport:
            json.containsKey("real_import") ? json["real_import"] : null,
        number: json.containsKey("number") ? json["number"] : null,
        currency: json.containsKey("currency") ? json["currency"] : null,
        conversionRate: json.containsKey("conversion_rate")
            ? json["conversion_rate"]
            : null,
        partnerName:
            json.containsKey("partner_name") ? json["partner_name"] : null,
        errorMsg: json.containsKey("error_msg") ? json["error_msg"] : null,
        storeName: json.containsKey("store_name") ? json["store_name"] : null,
        isValid: json.containsKey("is_valid") ? json["is_valid"] : null,
        expireDate:
            json.containsKey("expire_date") ? json["expire_date"] : null,
        serviceType:
            json.containsKey("service_type") ? json["service_type"] : null,
        fcuo: json.containsKey("fcuo") ? json["fcuo"] : null,
        contractEid:
            json.containsKey("contract_eid") ? json["contract_eid"] : null,
        unpaidDebt:
            json.containsKey("unpaid_debt") ? json["unpaid_debt"] : null,
        comi: json.containsKey("comi") ? json["comi"] : null,
        address: json.containsKey("address") ? json["address"] : null,
        monthlyInvoiced: json.containsKey("monthly_invoiced")
            ? json["monthly_invoiced"]
            : null,
        accountStateEid: json.containsKey("account_state_eid")
            ? json["account_state_eid"]
            : null,
        imps: json.containsKey("imps") ? json["imps"] : null,
        emittedDate:
            json.containsKey("emitted_date") ? json["emitted_date"] : null,
        storeCode: json.containsKey("store_code") ? json["store_code"] : null,
        toPay: json.containsKey("to_pay") ? json["to_pay"] : null,
        invoiceEid:
            json.containsKey("invoice_eid") ? json["invoice_eid"] : null,
        yearMonth: json.containsKey("year_month") ? json["year_month"] : null,
        currentUnpaidDebt: json.containsKey("current_unpaid_debt")
            ? json["current_unpaid_debt"]
            : null,
        discount: json.containsKey("discount") ? json["discount"] : null,
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
