import 'dart:convert';

import '/app/modules/transaction/domain/entities/config_service.dart';

import '/app/core/config/errors/exceptions.dart';
import '/app/core/interfaces/entity_model.dart';

ClientServiceModel ClientServiceModelFromJson(String str) =>
    ClientServiceModel.fromJson(json.decode(str));

ClientServiceModel ClientServiceModelFromStringJson(String str) {
  return ClientServiceModel.fromJson(json.decode(str));
}

class ClientServiceList<T extends ClientServiceModel>
    implements EntityModelList<T> {
  final List<T> clientIds;

  ClientServiceList({
    required this.clientIds,
  });

  factory ClientServiceList.fromModels(List<T> models) => ClientServiceList(
        clientIds: models,
      );

  factory ClientServiceList.fromJson(Map<String, dynamic> json) {
    return ClientServiceList(
      clientIds: json.isNotEmpty
          //? List<T>.from(json.map((x) => ClientServiceModel.fromJson(x)))
          //? List<T>.from(json.map((x) {return ClientServiceModel.fromJson(x);}))
          ? List<T>.from(
              json["client_id"].map((x) => ClientServiceModel.fromJson(x)))
          : [],
    );
  }

  factory ClientServiceList.fromStringJson(String strJson) =>
      ClientServiceList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  Map<String, dynamic> toJson() => {
        "transaction": List<dynamic>.from(clientIds.map((x) => x.toJson())),
      };

  @override
  EntityModelList<T> add(T element) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    // TODO: implement fromList
    throw UnimplementedError();
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    // TODO: implement fromStringJson
    throw UnimplementedError();
  }

  @override
  List<T> getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }
}

class ClientServiceModel extends ClientService implements EntityModel {
  @override
  String? denom;
  @override
  String? serviceUuid;
  @override
  String? fundingSourceUuid;
  @override
  String? clientId;
  @override
  String? automatic;
  @override
  String? owner;
  @override
  Map<String,dynamic>? metadata;
  @override
  String? createdAt;
  @override
  String? updatedAt;
  @override
  String? merchantAlias;
  @override
  String? type;

  ClientServiceModel({
    required this.denom,
    required this.serviceUuid,
    required this.fundingSourceUuid,
    required this.clientId,
    required this.automatic,
    required this.owner,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.merchantAlias,
    required this.type,
  }) : super(
          denom: denom,
          serviceUuid: serviceUuid,
          fundingSourceUuid: fundingSourceUuid,
          clientId: clientId,
          automatic: automatic,
          owner: owner,
          metadata: metadata,
          createdAt: createdAt,
          updatedAt: updatedAt,
          merchantAlias: merchantAlias,
          type: type,
        );

  factory ClientServiceModel.fromStringJson(String strJson) {
    return ClientServiceModel.fromJson(json.decode(strJson));
  }

  factory ClientServiceModel.fromJson(Map<dynamic, dynamic> json) {
    return ClientServiceModel(
        denom: getValueFrom("denom", json, ""),
        serviceUuid: getValueFrom("service_uuid", json, ""),
        fundingSourceUuid:
            getValueFrom("funding_source_uuid", json, ""),
        clientId: getValueFrom(
          "client_id",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json[key] != null &&
                json[key] is int) {
              return json[key].toString();
            } else if(json[key] != null &&
                json[key] is String){
              return json[key];
            }else{
              return defaultValue;
            }
          },
        ),
        automatic: getValueFrom(
          "automatic",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json["automatic"] != null &&
                json["automatic"] is int) {
              return json[key].toString();
            } else {
              return defaultValue;
            }
          },
        ),
        owner: getValueFrom("owner", json, ""),
        metadata: getValueFrom("metadata", json, null,reader: (key, data, defaultValue) {
        if (json.containsKey(key) && json[key] != null && json[key] is String) {
          String jsonString = json[key];
          Map<String,dynamic> mapa = jsonDecode(jsonString);
            return mapa;
          }else if(json.containsKey(key) && json[key] != null && json[key] is Map<String,dynamic>){
            return json[key];
          }
        return null;
      },),
        createdAt: getValueFrom("created_at", json, ""),
        updatedAt: getValueFrom("updated_at", json, ""),
        merchantAlias: getValueFrom("merchant_alias", json, ""),
        type: getValueFrom("type", json, ""));
  }

  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, dynamic defaultValue,
      {JsonReader<T?>? reader}) {
    if (defaultValue != null && defaultValue is ServerException) {
      throw defaultValue;
    }
    try {
      return EntityModel.getValueFromJson<T?>(key, json, defaultValue,
          reader: reader);
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
    return {
      "denom": denom,
      "service_uuid": serviceUuid,
      "funding_source_uuid": fundingSourceUuid,
      "client_id": clientId,
      "automatic": automatic,
      "owner": owner,
      "metadata": metadata,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "merchant_alias": merchantAlias,
      "type": type,
    };
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }

  @override
  Map<String, ColumnMetaModel>? metaModel;
}
