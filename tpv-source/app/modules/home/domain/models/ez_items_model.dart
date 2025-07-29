import 'dart:convert';

import '../entities/ez_item.dart';

List<EzItemModel> itemModelFromJson(String str) => List<EzItemModel>.from(
    json.decode(str).map((x) => EzItemModel.fromJson(x)));

String itemModelToJson(List<EzItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EzItemModel extends EzItem {
  EzItemModel({
    required this.name,
    required this.image,
    required this.moduleName,
  }) : super(
          image: image,
          name: name,
          moduleName: moduleName,
        );

  @override
  String name;
  @override
  String image;
  @override
  String moduleName;

  factory EzItemModel.fromJson(Map<String, dynamic> json) => EzItemModel(
        name: json["name"],
        image: json["image"],
        moduleName: json["module_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "module_name": moduleName,
      };
}
