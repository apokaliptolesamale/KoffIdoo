import '../entities/source_gift.dart';
import '/app/core/config/errors/exceptions.dart';
import '/app/core/interfaces/entity_model.dart';

class SourceGiftModel extends SourceGift implements EntityModel {
  SourceGiftModel({
    required this.username,
    required this.verified,
    required this.last4,
    required this.bank,
    required this.name,
    required this.lastname,
  }) : super(
            username: username,
            verified: verified,
            last4: last4,
            bank: bank,
            name: name,
            lastname: lastname);

  @override
  String username;
  @override
  String verified;
  @override
  String last4;
  @override
  String bank;
  @override
  String name;
  @override
  String lastname;

  factory SourceGiftModel.fromJson(Map<String, dynamic> json) =>
      SourceGiftModel(
        username: json["username"],
        verified: json.containsKey("verified") && json["verified"] != null
            ? json["verified"].toString()
            : '',
        last4: json.containsKey("last4") && json["last4"] != null
            ? json["last4"].toString()
            : '', //json["last4"],
        bank: json.containsKey("bank") && json["bank"] != null
            ? json["bank"].toString()
            : '', //json["bank"],
        name: json.containsKey("name") && json["name"] != null
            ? json["name"]
            : '', //json["name"] == null ? null : json["name"],
        lastname: json.containsKey("lastname") && json["lastname"] != null
            ? json["lastname"]
            : '', //json["lastname"] == null ? null : json["lastname"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "verified": verified,
        "last4": last4,
        "bank": bank,
        "name": name,
        "lastname": lastname,
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
