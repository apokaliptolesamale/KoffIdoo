import '/app/core/config/errors/exceptions.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/modules/transaction/domain/entities/source.dart';

class SourceModel extends Source implements EntityModel {
  SourceModel({
    required this.fundingSourceAvatar,
    required this.fundingSourceName,
    required this.fundingSourceLastname,
    required this.fundingSourceAmount,
    required this.fundingSourceVerified,
    required this.foundingSourceLast4,
    required this.foundignSourceBank,
    required this.merchantAlias,
    required this.merchantAvatar,
    required this.pan,
  }) : super(
            fundingSourceAvatar: fundingSourceAvatar,
            fundingSourceName: fundingSourceName,
            fundingSourceLastname: fundingSourceLastname,
            fundingSourceAmount: fundingSourceAmount,
            fundingSourceVerified: fundingSourceVerified,
            foundingSourceLast4: foundingSourceLast4,
            foundignSourceBank: foundignSourceBank,
            merchantAlias: merchantAlias,
            merchantAvatar: merchantAvatar,
            pan: pan);

  @override
  int? pan;
  @override
  int? foundingSourceLast4;
  @override
  int? foundignSourceBank;
  @override
  String? fundingSourceAvatar;
  @override
  String? fundingSourceName;
  @override
  String? fundingSourceLastname;
  @override
  double? fundingSourceAmount;
  @override
  int? fundingSourceVerified;
  @override
  String? merchantAlias;
  @override
  bool? merchantAvatar;

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        pan: getValueFrom("pan", json, null),
        foundignSourceBank: getValueFrom("funding_source_bank", json, null),
        foundingSourceLast4: getValueFrom("funding_source_last4", json, 1),
        fundingSourceAvatar: getValueFrom(
          "funding_source_avatar",
          json,
          "",
          reader: (key, data, defaultValue) {
            return json.containsKey(key) &&
                    json[key] is bool &&
                    json[key].toString().isNotEmpty
                ? defaultValue
                : json[key].toString();
          },
        ),
        fundingSourceName: getValueFrom("funding_source_name", json, ""),
        fundingSourceLastname:
            getValueFrom("funding_source_lastname", json, ""),
        fundingSourceAmount: getValueFrom("funding_source_amount", json, 0.0),
        fundingSourceVerified:
            getValueFrom("funding_source_verified", json, null),
        merchantAlias: getValueFrom(
          "merchant_alias",
          json,
          "",
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
        merchantAvatar: getValueFrom("merchant_avatar", json, false),
      );

  @override
  Map<String, dynamic> toJson() => {
        "funding_source_last4": foundingSourceLast4,
        "funding_source_bank": foundignSourceBank,
        "funding_source_avatar": fundingSourceAvatar,
        "funding_source_name": fundingSourceName,
        "funding_source_lastname": fundingSourceLastname,
        "funding_source_amount": fundingSourceAmount,
        "funding_source_verified": fundingSourceVerified,
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
