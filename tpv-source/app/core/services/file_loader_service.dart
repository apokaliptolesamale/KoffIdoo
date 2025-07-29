// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FileLoaderService {
  static final FileLoaderService _instance = FileLoaderService._internal();
  static FileLoaderService get getInstance => _instance;
  late String _cacheKey;

  late String _cacheSubDirectory;

  factory FileLoaderService({String? cacheKey, String? cacheSubDirectory}) {
    return _instance
      .._cacheKey = cacheKey ?? ''
      .._cacheSubDirectory = cacheSubDirectory ?? '';
  }

  FileLoaderService._internal();

  // Lee un archivo desde el directorio de assets
  Future<List<int>> loadFromAsset(String assetPath) async {
    return await rootBundle
        .load(assetPath)
        .then((data) => data.buffer.asUint8List());
  }

  // Lee un archivo desde una ruta absoluta del dispositivo
  Future<List<int>> loadFromFile(String filePath) async {
    return await File(filePath).readAsBytes();
  }

  // Lee un archivo desde un recurso externo vía HTTP, HTTPS, MMS, MMSS, FTP o FTPS
  Future<List<int>> loadFromUrl(String url) async {
    return await DefaultCacheManager()
        .getSingleFile(
          url,
          key: _cacheKey,
        )
        .then((file) => file.readAsBytes());
    /* FileInfo fileInfo = await DefaultCacheManager().downloadFile(url);
    String filePath = fileInfo.file.path;
    return await File(filePath).readAsBytes();*/
  }

  Uint8List toUint8List(List<int> intList) => Uint8List.fromList(intList);
}
