// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);
// // ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
// import 'dart:async';
// import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';
// import 'package:xml/xml.dart';

// import '../../../../../app/core/interfaces/entity_model.dart';
// import '../../../../core/services/logger_service.dart';
// import '../../domain/entities/refund.dart';

// RefundModelList giftListModelFromJson(String str) =>
//     RefundModelList.fromJson(json.decode(str));

// RefundModel refundModelFromJson(String str) => RefundModel.fromJson(json.decode(str));

// String refundModelToJson(RefundModel data) => json.encode(data.toJson());

// class AddRefundModel extends AddRefund {
//   @override
//   final Map<String,dynamic> amount;
//   @override
//   final String commerceRefundId;
//   @override
//   final String username;
//   @override
//   final String description;
//   AddRefundModel(
//       {
//       required this.amount,
//       required this.commerceRefundId,
//       required this.username,
//       required this.description,
      
      
//       }) : super(amount: amount, commerceRefundId: commerceRefundId, username: username, description: description);
//   factory AddRefundModel.fromJson(Map<String, dynamic> json) {
//     log('Este es el json q está llegando$json');
//     return AddRefundModel(
//       amount: json.containsKey("amount") && json["amount"] != null
//           ? json["amount"]
//           : "",
//       commerceRefundId: json.containsKey("commerce_refund_id") && json["commerce_refund_id"] != null
//           ? json["commerce_refund_id"]
//           : "",
//       username: json.containsKey("username") && json["username"] != null
//           ? json["username"]
//           : "",
//       description: json.containsKey("description") && json["description"] != null
//           ? json["description"]
//           : "",
//       );
//   }
//   Map<String, dynamic> toJson() => {
//         "amount": amount,
//         "commerce_refund_id": commerceRefundId,
//         "username": username,
//         "description": description,
//          };
// }
// class HRefRefundModel extends HRefRefund {
//   @override
//   final String? rel;
//   @override
//   final String? method;
//   @override
//   final String? href;
//   HRefRefundModel(
//       {
//       required this.rel,
//       required this.method,
//       required this.href,
//        }) : super(rel: rel, method: method, href: href);
//   factory HRefRefundModel.fromJson(Map<String, dynamic> json) {
//     log('Este es el json q está llegando$json');
//     return HRefRefundModel(
//       rel: json.containsKey("rel") && json["rel"] != null
//           ? json["rel"]
//           : "",
//       method: json.containsKey("method") && json["method"] != null
//           ? json["method"]
//           : "",
//       href: json.containsKey("href") && json["href"] != null
//           ? json["href"]
//           : "",
//           );
//   }
//   Map<String, dynamic> toJson() => {
//         "rel": rel,
//         "method": method,
//         "href": href,
//         };
// }

// class RefundModelList<T extends RefundModel> implements EntityModelList<T> {
//   Map<String, dynamic> avatars;

//   List<T> gifts;
//   RefundModelList({
//     required this.avatars,
//     required this.gifts,
//   });

//   factory RefundModelList.fromJson(Map<String, dynamic> json) => RefundModelList(
//         avatars: json.containsKey("avatars") && json["avatars"] != null
//             ? json["avatars"]
//             : {},
//         gifts: List<T>.from(json["gift"].map((x) => RefundModel.fromJson(x))),
//         /* gifts: json.containsKey("gift") && json["gift"] != null && json["gift"].toString().contains('[]')
//         ? List<T>.from(json["gift"].map((x) => RefundModel.fromJson(x)))
//         : json["gift"], */
//       );

//   factory RefundModelList.fromStringJson(String strJson) =>
//       RefundModelList.fromJson(json.decode(strJson));

//   @override
//   int get getTotal => getList().length;

//   @override
//   EntityModelList<T> add(T element) => fromList(getList()..add(element));

//   @override
//   EntityModelList<T> addAll(EntityModelList<T> newItems) {
//     gifts.addAll(newItems.getList());
//     return this;
//   }

//   @override
//   EntityModelList<T> fromJson(Map<String, dynamic> json) {
//     return RefundModelList.fromJson(json);
//   }

//   @override
//   EntityModelList<T> fromList(List<T> list) {
//     for (var element in list) {
//       if (!gifts.contains(element)) gifts.add(element);
//     }
//     return this;
//   }

//   @override
//   EntityModelList<T> fromStringJson(String strJson) {
//     return RefundModelList.fromStringJson(strJson);
//   }

