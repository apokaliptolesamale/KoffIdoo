//import '/app/modules/operation/widgets/layout_exporting.dart';

import '/app/core/services/logger_service.dart';

class FormFieldsStore {
  static final FormFieldsStore instance = FormFieldsStore._internal();

  final Map<dynamic, Store> _stores = {};

  FormFieldsStore._internal();

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

  FormFieldsStore flush<KeyType, ValueType>(dynamic keyStore) {
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

  FormFieldsStore set(dynamic store, dynamic key, dynamic value) {
    Store st = getStore(store);
    st.set(key, value);
    return this;
  }
}

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

  ValueType? get(KeyType keyValue, ValueType? defaultValue) {
    return _mapFields.isNotEmpty &&
            _mapFields.containsKey(keyValue) &&
            _mapFields[keyValue] is ValueType
        ? _mapFields[keyValue]!
        : defaultValue;
  }

  Type getKeyType() => _keyType;

  Type getValueType() => _valueType;

  bool hasKey(dynamic keyValue) =>
      _mapFields.isNotEmpty && _mapFields.containsKey(keyValue);

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
