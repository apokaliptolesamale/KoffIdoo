// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

String base64String(Uint8List data) {
  return base64Encode(data);
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

emptyFunction() {}

String generateRandom({int? range}) {
  return (Random().nextDouble() * (range ?? 100)).toString();
}

String getCurl(String url, Map<String, String> headers) {
  String curl = "curl -k -X GET \"$url\" ";
  headers.map((key, value) {
    curl += " -H  \"$key: $value\"";
    return MapEntry(key, value);
  });
  return curl;
}

String getShemaQueryFromMap(Map myMap) {
  return Uri(
      queryParameters:
          myMap.map((key, value) => MapEntry(key, value.toString()))).query;
}

String getStringFromBytes(ByteData data) {
  final buffer = data.buffer;
  var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  return utf8.decode(list);
}

String? getValueFromGetxArguments(String name) {
  if (Get.arguments != null &&
      Get.arguments is Map &&
      (Get.arguments as Map).containsKey(name)) {
    return (Get.arguments as Map)[name].toString();
  }
  return null;
}

String? getValueFromGlobalMap(String key) {
  Map map = Get.find();
  return map.isNotEmpty && map.containsKey(key) ? map[key] : null;
}

String idGenerator() => DateTime.now().microsecondsSinceEpoch.toString();

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

bool isUrlRemote(String path) {
  path = path.toLowerCase();
  RegExp remoteRegExp = RegExp(
    r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)|(mms)|(mmss)$',
    caseSensitive: true,
    multiLine: false,
  );
  return startsWith(path, remoteRegExp);
}

String? NotEmptyTextFieldValidator(value,
    {String? text = 'Por favor, introduzca un texto válido.'}) {
  if (value == null || value.isEmpty) {
    return text;
  }
  return null;
}

bool startsWith(String text, Pattern pattern) {
  return text.startsWith(pattern);
}

T? waitFor<T>(Future<T> future, {Duration? timeout}) {
  T? result;
  bool futureCompleted = false;
  Object? error;
  StackTrace? stacktrace;
  future.then((r) {
    futureCompleted = true;
    result = r;
  }, onError: (e, st) {
    error = e;
    stacktrace = st;
  });

  Stopwatch? s;
  if (timeout != null) {
    s = Stopwatch()..start();
  }
  Timer.run(() {}); // Enusre there is at least one message.
  while (!futureCompleted && (error == null)) {
    Duration remaining = Duration.zero;
    if (timeout != null) {
      if (s!.elapsed >= timeout) {
        throw TimeoutException("waitFor() timed out", timeout);
      }
      remaining = timeout - s.elapsed;
    }
    //TODO buscar lo que hace esto o la dependencia o implementación
    //_WaitForUtils.waitForEvent(timeout: remaining);
    remaining.toString();
  }
  if (timeout != null) {
    s!.stop();
  }
  Timer.run(() {}); // Ensure that previous calls to waitFor are woken up.

  if (error != null) {
    throw AsyncError(error!, stacktrace);
  }

  return result;
}
