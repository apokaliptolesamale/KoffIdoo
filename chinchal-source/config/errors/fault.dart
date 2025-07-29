// To parse this JSON data, do
//
//     final fault = faultFromJson(jsonString);

import 'dart:convert';

import 'failure.dart';

FaultClass faultFromJson(String str) => FaultClass.fromJson(json.decode(str)["fault"]);

String faultToJson(Fault data) => json.encode(data.toJson());

class Fault {
  FaultClass fault;

  Fault({
    required this.fault,
  });

  factory Fault.fromJson(Map<String, dynamic> json) => Fault(
        fault: FaultClass.fromJson(json["fault"]),
      );

  Map<String, dynamic> toJson() => {
        "fault": fault.toJson(),
      };
}

class FaultClass extends Failure implements Exception {
  int? code;
  String? message;
  String? description;

  FaultClass({this.code, this.message, this.description, required super.errorMessage});

  factory FaultClass.fromJson(Map<String, dynamic> json) => FaultClass(
        code: json.containsKey("code") && json["code"] != null
            ? json["code"]
            : null,
        message: json.containsKey("message") &&
                json["message"] != null &&
                (json["message"] != "Runtime Error" ||
                    json["message"] != "Desconocido")
            ? json["message"]
            : "El servicio no está disponible por el momento, intente más tarde",
        description: json.containsKey("description") &&
                json["description"] != null
            ? json["description"]
            : "El servicio no está disponible por el momento, intente más tarde", 
            errorMessage: json.containsKey("message") &&
                json["message"] != null &&
                (json["message"] != "Runtime Error" ||
                    json["message"] != "Desconocido")
            ? json["message"]
            : "El servicio no está disponible por el momento, intente más tarde",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "description": description,
      };
}
