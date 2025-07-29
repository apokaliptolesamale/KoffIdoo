// // ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:apk_template/features/apk_comercio_experto/domain/entities/entities.dart';

ListBeneficiariesModel beneficiariesModelFromJson(String str) => ListBeneficiariesModel.fromJson(json.decode(str));

String beneficiariesModelToJson(ListBeneficiariesModel data) => json.encode(data.toJson());

class ListBeneficiariesModel {
  
final List<BeneficiaryModel>? content;
    

    ListBeneficiariesModel({
        this.content,
        
    });

    factory ListBeneficiariesModel.fromJson(Map<String, dynamic> json) => ListBeneficiariesModel(
        content: List<BeneficiaryModel>.from(json["content"].map((x) => BeneficiaryModel.fromJson(x))),
        
    );
    factory ListBeneficiariesModel.fromStringJson(String strJson) =>
      ListBeneficiariesModel.fromJson(json.decode(strJson));
    
    
  Map<String, dynamic> toJson() => {
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        
    };
}

class BeneficiaryModel implements BeneficiaryEntity {
  @override
  String? nameBeneficiary;

  @override
  String? lastNameBeneficiary;

  @override
  String? ciBeneficiary;

  @override
  String? phoneBeneficiary;

  @override
  String? addressBeneficiary;

  BeneficiaryModel({
      this.nameBeneficiary,
      this.lastNameBeneficiary,
      this.ciBeneficiary,
      this.phoneBeneficiary,
      this.addressBeneficiary,
    });

  factory BeneficiaryModel.fromRawJson(String str) =>
      BeneficiaryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) => BeneficiaryModel(
        nameBeneficiary: json['nameBeneficiary'] ?? '',
        lastNameBeneficiary: json['lastNameBeneficiary'] ?? '',
        ciBeneficiary: json['ciBeneficiary'] ?? '',
        phoneBeneficiary: json['phoneBeneficiary'] ?? '',
        addressBeneficiary: json['addressBeneficiary'] ?? '',
      );

  
  Map<String, dynamic> toJson() => {
        'nameBeneficiary': nameBeneficiary,
        'lastNameBeneficiary': lastNameBeneficiary,
        'ciBeneficiary': ciBeneficiary,
        'phoneBeneficiary': phoneBeneficiary,
        'addressBeneficiary': addressBeneficiary,
      };
}