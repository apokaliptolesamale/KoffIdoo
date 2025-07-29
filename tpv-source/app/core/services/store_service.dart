//import '/app/modules/operation/widgets/layout_exporting.dart';

import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';

class Store<KeyType, ValueType> {
  late Map<KeyType, ValueType> _mapFields;
  late dynamic _key;
  late Type _keyType;
  late Type _valueType;
  Store({
    dynamic key,
    Map<KeyType, ValueType> mapFields = const {},
  }) {
    _mapFields = mapFields;
    _key = key;
  }
  dynamic get getKey => _key;
  Map<KeyType, ValueType> get getMapFields => _mapFields;
  bool get isEmpty => _mapFields.isEmpty;

  bool get isNotEmpty => _mapFields.isNotEmpty;

  Store<KeyType, ValueType> add(KeyType keyValue, ValueType value) {
    //
    _keyType = keyValue.runtimeType;
    _valueType = value.runtimeType;
    _mapFields.putIfAbsent(keyValue, () => value);
    return this;
  }

  Store<KeyType, ValueType> flush() {
    _mapFields = {};
    return this;
  }

  Store<KeyType, ValueType> from(Map data) {
    //
    data.forEach((key, value) {
      set(key, value);
    });
    return this;
  }

  ValueType? get(KeyType keyValue, ValueType? defaultValue) {
    return _mapFields.isNotEmpty &&
            _mapFields.containsKey(keyValue) &&
            _mapFields[keyValue] is ValueType
        ? _mapFields[keyValue]!
        : defaultValue;
  }

  Type getKeyType() => _keyType;

  T getNotValueOn<T>(dynamic keyValue, T defaultValue) {
    final withKey = hasKey(keyValue);
    if (withKey && _mapFields[keyValue] != null) return defaultValue;
    return _mapFields[keyValue] != null && _mapFields[keyValue] is T
        ? _mapFields[keyValue] as T
        : defaultValue;
  }

  T getValueOn<T>(dynamic keyValue, T defaultValue) => hasKey(keyValue) &&
          _mapFields[keyValue] != null &&
          _mapFields[keyValue].toString().isNotEmpty
      ? _mapFields[keyValue] as T
      : defaultValue;

  Type getValueType() => _valueType;

  bool hasKey(dynamic keyValue) =>
      keyValue != null &&
      _mapFields.isNotEmpty &&
      _mapFields.containsKey(keyValue);

  bool hasValueOn(dynamic keyValue) =>
      hasKey(keyValue) &&
      _mapFields[keyValue] != null &&
      _mapFields[keyValue].toString().isNotEmpty;

  Store<KeyType, ValueType> remove(KeyType keyValue) {
    if (hasKey(keyValue)) {
      _mapFields.remove(keyValue);
    }
    return this;
  }

  Store set(KeyType keyValue, ValueType value) {
    _mapFields[keyValue] = value;
    return this;
  }
}

class StoreService {
  static final StoreService _instance = StoreService._internal();
  final Map<dynamic, Store> _stores = {};
  factory StoreService() => _instance;

  StoreService._internal() {
    Get.lazyPut<StoreService>(() => this);
  }
  Map asMap(List<String> storeKeys) {
    Map map = {};
    storeKeys.map((e) {
      if (existStore(e)) {
        Store st = getStore(e);
        map.addAll(st._mapFields);
      }
      return map;
    }).toList();
    return map;
  }

  Store<KeyType, ValueType> createStore<KeyType, ValueType>(dynamic keyStore) {
    if (!existStore(keyStore)) {
      final store = Store<KeyType, ValueType>(key: keyStore, mapFields: {});
      _stores.putIfAbsent(keyStore, () => store);
      return store;
    }
    return _stores[keyStore]! as Store<KeyType, ValueType>;
  }

  bool existStore(dynamic keyStore) =>
      _stores.isNotEmpty && _stores.containsKey(keyStore);

  StoreService flush<KeyType, ValueType>(dynamic keyStore) {
    if (existStore(keyStore)) {
      (_stores[keyStore]! as Store<KeyType, ValueType>).flush();
    }
    return this;
  }

  ValueType? get<KeyType, ValueType>(
    dynamic keyStore,
    KeyType keyValue, {
    ValueType? value,
  }) {
    if (existStore(keyStore)) {
      return (_stores[keyStore]! as Store<KeyType, ValueType>)
          .get(keyValue, value);
    }
    return createStore<KeyType, ValueType>(keyStore).get(keyValue, value);
  }

  Store<KeyType, ValueType> getStore<KeyType, ValueType>(dynamic key) {
    if (key is! String) {
      log("Tracear");
    }
    if (existStore(key)) {
      final store = _stores[key];
      return store as Store<KeyType, ValueType>;
    }
    return createStore<KeyType, ValueType>(key);
  }

  bool isValid(List<String> storeKeys, List<String> dataKeys) {
    Map map = asMap(storeKeys);
    for (final key in dataKeys) {
      if (!map.containsKey(key) || (map[key] == null && map[key] == '')) {
        // Si la llave no está presente en el mapa, retornamos falso.
        return false;
      }
    }
    // Si todas las llaves tienen valores no nulos y distintos de vacío, retornamos verdadero.
    return true;
  }

  StoreService set(dynamic store, dynamic key, dynamic value) {
    Store st = getStore(store);
    st.set(key, value);
    return this;
  }
}
