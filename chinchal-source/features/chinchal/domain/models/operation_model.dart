
import 'dart:convert';

import '../entities/operation_entity.dart';


ListOperationMerchantModel operationMerchantModelFromJson(String str) => ListOperationMerchantModel.fromJson(json.decode(str));

String operationMerchantModelToJson(ListOperationMerchantModel data) => json.encode(data.toJson());

class ListOperationMerchantModel extends OperationMerchantModel {
  
final List<OperationMerchantModel>? content;
    

    ListOperationMerchantModel({
        this.content,
        
    });

    factory ListOperationMerchantModel.fromJson(Map<String, dynamic> json) => ListOperationMerchantModel(
        content: List<OperationMerchantModel>.from(json["content"].map((x) => OperationMerchantModel.fromJson(x))),
        
    );
    factory ListOperationMerchantModel.fromStringJson(String strJson) =>
      ListOperationMerchantModel.fromJson(json.decode(strJson));
    
    @override
  Map<String, dynamic> toJson() => {
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        
    };
}
   
class OperationMerchantModel extends OperationMerchant{
  
    @override
  final String? status;
    @override
  final String? transactionId;
    @override
  final String? username;
    @override
  final String? type;
    @override
  final String? currency;
    @override
  final String? createdAt;
    @override
  final String? updateAt;
    @override
  final String? description;
    @override
  final String? total;
    @override
  final String? shipping;
    @override
  final String? tax;
    @override
  final String? discount;
    @override
  final String? tip;
    @override
  final String? refundedAmount;
    @override
  final String? merchantOpId;
    @override
  final String? accountUuid;
    @override
  final String? name;
    @override
  final String? lastname;
    @override
  final String? avatar;
    @override
  final String? transactionUuid;
    @override
  final String? commissionCup;
    @override
  final String? commission;     
    
    OperationMerchantModel({
        this.status,
        this.transactionId,
        this.username,
        this.type,
        this.currency,
        this.createdAt,
        this.updateAt,
        this.description,
        this.total,
        this.shipping,
        this.tax,
        this.discount,
        this.tip,
        this.refundedAmount,
        this.merchantOpId,
        this.accountUuid,
        this.name,
        this.lastname,
        this.avatar,
        this.transactionUuid,
        this.commissionCup,
        this.commission
    });