//   @override
//   List<T> getList() => gifts;

//   @override
//   EntityModelList<T> remove(T element) {
//     gifts.remove(element);
//     return this;
//   }

//   Map<String, dynamic> toJson() => {
//         "avatars": avatars,
//         "gift": List<dynamic>.from(gifts.map((x) => x.toJson())),
//       };

//   static Future<T> fromXmlServiceUrl<T>(
//       String url,
//       String parentTagName,
//       Future<T> Function(XmlDocument doc, XmlElement el) process,
//       Future<T> Function() onError) async {
//     return EntityModelList.fromXmlServiceUrl(
//         url, parentTagName, process, onError);
//   }

//   static Future<T> getJsonFromXMLUrl<T>(
//       String url,
//       Future<T> Function(XmlDocument result) process,
//       Future<T> Function() onError) async {
//     return EntityModelList.getJsonFromXMLUrl(url, process, onError);
//   }
// }

// @JsonSerializable()
// class RefundModel extends Refund implements EntityModel {
//   @override
//   final String? transactionUuid;
//   @override
//   final String? status;
//   @override
//   final String? transactionStatusCode;
//   @override
//   final String? createdAt;
//   @override
//   final String? updatedAt;
//   @override
//   final Map<String,dynamic>? amount;
//   @override
//   final String? parentPaymentUuid;
//   @override
//   final String? description;
//   @override
//   final String? transactionDenom;
//   @override
//   final List<dynamic>? links;
//   @override
//   final String? refundName;
//   @override
//   final String? refundLastname;
//   @override
//   final String? refundAvatar;

  
//   @override
//   Map<String, ColumnMetaModel>? metaModel;
//   RefundModel( {
//      this.amount,
//      this.transactionUuid,
//      this.status,
//      this.transactionStatusCode,
//      this.createdAt,
//      this.updatedAt,
//      this.parentPaymentUuid,
//      this.description,
//      this.transactionDenom,
//      this.links,
//      this.refundName,
//      this.refundLastname,
//      this.refundAvatar,
    
//   }) : super(
//           amount:amount,
//           transactionUuid: transactionUuid,
//           status: status,
//           transactionStatusCode: transactionStatusCode,
//           createdAt: createdAt,
//           updatedAt: updatedAt,
//           parentPaymentUuid: parentPaymentUuid,
//           description: description,
//           transactionDenom: transactionDenom,
//           links: links,
//           refundName: refundName,
         
//         );
//   factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
//         amount: json.containsKey("amount") &&
//                 json["amount"] != null
//             ? json["amount"]
//             : {}, //json["uuid"],
//         transactionUuid: json.containsKey("transaction_uuid") &&
//                 json["transaction_uuid"] != null
//             ? json["transaction_uuid"]
//             : '', //json["uuid"],
//         status: json.containsKey("status") &&
//                 json["status"] != null
//             ? json["status"]
//             : '', //json["uuid"],
//         transactionStatusCode: json.containsKey("transaction_status_code") &&
//                 json["transaction_status_code"] != null
//             ? json["transaction_status_code"]
//             : '', //json["uuid"],
//         createdAt: json.containsKey("created_at") &&
//                 json["created_at"] != null
//             ? json["created_at"]
//             : '', //json["uuid"],
//         updatedAt: json.containsKey("updated_at") &&
//                 json["updated_at"] != null
//             ? json["updated_at"]
//             : '', //json["uuid"],
//         parentPaymentUuid: json.containsKey("parent_payment_uuid") &&
//                 json["parent_payment_uuid"] != null
//             ? json["parent_payment_uuid"]
//             : '', //json["uuid"],
//         description: json.containsKey("description") &&
//                 json["description"] != null
//             ? json["description"]
//             : '', //json["uuid"],
//         transactionDenom: json.containsKey("transaction_denom") &&
//                 json["transaction_denom"] != null
//             ? json["transaction_denom"]
//             : '', //json["uuid"],
//         links: json.containsKey("links") &&
//                 json["links"] != null
//             ? json["links"]
//             : <HRefRefundModel>[],//json["uuid"],
//         refundName: json.containsKey("refund_name") &&
//                 json["refund_name"] != null
//             ? json["refund_name"]
//             : '', //json["uuid"],
//         refundLastname: json.containsKey("refund_lastname") &&
//             json["refund_lastname"] != null
//             ? json["refund_lastname"]
//             : '',
//         refundAvatar: json.containsKey("refund_avatar") &&
//                 json["refund_avatar"] != null
//             ? json["refund_avatar"]
//             : '', //json["uuid"],
//         //json["uuid"],
        
