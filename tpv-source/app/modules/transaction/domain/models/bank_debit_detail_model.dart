import 'dart:convert';

import '/app/core/config/errors/exceptions.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/modules/transaction/domain/entities/bank_debit_detail.dart';



BankDebitDetailModel bankDebitDetailFromJson(String str) =>
    BankDebitDetailModel.fromJson(json.decode(str));

BankDebitDetailModel bankDebitDetailFromStringJson(String str){
 return BankDebitDetailModel.fromJson(json.decode(str));
}
class BankDebitDetailModel extends BankDebitDetail implements EntityModel {
  @override
  String? tipoCambio;
  @override
  String? discount;
  @override
  String? debited;
  @override
  String? discounted;
  @override
  String? redsa;
  @override
  Map<String, ColumnMetaModel>? metaModel;

  BankDebitDetailModel({
  required this.tipoCambio,
  required this.discount,
  required this.debited,
  required this.discounted,
  required this.redsa}) 
  :
    super(
      tipoCambio: tipoCambio,
      discount: discount,
      debited: debited,
      discounted: discounted,
      redsa: redsa
      );

factory BankDebitDetailModel.fromStringJson(String strJson){
 return  BankDebitDetailModel.fromJson(json.decode(strJson));
}

factory BankDebitDetailModel.fromJson(Map<dynamic,dynamic> json){
  return BankDebitDetailModel(
  tipoCambio: getValueFrom("tipoCambio", json, ""),
  discount:  getValueFrom("discount", json, ""),
  debited:  getValueFrom("debited", json, ""),
  discounted:  getValueFrom("discounted", json, ""),
  redsa:  getValueFrom("redsa", json, "")
  );
}

static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, dynamic defaultValue,{JsonReader<T?>? reader}) {
        if (defaultValue != null && defaultValue is ServerException) {
          throw defaultValue;
        }
        try {
          return EntityModel.getValueFromJson<T?>(key, json, defaultValue, reader: reader);
        } on Exception {
          throw CastErrorException();
        }
      }

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
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }

}