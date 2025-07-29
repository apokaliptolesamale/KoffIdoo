// ignore_for_file: unnecessary_overrides, deprecated_member_use

import 'dart:io';
import 'dart:typed_data';

import 'package:file/src/interface/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../app/core/services/logger_service.dart';

// Custom Implementation of CacheManager
// by extending the BaseCacheManager abstract class
class CustomCacheManager extends CacheManager {
  static const key = "customCache";

  static final CustomCacheManager _instance =
      !Get.isRegistered() ? CustomCacheManager._() : Get.find();

  // singleton implementation
  // for the custom cache manager
  factory CustomCacheManager() => _instance;

  // pass the default setting values to the base class
  // link the custom handler to handle HTTP calls
  // via the custom cache manager
  CustomCacheManager._()
      : super(Config(
          key,
          stalePeriod: Duration(hours: 12),
          maxNrOfCacheObjects: 200,
          fileService: HttpFileService(),
          repo: JsonCacheInfoRepository(),
          //fileFetcher: _myHttpGetter,
        ));
  @override
  Future<void> dispose() {
    return super.dispose();
  }

  @override
  Future<FileInfo> downloadFile(String url,
      {String? key, Map<String, String>? authHeaders, bool force = false}) {
    return super.downloadFile(url);
  }

  @override
  Future<void> emptyCache() {
    return super.emptyCache();
  }

  @override
  Stream<FileInfo> getFile(String url,
      {String? key, Map<String, String>? headers}) {
    return super.getFile(url, key: key, headers: headers);
  }

  @override
  Future<FileInfo?> getFileFromCache(String key,
      {bool ignoreMemCache = false}) {
    return super.getFileFromCache(key, ignoreMemCache: ignoreMemCache);
  }

  @override
  Future<FileInfo?> getFileFromMemory(String key) {
    return super.getFileFromMemory(key);
  }

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }

  @override
  Stream<FileResponse> getFileStream(String url,
      {String? key, Map<String, String>? headers, bool withProgress = false}) {
    return super.getFileStream(url,
        key: key, headers: headers, withProgress: withProgress);
  }

  @override
  Future<File> getSingleFile(String url,
      {String? key, Map<String, String>? headers}) {
    return super.getSingleFile(url, key: key, headers: headers);
  }

  @override
  Future<File> putFile(String url, Uint8List fileBytes,
      {String? key,
      String? eTag,
      Duration maxAge = const Duration(days: 30),
      String fileExtension = 'file'}) {
    return super.putFile(url, fileBytes,
        key: key, eTag: eTag, maxAge: maxAge, fileExtension: fileExtension);
  }

  @override
  Future<File> putFileStream(String url, Stream<List<int>> source,
      {String? key,
      String? eTag,
      Duration maxAge = const Duration(days: 30),
      String fileExtension = 'file'}) {
    return super.putFileStream(url, source,
        key: key, eTag: eTag, maxAge: maxAge, fileExtension: fileExtension);
  }

  @override
  Future<void> removeFile(String key) {
    return super.removeFile(key);
  }

  /*: super(
            key,
            maxAgeCacheObject: Duration(hours: 12),
            maxNrOfCacheObjects: 200,
            fileFetcher: _myHttpGetter);*/

  static Future<http.Response> getData(
    String url, {
    Map<String, String>? headers = const {},
  }) async {
    var file =
        await CustomCacheManager._instance.getSingleFile(url, headers: headers);
    if (await file.exists()) {
      var res = await file.readAsString();
      return http.Response(res, 200);
    }
    return http.Response("", 404);
  }

  static Future<String?> getHttpContent(String url,
      {Map<String, String>? headers}) async {
    try {
      var res = await http.get(Uri.parse(url), headers: headers);
      return Future.value(res.body);
    } catch (e) {
      log(e);
      return Future.value(null);
    }
  }

  static Future<FileFetcherResponse?> httpGetter(String url,
      {Map<String, String>? headers}) async {
    HttpFileFetcherResponse? response;
    try {
      var res = await http.get(Uri.parse(url), headers: headers);
      res.headers.addAll({'cache-control': 'private, max-age=120'});
      response = HttpFileFetcherResponse(res);
    } on SocketException {
      log('No internet connection');
    }
    return response;
  }
}
