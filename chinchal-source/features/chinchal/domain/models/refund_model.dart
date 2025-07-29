// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:convert';
import 'dart:developer';


import '../entities/refund.dart';

RefundModelList giftListModelFromJson(String str) =>
    RefundModelList.fromJson(json.decode(str));

RefundModel refundModelFromJson(String str) => RefundModel.fromJson(json.decode(str));

String refundModelToJson(RefundModel data) => json.encode(data.toJson());

class AddRefundModel extends AddRefund {
  @override
  final Map<String,dynamic> amount;
  @override
  final String commerceRefundId;
  @override
  final String username;
  @override
  final String description;
  AddRefundModel(
      {
      required this.amount,
      required this.commerceRefundId,
      required this.username,
      required this.description,
      
      
      }) : super(amount: amount, commerceRefundId: commerceRefundId, username: username, description: description);
  factory AddRefundModel.fromJson(Map<String, dynamic> json) {
    log('Este es el json q está llegando$json');
    return AddRefundModel(
      amount: json.containsKey("amount") && json["amount"] != null
          ? json["amount"]
          : "",
      commerceRefundId: json.containsKey("commerce_refund_id") && json["commerce_refund_id"] != null
          ? json["commerce_refund_id"]
          : "",
      username: json.containsKey("username") && json["username"] != null
          ? json["username"]
          : "",
      description: json.containsKey("description") && json["description"] != null
          ? json["description"]
          : "",
      );
  }
  Map<String, dynamic> toJson() => {
        "amount": amount,
        "commerce_refund_id": commerceRefundId,
        "username": username,
        "description": description,
         };
}
class HRefRefundModel extends HRefRefund {
  @override
  final String? rel;
  @override
  final String? method;
  @override
  final String? href;
  HRefRefundModel(
      {
      required this.rel,
      required this.method,
      required this.href,
       }) : super(rel: rel, method: method, href: href);
  factory HRefRefundModel.fromJson(Map<String, dynamic> json) {
    log('Este es el json q está llegando$json');
    return HRefRefundModel(
      rel: json.containsKey("rel") && json["rel"] != null
          ? json["rel"]
          : "",
      method: json.containsKey("method") && json["method"] != null
          ? json["method"]
          : "",
      href: json.containsKey("href") && json["href"] != null
          ? json["href"]
          : "",
          );
  }
  Map<String, dynamic> toJson() => {
        "rel": rel,
        "method": method,
        "href": href,
        };
}

class RefundModelList extends RefundModel {
  Map<String, dynamic> avatars;

  List<RefundModel> gifts;
  RefundModelList({
    required this.avatars,
    required this.gifts,
  });

  factory RefundModelList.fromJson(Map<String, dynamic> json) => RefundModelList(
        avatars: json.containsKey("avatars") && json["avatars"] != null
            ? json["avatars"]
            : {},
        gifts: List<RefundModel>.from(json["gift"].map((x) => RefundModel.fromJson(x))),
        /* gifts: json.containsKey("gift") && json["gift"] != null && json["gift"].toString().contains('[]')
        ? List<T>.from(json["gift"].map((x) => RefundModel.fromJson(x)))
        : json["gift"], */
      );

  factory RefundModelList.fromStringJson(String strJson) =>
      RefundModelList.fromJson(json.decode(strJson));

  

  
}


class RefundModel extends Refund{
  @override
  final String? transactionUuid;
  @override
  final String? status;
  @override
  final String? transactionStatusCode;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  final Map<String,dynamic>? amount;
  @override
  final String? parentPaymentUuid;
  @override
  final String? description;
  @override
  final String? transactionDenom;
  @override
  final List<dynamic>? links;
  @override
  final String? refundName;
  @override
  final String? refundLastname;
  @override
  final String? refundAvatar;

  
  @override
 
  RefundModel( {
     this.amount,
     this.transactionUuid,
     this.status,
     this.transactionStatusCode,
     this.createdAt,
     this.updatedAt,
     this.parentPaymentUuid,
     this.description,
     this.transactionDenom,
     this.links,
     this.refundName,
     this.refundLastname,
     this.refundAvatar,
    
  }) : super(
          amount:amount,
          transactionUuid: transactionUuid,
          status: status,
          transactionStatusCode: transactionStatusCode,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentPaymentUuid: parentPaymentUuid,
          description: description,
          transactionDenom: transactionDenom,
          links: links,
          refundName: refundName,
         
        );
  factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
        amount: json.containsKey("amount") &&
                json["amount"] != null
            ? json["amount"]
            : {}, //json["uuid"],
        transactionUuid: json.containsKey("transaction_uuid") &&
                json["transaction_uuid"] != null
            ? json["transaction_uuid"]
            : '', //json["uuid"],
        status: json.containsKey("status") &&
                json["status"] != null
            ? json["status"]
            : '', //json["uuid"],
        transactionStatusCode: json.containsKey("transaction_status_code") &&
                json["transaction_status_code"] != null
            ? json["transaction_status_code"]
            : '', //json["uuid"],
        createdAt: json.containsKey("created_at") &&
                json["created_at"] != null
            ? json["created_at"]
            : '', //json["uuid"],
        updatedAt: json.containsKey("updated_at") &&
                json["updated_at"] != null
            ? json["updated_at"]
            : '', //json["uuid"],
        parentPaymentUuid: json.containsKey("parent_payment_uuid") &&
                json["parent_payment_uuid"] != null
            ? json["parent_payment_uuid"]
            : '', //json["uuid"],
        description: json.containsKey("description") &&
                json["description"] != null
            ? json["description"]
            : '', //json["uuid"],
        transactionDenom: json.containsKey("transaction_denom") &&
                json["transaction_denom"] != null
            ? json["transaction_denom"]
            : '', //json["uuid"],
        links: json.containsKey("links") &&
                json["links"] != null
            ? json["links"]
            : <HRefRefundModel>[],//json["uuid"],
        refundName: json.containsKey("refund_name") &&
                json["refund_name"] != null
            ? json["refund_name"]
            : '', //json["uuid"],
        refundLastname: json.containsKey("refund_lastname") &&
            json["refund_lastname"] != null
            ? json["refund_lastname"]
            : '',
        refundAvatar: json.containsKey("refund_avatar") &&
                json["refund_avatar"] != null
            ? json["refund_avatar"]
            : '', //json["uuid"],
        //json["uuid"],
        
      );
    factory RefundModel.fromStringJson(String strjson)=>RefundModel.fromJson(json.decode(strjson));

   @override
  Map<String, dynamic> toJson() => {
        "amount": amount,
        "transaction_uuid": transactionUuid,
        "status": status,
        "transaction_status_code": transactionStatusCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "parent_payment_uuid": parentPaymentUuid,
        "description": description,
        "transaction_denom": transactionDenom,
        "links": links,
        "refund_name": refundName,
        
      };
         
  
}
