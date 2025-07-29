// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/core/interfaces/get_provider.dart';
import '../../../app/core/services/logger_service.dart';
import '../../../app/core/services/paths_service.dart';
import '../interfaces/header_request.dart';

///
/// Class for getting the native timezone.
///
class FlutterNativeTimezone {
  static const MethodChannel _channel =
      MethodChannel('flutter_native_timezone');

  ///
  /// Gets the list of available timezones from the native layer.
  ///
  static Future<List<String>> getAvailableTimezones() async {
    final List<String>? availableTimezones =
        await _channel.invokeListMethod<String>("getAvailableTimezones");
    if (availableTimezones == null) {
      throw ArgumentError(
          "Invalid return from platform getAvailableTimezones()");
    }
    return availableTimezones;
  }

  ///
  /// Returns local timezone from the native layer.
  ///
  static Future<String> getLocalTimezone() async {
    final String? localTimezone =
        await _channel.invokeMethod("getLocalTimezone");
    if (localTimezone == null) {
      throw ArgumentError("Invalid return from platform getLocalTimezone()");
    }
    return localTimezone;
  }
}

// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

class Notification extends GetProviderImpl {
  String? id;

  String? user;
  String? pass;
  String? host;
  int? port;
  String? address;
  String? url;
  String? serviceType;
  String? protocol;
  String? message;
  List<String>? phone;
  Notification({
    this.id,
    this.user,
    this.pass,
    this.host,
    this.port,
    this.address,
    this.url,
    this.serviceType,
    this.protocol,
    this.message,
    this.phone,
  }) : super() {
    onInit();
  }

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        user: json["user"],
        pass: json["pass"],
        host: json["host"],
        port: json["port"],
        address: json["address"],
        url: json["url"],
        serviceType: json["serviceType"],
        protocol: json["protocol"],
        message: json["message"],
        phone: json["phone"] == null
            ? null
            : List<String>.from(json["phone"].map((x) => x)),
      );

  factory Notification.fromRawJson(String str) =>
      Notification.fromJson(json.decode(str));

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      log(data);
    };
    baseUrl = httpClient.baseUrl = super.baseUrl = PathsService.smsUrlService;
  }

  send() async {
    Map<String, dynamic> data = toJson();

    final himpl = HeaderRequestImpl(idpKey: "apiez", headers: {
      "accept": '*/*',
      "Content-Type": "application/json",
    });
    Map<String, String> headers = await himpl.getHeaders();
    data.removeWhere((key, value) =>
        value == null || ((value is List || value is Map) && value.isEmpty));
    //data = data.map((key, value) => MapEntry(key, value.toString()));
    //log("Data to send:\n${jsonEncode(data)}");
    //var body = data.toString();
    onStatusCodeListener(401, (provider, response, code) async {
      log("Probando manejo de CallBack para Sms=$code");
      return provider;
    }).onStatusCodeListener(204, (provider, response, code) async {
      log("Probando manejo de CallBack para Sms=$code");
      httpClient.defaultDecoder =
          defaultDecoder = super.defaultDecoder = (map) {};
      return provider;
    }).onStatusCodeListener(500, (provider, response, code) async {
      log("Probando manejo de CallBack para Sms=$code");
      return provider;
    });
    final response = await processResponse(post(
      "sms/created",
      jsonEncode(data),
      headers: headers,
    ));
    return response.fold((l) => Left(l), (resp) {
      log("El sms no se envió. Code: ${resp.statusCode} y respuesta: ${resp.bodyString}");
    });
    /*if (response.statusCode == 200 || response.statusCode == 201) {
      log("Sms enviado satisfactoriamente.");
    } else {
      log("El sms no se envió.Code: ${response.statusCode} y respuesta: ${response.bodyString}");
    }*/
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "pass": pass,
        "host": host,
        "port": port,
        "address": address,
        "url": url,
        "serviceType": serviceType,
        "protocol": protocol,
        "message": message,
        "phone": phone == null ? [] : List<dynamic>.from(phone!.map((x) => x)),
      };

  String toRawJson() => json.encode(toJson());
}

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showMsgError(String message) {
    final snackbar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackbar);
  }

  static showMsgInfo(String message) {
    final snackbar = SnackBar(
      backgroundColor: Colors.green.withOpacity(0.9),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
