import 'dart:async';

import 'package:flutter/services.dart';

import '/app/core/services/logger_service.dart';
import '../../../../app/core/config/app_config.dart';

class ProductRegistry {
  static final ProductRegistry instance =
      ProductRegistry._internal().addListener("onLoaded", (p0) {
    log("Product Registry Services iniciado.");
  });
  final Map<String, StreamSubscription<dynamic>> _listeners = {};
  final productChannelId = '${ConfigApp.getInstance.applicationId}/product';
  final productEventChannel =
      EventChannel('${ConfigApp.getInstance.applicationId}/product');
  final productMethodChannel =
      MethodChannel('${ConfigApp.getInstance.applicationId}/product');

  ProductRegistry._internal() {
    log("Iniciando instancia de Product Registry Services...");
  }
  ProductRegistry addListener(
    String eventName,
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final listener = _initProductEventChannel(
      onData,
      cancelOnError: cancelOnError,
      onDone: onDone,
      onError: onError,
    );
    _listeners.putIfAbsent(eventName, () => listener);
    return this;
  }

  MethodCall buildMethodCall(String method, [dynamic arguments]) {
    MethodCall call = MethodCall(method, arguments);
    return call;
  }

  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) {
    final call = buildMethodCall(method, arguments);
    return productMethodChannel.invokeMethod(call.method, call.arguments);
  }

  setProductMethodChannel(Future<dynamic> Function(MethodCall)? handler) {
    productMethodChannel.setMethodCallHandler(handler ??
        (call) {
          return productMethodChannel.invokeMethod(call.method, call.arguments);
        });
  }

  _handleProductChangesListener(dynamic arguments) {}

  StreamSubscription<dynamic> _initProductEventChannel(
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return productEventChannel.receiveBroadcastStream().listen(
          onData ??
              (arguments) {
                _handleProductChangesListener(arguments);
              },
          cancelOnError: cancelOnError,
          onDone: onDone,
          onError: onError,
        );
  }
}
