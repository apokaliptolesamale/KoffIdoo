// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../app/core/services/logger_service.dart';

class LocalSecureStorage {
  static final LocalSecureStorage storage = LocalSecureStorage._internal();
  late FlutterSecureStorage _secureStorage;

  Map<String, dynamic> _storage = {};

  LocalSecureStorage._internal() {
    _secureStorage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<FlutterSecureStorage> configureStorage() async {
    final storage = LocalSecureStorage.storage;
    _storage = await storage._secureStorage.readAll();

    return Future.value(storage._secureStorage);
  }

  Future<void> delete(String key) async {
    _storage.remove(key);
    return await _secureStorage.delete(key: key);
  }

  void deleteAll() async {
    await _secureStorage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    _readAll();
    _storage.clear();
  }

  Future<bool> existsOnSecureStorage(String key) =>
      _secureStorage.containsKey(key: key);

  dynamic get(String key, dynamic defaultValue) {
    if (_storage.containsKey(key)) return _storage[key];
    return defaultValue;
  }

  FlutterSecureStorage getSecureStore() => _secureStorage;

  bool hasData(String key) {
    return _storage.containsKey(key);
  }

  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<dynamic> readDecoded(String key) async {
    final readed = await _secureStorage.read(key: key);
    return readed != null ? json.decode(readed) : null;
  }

  removeWhere(bool Function(String, dynamic) test) {
    _storage.removeWhere(test);
  }

  removeWhereKeyContains(String str) {
    List<String> keys = [];
    _storage.removeWhere((key, value) {
      final ok = key.contains(str);
      ok ? keys.add(key) : false;
      return ok;
    });
    if (keys.isNotEmpty) {
      keys.forEach((element) async {
        if (await _secureStorage.containsKey(key: element)) {
          await _secureStorage.delete(key: element);
        }
      });
    }
  }

  removeWhereKeyEndWith(String str) {
    List<String> keys = [];
    _storage.removeWhere((key, value) {
      final ok = key.endsWith(str);
      ok ? keys.add(key) : false;
      return ok;
    });
    if (keys.isNotEmpty) {
      keys.forEach((element) async {
        if (await _secureStorage.containsKey(key: element)) {
          await _secureStorage.delete(key: element);
        }
      });
    }
  }

  removeWhereKeyStartWith(String str) {
    List<String> keys = [];
    _storage.removeWhere((key, value) {
      final ok = key.startsWith(str);
      ok ? keys.add(key) : false;
      return ok;
    });
    if (keys.isNotEmpty) {
      keys.forEach((element) async {
        if (await _secureStorage.containsKey(key: element)) {
          await _secureStorage.delete(key: element);
        }
      });
    }
  }

  Future<void> write(String key, String value) async {
    if (value.isNotEmpty) {
      _storage[key] = value;
      await _secureStorage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
    }
  }

  Future<bool> writeEncoded(String key, dynamic value) async {
    if (value.isNotEmpty) {
      log("Encoding value for key=$key on LocalSecureStorage...");
      _storage[key] = value;
      await _secureStorage.write(
        key: key,
        value: json.encode(value),
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
      return Future.value(true);
    }
    return Future.value(false);
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _getIOSOptions() => IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

  Future<Map<String, String>> _readAll() async {
    return await _secureStorage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }
}
