import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/shared/shared.dart';

class KeyValueStorageserviceImpl extends KeyValueStorageservice {
  Future<SharedPreferences> getSharePrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharePrefs();
    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      case bool:
        return prefs.getBool(key) as T?;
      case Map:
        return prefs.getString(key) as T?;
      default:
        throw UnimplementedError(
            'Get not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharePrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharePrefs();
    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
      case bool:
        prefs.setBool(key, value as bool);
      case Map:
        prefs.setString(key, json.encode(value));
        break;
      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<void> clearData() async {
    final prefs = await getSharePrefs();
    prefs.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    final prefs = await getSharePrefs();
    return prefs.containsKey(key);
  }
}
