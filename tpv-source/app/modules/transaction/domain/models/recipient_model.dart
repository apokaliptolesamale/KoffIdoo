import '/app/core/config/errors/exceptions.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/modules/transaction/domain/entities/recipient.dart';

class RecipientModel extends Recipient implements EntityModel {
  RecipientModel({
    required this.fundingRecipientUsername,
    required this.fundingRecipientVerified,
    required this.fundingRecipientLast4,
    required this.fundingRecipientBank,
    required this.fundingRecipientName,
    required this.fundingRecipientLastName,
    required this.fundingRecipientAvatar,
    required this.merchantAlias,
    required this.merchantAvatar,
    required this.pan,
  }) : super(
            fundingRecipientUsername: fundingRecipientUsername,
            fundingRecipientVerified: fundingRecipientVerified,
            fundingRecipientLast4: fundingRecipientLast4,
            fundingRecipientBank: fundingRecipientBank,
            fundingRecipientName: fundingRecipientName,
            fundingRecipientLastName: fundingRecipientLastName,
            fundingRecipientAvatar: fundingRecipientAvatar,
            merchantAlias: merchantAlias,
            merchantAvatar: merchantAvatar,
            pan: pan);

  @override
  int? pan;
  @override
  String? fundingRecipientAvatar;
  @override
  String? fundingRecipientUsername;
  @override
  String? fundingRecipientName;
  @override
  String? fundingRecipientLastName;
  @override
  dynamic fundingRecipientVerified;
  @override
  int? fundingRecipientLast4;
  @override
  dynamic fundingRecipientBank;
  @override
  String? merchantAlias;
  @override
  String? merchantAvatar;

  factory RecipientModel.fromJson(Map<String, dynamic> json) => RecipientModel(
        pan: getValueFrom(
          "pan",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (json.containsKey(key) &&
                json[key] != null &&
                json[key] is bool) {
              return defaultValue;
            } else {
              return json[key];
            }
          },
        ),
        fundingRecipientName: getValueFrom(
          "funding_recipient_name",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.containsKey(key) &&
                json[key] != null &&
                json[key] is bool) {
              return defaultValue;
            } else {
              return json[key];
            }
          },
        ),
        fundingRecipientLastName: getValueFrom(
          "funding_recipient_lastname",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.containsKey(key) &&
                json[key] != null &&
                json[key] is bool) {
              return defaultValue;
            } else {
              return json[key];
            }
          },
        ),
        fundingRecipientUsername:
            getValueFrom("funding_recipient_username", json, ""),
        fundingRecipientVerified: getValueFrom(
          "funding_recipient_verified",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.containsKey(key) &&
                json[key] != null &&
                json[key] is bool) {
              return json[key];
            } else if (json.containsKey(key) &&
                json[key] != null &&
                json[key] is String) {
              return json[key];
            } else {
              return defaultValue;
            }
          },
        ),
        fundingRecipientLast4:
            getValueFrom("funding_recipient_last4", json, null),
        fundingRecipientBank: getValueFrom("funding_recipient_bank", json, null,
            reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is bool) {
            return json[key];
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return json[key];
          }else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            return json[key];
          } else {
            return defaultValue;
          }
        }),
        fundingRecipientAvatar:
            getValueFrom("funding_recipient_avatar", json, "",
                reader: (key, data, defaultValue) {
          return json.containsKey(key) &&
                  json[key] is bool &&
                  json[key].toString().isNotEmpty
              ? defaultValue
              : json[key].toString();
        }),
        merchantAlias: getValueFrom("merchant_alias", json, "",
             reader: (key, data, defaultValue) {
            if (json.containsKey(key) &&
                json[key] is bool &&
                json[key] != null) {
              return json[key].toString();
            } else if (json.containsKey(key) &&
                json[key] is String &&
                json[key] != null) {
              return json[key];
            }
            return null;
          },
        
        ),
        merchantAvatar: getValueFrom("merchant_avatar", json, "",
            reader: (key, data, defaultValue) {
          return json.containsKey(key) &&
                  json[key] is bool &&
                  json[key] != null 
              ? json[key].toString()
              : defaultValue;
        }),
      );

  @override
  Map<String, dynamic> toJson() => {
        "funding_recipient_username": fundingRecipientUsername,
        "funding_recipient_verified": fundingRecipientVerified,
        "funding_recipient_last4": fundingRecipientLast4,
        "funding_recipient_bank": fundingRecipientBank,
        "merchant_alias": merchantAlias,
        "merchant_avatar": merchantAvatar
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
}
