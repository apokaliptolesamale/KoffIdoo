abstract class KeyValueStorageservice {
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);
  Future<void> clearData();
  Future<bool> containsKey(String key);
}