    factory OperationMerchantModel.fromJson(Map<String, dynamic> json) => OperationMerchantModel(
        status: json.containsKey("status") &&
              json["status"] != null
          ? json["status"]
          : "",
        transactionId:
        json.containsKey("transaction_id")&& json["transaction_id"] != null && (json['transaction_id'] is int)
       ? json['transaction_id'].toString()
       : json.containsKey("transaction_id")&& json["transaction_id"] != null && (json['transaction_id'] is double)
       ? json['transaction_id'].toString()
       : json.containsKey("transaction_id")&& json["transaction_id"] != null && (json['transaction_id'] is String)
       ?json['transaction_id']
       : '',
        username: json.containsKey("username") &&
              json["username"] != null
          ? json["username"]
          : "",
        type: json.containsKey("type") &&
              json["type"] != null
          ? json["type"]
          : "",
        currency: json.containsKey("currency") &&
              json["currency"] != null
          ? json["currency"]
          : "",
        createdAt: json.containsKey("createdAt") &&
              json["createdAt"] != null
          ? json["createdAt"]
          : "",
        updateAt: json.containsKey("updateAt") &&
              json["updateAt"] != null
          ? json["updateAt"]
          : "",
        description: json.containsKey("description") &&
              json["description"] != null
          ? json["description"]
          : "",
        total: 
        json.containsKey("total")&& json["total"] != null && (json['total'] is int)
       ? json['total'].toString()
       : json.containsKey("total")&& json["total"] != null && (json['total'] is double)
       ? json['total'].toString()
       : json.containsKey("total")&& json["total"] != null && (json['total'] is String)
       ?json['total']
       : ''/* json.containsKey("total") &&
              json["total"] != null
          ? json["total"]
          : "" */,
        shipping: json.containsKey("shipping")&& json["shipping"] != null && (json['shipping'] is int)
       ? json['shipping'].toString()
       : json.containsKey("shipping")&& json["shipping"] != null && (json['shipping'] is double)
       ? json['shipping'].toString()
       : json.containsKey("shipping")&& json["shipping"] != null && (json['shipping'] is String)
       ?json['shipping']
       : '',
        tax: json.containsKey("tax")&& json["tax"] != null && (json['tax'] is int)
       ? json['tax'].toString()
       : json.containsKey("tax")&& json["tax"] != null && (json['tax'] is double)
       ? json['tax'].toString()
       : json.containsKey("tax")&& json["tax"] != null && (json['tax'] is String)
       ?json['tax']
       : '',
        name: json.containsKey("name") &&
              json["name"] != null
          ? json["name"]
          : "",
        discount: json.containsKey("discount")&& json["discount"] != null && (json['discount'] is int)
       ? json['discount'].toString()
       : json.containsKey("discount")&& json["discount"] != null && (json['discount'] is double)
       ? json['discount'].toString()
       : json.containsKey("discount")&& json["discount"] != null && (json['discount'] is String)
       ?json['discount']
       : '',
        tip: json.containsKey("tip")&& json["tip"] != null && (json['tip'] is int)
       ? json['tip'].toString()
       : json.containsKey("tip")&& json["tip"] != null && (json['tip'] is double)
       ? json['tip'].toString()
       : json.containsKey("tip")&& json["tip"] != null && (json['tip'] is String)
       ?json['tip']
       : '',
        refundedAmount: json.containsKey("refunded_amount")&& json["refunded_amount"] != null && (json['refunded_amount'] is int)
       ? json['refunded_amount'].toString()
       : json.containsKey("refunded_amount")&& json["refunded_amount"] != null && (json['refunded_amount'] is double)
       ? json['refunded_amount'].toString()
       : json.containsKey("refunded_amount")&& json["refunded_amount"] != null && (json['refunded_amount'] is String)
       ?json['refunded_amount']
       : '',
        merchantOpId: json.containsKey("merchant_op_id")&& json["merchant_op_id"] != null && (json['merchant_op_id'] is int)
       ? json['merchant_op_id'].toString()
       : json.containsKey("merchant_op_id")&& json["merchant_op_id"] != null && (json['merchant_op_id'] is double)
       ? json['merchant_op_id'].toString()
       : json.containsKey("merchant_op_id")&& json["merchant_op_id"] != null && (json['merchant_op_id'] is String)
       ?json['merchant_op_id']
       : '',
        accountUuid: json.containsKey("accountUuid") &&
              json["accountUuid"] != null
          ? json["accountUuid"]
          : "",
        lastname: json.containsKey("lastname") &&
              json["lastname"] != null
          ? json["lastname"]
          : "",
        avatar: json.containsKey("avatar") &&
              json["avatar"] != null
          ? json["avatar"]
          : "",
        transactionUuid: json.containsKey("transaction_uuid") &&
              json["transaction_uuid"] != null
          ? json["transaction_uuid"]
          : "",
        commissionCup: json.containsKey("commission_cup")&& json["commission_cup"] != null && (json['commission_cup'] is int)
       ? json['commission_cup'].toString()
       : json.containsKey("commission_cup")&& json["commission_cup"] != null && (json['commission_cup'] is double)
       ? json['commission_cup'].toString()
       : json.containsKey("commission_cup")&& json["commission_cup"] != null && (json['commission_cup'] is String)
       ?json['commission_cup']
       : '',
        commission: json.containsKey("commission")&& json["commission"] != null && (json['commission'] is int)
       ? json['commission'].toString()
       : json.containsKey("commission")&& json["commission"] != null && (json['commission'] is double)
       ? json['commission'].toString()
       : json.containsKey("commission")&& json["commission"] != null && (json['commission'] is String)
       ?json['commission']
       : ''
    );
        factory OperationMerchantModel.fromStringJson(String strjson)=>OperationMerchantModel.fromJson(json.decode(strjson));


    Map<String, dynamic> toJson() => {
        "status": status,
        "transaction_id": transactionId,
        "username": username,
        "type": type,
        "currency": currency,
        "createdAt": createdAt,
        "updateAt": updateAt,
        "description": description,
        "total": total,
        "shipping": shipping,
        "tax": tax,
        "name": name,
        "discount": discount,
        "tip": tip,
        "refunded_amount": refundedAmount,
        "merchant_op_id": merchantOpId,
        "accountUuid": accountUuid,
        "lastname": lastname,
        "avatar": avatar,
        "transaction_uuid": transactionUuid,
        "commission_cup": commissionCup,
        "commission": commission,
    };
  }


