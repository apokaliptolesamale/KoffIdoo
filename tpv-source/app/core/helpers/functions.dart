// ignore_for_file: non_constant_identifier_names, unnecessary_string_escapes

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '/app/core/interfaces/global_params.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/types/custom_types.dart';

GlobalParams gParams = GlobalParams.instance;

String base64String(Uint8List data) {
  return base64Encode(data);
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

emptyFunction() {}

Map<String, dynamic> entityToJson(Map<String, dynamic> json,
    {TestForMap? test}) {
  json.removeWhere(test ?? (key, value) => value == null);
  return json;
}

String generateNonce({
  int longitud = 16,
}) {
  final random = Random.secure();
  const caracteres =
      '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return String.fromCharCodes(Iterable.generate(longitud,
      (_) => caracteres.codeUnitAt(random.nextInt(caracteres.length))));
}

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

dynamic getKeyByValue(Map<dynamic, dynamic> map, dynamic value) {
  try {
    return map.keys.firstWhere((key) => map[key] == value);
  } catch (e) {
    return null;
  }
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

/// Retorna la plataforma de destino de la aplicación en tiempo de ejecución.
/// Si la plataforma no es compatible, se devuelve la plataforma `fuchsia`.
TargetPlatform getTargetPlatform() {
  late TargetPlatform targetPlatform;

  if (kIsWeb) {
    targetPlatform = TargetPlatform.fuchsia; // Web usa plataforma Fuchsia
  } else if (Platform.isAndroid) {
    targetPlatform = TargetPlatform.android;
  } else if (Platform.isIOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.macOS;
  } else if (Platform.isWindows) {
    targetPlatform = TargetPlatform.windows;
  } else if (Platform.isLinux) {
    targetPlatform = TargetPlatform.linux;
  } else {
    targetPlatform = TargetPlatform.fuchsia;
  }

  return targetPlatform;
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

Future<String> image2Base64(String url) async {
  // Carga la imagen desde tus assets
  ByteData imageData = await rootBundle.load(url);
  // Convierte la imagen a una cadena base64
  String base64Image = base64Url.encode(imageData.buffer.asUint8List());
  return Future.value(base64Image);
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

bool isJson(String jsonString) {
  final str =
      '^\s*(?:\{(?:\s*(?:(?:"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?)\s*:\s*(?:(?:"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?))\s*,)*\s*(?:"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?)\s*:\s*(?:(?:"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?))\s*)\}\s*\$|\s*(?:\[(?:\s*(?:(?:"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?)\s*,)*\s*(?:"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?)\s*)\]\s*)\s*\$';
  RegExp jsonRegExp = RegExp(
    RegExp.escape("r$str"),
    multiLine: true,
  );

  final match = jsonRegExp.hasMatch(jsonString);
  return match;
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

String queryStringFromMap(Map<String, dynamic> filters) {
  return Uri(
      queryParameters:
          filters.map((key, value) => MapEntry(key, value?.toString()))).query;
}

Future<String> readFileFromAssets(String path) async {
  return await rootBundle.loadString(path);
}

String? readFileSync(String path) {
  try {
    final file = File(path);
    return file.readAsStringSync();
  } catch (e) {
    return null;
  }
}

Future<String> readFromAssetsFile(String assetFilePath) async {
  // Obtiene el directorio temporal de la aplicación
  Directory tempDir = await getApplicationDocumentsDirectory();
  // Obtiene el archivo de los assets
  ByteData data = await rootBundle.load('${tempDir.path}/$assetFilePath');
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // Crea el archivo en el directorio temporal
  //File file = await File('${tempDir.path}/$assetFilePath').create(recursive: true);
  // Escribe los bytes en el archivo
  //await file.writeAsBytes(bytes);
  // Lee el archivo como una cadena de texto
  return utf8.decode(bytes);
}

String removeLast(String str) {
  return str.substring(0, str.length - 1);
}

bool startsWith(String text, Pattern pattern) {
  return text.startsWith(pattern);
}

String? TextFieldLengthValidator(value,
    {String? text = 'Por favor, introduzca un texto válido.'}) {
  if (value != null && value.length != 13) {
    return text;
  }
  return null;
}

tryCatch(Function fun) {
  try {
    return fun;
  } catch (e) {
    log(e);
  }
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

Future<void> writeToAssetsFile(String assetFilePath, String text) async {
// Obtiene el directorio temporal de la aplicación
  Directory tempDir = await getApplicationDocumentsDirectory();
  // Obtiene el archivo de los assets
  ByteData data = await rootBundle.load(assetFilePath);
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // Crea el archivo en el directorio temporal
  File file =
      await File('${tempDir.path}/$assetFilePath').create(recursive: true);
  // Escribe el texto en el archivo
  await file.writeAsString(text);
}