//       );

//    @override
//   Map<String, dynamic> toJson() => {
//         "amount": amount,
//         "transaction_uuid": transactionUuid,
//         "status": status,
//         "transaction_status_code": transactionStatusCode,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "parent_payment_uuid": parentPaymentUuid,
//         "description": description,
//         "transaction_denom": transactionDenom,
//         "links": links,
//         "refund_name": refundName,
        
//       };
         
//   factory RefundModel.fromXml(
//           XmlElement element, RefundModel Function(XmlElement el) process) =>
//       process(element);
//   @override
//   Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();
//   @override
//   bool get isSelected => selected ?? false;
//   List<Object?> get props => [];

//   @override
//   set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
//     metaModel = newMetaModel;
//   }

//   bool? get stringify => true;

//   //method generated by wizard
//   @override
//   T cloneWith<T extends EntityModel>(T other) {
//     return RefundModel.fromJson(other.toJson()) as T;
//   }

//   @override
//   EntityModelList createModelListFrom(dynamic data) {
//     try {
//       if (data is Map) {
//         return RefundModelList.fromJson(data as Map<String, dynamic>);
//       }
//       if (data is String) {
//         return RefundModelList.fromStringJson(data);
//       }
//     } on Exception {
//       log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
//     }
//     return RefundModelList.fromJson({});
//   }

//   @override
//   T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
//     return RefundModel.fromJson(params) as T;
//   }

//   @override
//   String getColumnIdName() {
//     return "uuid";
//   }

//   @override
//   Map<String, ColumnMetaModel> getColumnMetaModel() {
//     try {
//       //Map<String, String> colNames = getColumnNames();
//       metaModel = metaModel ??
//           {
//             //TODO Declare here all ColumnMetaModel. you can use class implementation of class "DefaultColumnMetaModel".
//           };
//       int index = 0;
//       metaModel!.forEach((key, value) {
//         value.setColumnIndex(index++);
//       });
//       return metaModel!;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Map<String, String> getColumnNames() {
//     return {"id_gift": "ID"};
//   }

//   @override
//   List<String> getColumnNamesList() {
//     return getColumnNames().values.toList();
//   }

//   StreamController<EntityModel> getController({
//     void Function()? onListen,
//     void Function()? onPause,
//     void Function()? onResume,
//     FutureOr<void> Function()? onCancel,
//   }) {
//     return EntityModel.getController(
//         entity: this,
//         onListen: onListen,
//         onPause: onPause,
//         onResume: onResume,
//         onCancel: onCancel);
//   }

//   @override
//   dynamic getId() {
//     //return url;
//   }

//   @override
//   Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue) {
//     try {
//       final Map<K1, V1> result = {};
//       getColumnMetaModel().map<K1, V1>((key, value) {
//         MapEntry<K1, V1> el = MapEntry(value.getDataIndex() as K1, value as V1);
//         if (value[searchKey] == searchValue) {
//           result.putIfAbsent(value.getDataIndex() as K1, () {
//             return value as V1;
//           });
//         }
//         return el;
//       });
//       return result;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Map<String, String> getVisibleColumnNames() {
//     try {
//       Map<String, String> names = {};
//       getMeta<String, ColumnMetaModel>("visible", true)
//           .map<String, String>((key, value) {
//         names.putIfAbsent(key, () => value.getColumnName());
//         return MapEntry(key, value.getColumnName());
//       });
//       return names;
//       // throw UnimplementedError();
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

  

//   @override
//   Map<String, ColumnMetaModel> updateColumnMetaModel(
//       String keySearch, dynamic valueSearch, dynamic newValue) {
//     Map<String, ColumnMetaModel> tmp = getColumnMetaModel();
//     getMeta<String, ColumnMetaModel>(keySearch, valueSearch)
//         .map<String, ColumnMetaModel>((key, value) {
//       tmp.putIfAbsent(key, () => value);
//       return MapEntry(key, value);
//     });
//     return metaModel = tmp;
//   }

//   @override
//   static T getValueFrom<T>(
//       String key, Map<dynamic, dynamic> json, T defaultValue,
//       {JsonReader<T>? reader}) {
//     return EntityModel.getValueFromJson<T>(key, json, defaultValue,
//         reader: reader);
//   }
  
//   @override
//   bool? selected;
// }
