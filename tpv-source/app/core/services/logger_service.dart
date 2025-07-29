import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import '../config/app_config.dart';

error(Object message) => Logger.getInstance.error(message.toString());

info(Object message) => Logger.getInstance.info(message.toString());

log(Object message) => Logger.getInstance.log(message.toString());

masticado(Exception e) => Logger.getInstance.log(e.toString());

warning(Object message) => Logger.getInstance.warning(message.toString());

class Logger {
  static final Logger getInstance = Logger._internal();

  String? logLevel;
  Logger._internal();

  error(String message) {
    if (_isValidFor("error")) {
      dev.log("ERROR: $message");
    }
  }

  info(String message) {
    if (_isValidFor("info")) {
      dev.log("INFO: $message");
    }
  }

  init() {
    logLevel = ConfigApp.getInstance.logLevel ?? "ALL";
    log("Inicializando instancia de Logger con nivel:$logLevel");
  }

  log(String message) {
    if (_isValidFor("log")) {
      dev.log("LOG: $message");
    }
  }

  warning(String message) {
    if (_isValidFor("warning")) {
      dev.log("WARNING: $message");
    }
  }

  bool _isValidFor(String typeLog) {
    return kDebugMode &&
        logLevel != null &&
        (logLevel!.toLowerCase() == typeLog.toLowerCase() ||
            logLevel!.toLowerCase() == "all");
  }
}

enum LogLevels { all, none, log, info, error, warning }
