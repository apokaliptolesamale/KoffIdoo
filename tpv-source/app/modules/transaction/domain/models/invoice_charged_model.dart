// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import '/app/modules/transaction/domain/entities/invoice_charged.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';

InvoiceChargedModel invoiceChargedModelFromJson(String str) =>
    InvoiceChargedModel.fromJson(json.decode(str));

InvoiceChargedList invoiceListChargedModelFromJson(String str) {
  return
    InvoiceChargedList.fromJson(json.decode(str));}

String invoiceModelToJson(InvoiceChargedModel data) => json.encode(data.toJson());

class InvoiceChargedList<T extends InvoiceChargedModel> implements EntityModelList<T> {
  final List<T> invoices;

  InvoiceChargedList({
    this.invoices = const [],
  });

  factory InvoiceChargedList.fromStringJson(String strJson) =>
      InvoiceChargedList.fromJson(json.decode(strJson));

  factory InvoiceChargedList.fromJson(Map<String, dynamic> json){
     return InvoiceChargedList(
        invoices:
            List<T>.from(json["invoice"].map((x) => InvoiceChargedModel.fromJson(x))),
      );
  }
  factory InvoiceChargedList.fromEmpty() => InvoiceChargedList(
        invoices: List<T>.from([].map((x) => InvoiceChargedList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
      };

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return InvoiceChargedList.fromJson(json);
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return InvoiceChargedList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => invoices;

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!invoices.contains(element)) invoices.add(element);
    }
    return this;
  }

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
class InvoiceChargedModel extends InvoiceCharged implements EntityModel {
    @override
      String? amount;
    @override
      String leaf;
    @override
      String? invoiceNumber;
    @override
      String? uuid;
    @override
      String rootTransactionId;
    @override
      String createdAt;
    @override
      String updatedAt;
    @override
      String? currency;
    @override
      String? transactionDenom;
    @override
      int? transactionCode;
    @override
      String description;
    @override
      String status;
    @override
      String statusCode;
    @override
      Map<String,dynamic>? bankDebitDetail;
    @override
      String? fundingSourceUuid;
    @override
      String? clientId;
    @override
      String? transactionSignature;
      @override
    int? discount;
 
  InvoiceChargedModel({
                required this.amount,
               required this.bankDebitDetail,
               required this.clientId,
               required this.currency,
               required this.fundingSourceUuid,
               required this.transactionCode,
               required this.transactionDenom,
               required this.transactionSignature,
               required this.uuid,
               required this.createdAt,
               required this.updatedAt,
               required this.description,
               required this.invoiceNumber,
               required this.leaf,
               required this.rootTransactionId,
               required this.status,
               required this.statusCode,
               required this.discount,
  }) : super(
            amount:amount,             
            bankDebitDetail:bankDebitDetail,    
            clientId:clientId,          
            currency:currency,         
            fundingSourceUuid:fundingSourceUuid,  
            transactionCode:transactionCode,   
            transactionDenom:transactionDenom,  
            transactionSignature:transactionSignature,
            uuid:  uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            description: description,
            invoiceNumber: invoiceNumber,
            leaf: leaf,
            rootTransactionId: rootTransactionId,
            status: status,
            statusCode: statusCode,
            discount: discount,
            
  ); 

  factory InvoiceChargedModel.fromJson(Map<String, dynamic> json)
  { return InvoiceChargedModel(
        amount: getValueFrom("amount", json, null,reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is double){
            return (json[key].toString());
          }else if (json.containsKey(key) && json[key] != null && json[key] is int){
            return (json[key].toString());
          }else if (json.containsKey(key) && json[key] != null && json[key] is String){
            return (json[key].toString());
          }
          else{
            return defaultValue;
          }
        },),
       
        bankDebitDetail:getValueFrom("bank_debit_detail", json, null, reader: (key, data, defaultValue) {
          if(json.containsKey(key)&&json[key]!=null && json[key] is Map<String,dynamic>){
            return json[key];
          }else if(json.containsKey(key)&&json[key]!=null && json[key] is String){
            return defaultValue;
          }
          return null;
        },),
        clientId:getValueFrom("client_id", json, "",reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is double){
            return (json[key].toString());
          }else if (json.containsKey(key) && json[key] != null && json[key] is int){
            return (json[key].toString());
          }
          else{
            return defaultValue;
          }
        },),
        currency:getValueFrom("currency", json, ""),
        fundingSourceUuid:getValueFrom("funding_source_uuid", json, ""),
        uuid: getValueFrom("uuid", json, ""),
        createdAt: getValueFrom("created_at", json, ""),
        updatedAt: getValueFrom("updated_at", json, ""),
        leaf: getValueFrom("leaf", json, "", reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is bool){
            return (json[key].toString());
          }
          else{
            return defaultValue;
          }
        },),
        statusCode: getValueFrom("status_code", json, "", reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int){
            return (json[key].toString());
          }
          else{
            return defaultValue;
          }
        },),
        status: getValueFrom("status", json, ""),
        description: getValueFrom("description", json, ""),
        invoiceNumber: getValueFrom("invoice_number", json, ""),
        rootTransactionId: getValueFrom("root_transaction_id", json, ""),

       

      
        transactionCode:getValueFrom("transaction_code", json, null ),
       
      // transactionCreatedAt:  DateTime.parse(json["transaction_created_at"].toString().substring(0,19)) ,
        transactionDenom: getValueFrom("transaction_denom", json, ""),

        transactionSignature:getValueFrom("transaction_signature", json, ""),
        
       discount: getValueFrom("discount", json, null),
  );     
  }
  factory InvoiceChargedModel.fromXml(
          XmlElement element, InvoiceChargedModel Function(XmlElement el) process) =>
      process(element);

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

  @override
  Map<String, dynamic> toJson() => {
       
      };

  @override
  Map<String, String> getColumnNames() {
    return {"id_invoice": "ID"};
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return InvoiceChargedList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return InvoiceChargedList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return InvoiceChargedList.fromJson({});
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    Map<String, String> colNames = getColumnNames();
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
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  @override
  Map<String, ColumnMetaModel>? metaModel;

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
}

