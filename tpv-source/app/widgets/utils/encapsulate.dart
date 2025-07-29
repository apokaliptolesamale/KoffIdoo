class Encapsulate<Key, LeftValue, RigthValue> {
  final Map<Key, Map<LeftValue, RigthValue>> data;

  Encapsulate({
    this.data = const {},
  });

  factory Encapsulate.from(Key key, LeftValue left, RigthValue rigth) {
    final capsule = Encapsulate(
      data: {
        key: {left: rigth}
      },
    );
    return capsule;
  }
  bool get isEmpty => data.isEmpty;

  bool get isNotEmpty => data.isNotEmpty;

  Encapsulate add(Key key, LeftValue left, RigthValue rigth) {
    data.putIfAbsent(key, () => {left: rigth});
    return this;
  }

  LeftValue? getLeft(Key key) =>
      isNotEmpty && hasKey(key) ? data[key]!.keys.elementAt(0) : null;

  RigthValue? getRigth(Key key) =>
      isNotEmpty && hasKey(key) ? data[key]!.values.elementAt(0) : null;
  bool hasKey(Key key) {
    return data.containsKey(key);
  }

  Encapsulate remove(Key key) {
    data.remove(key);
    return this;
  }

  Encapsulate replace(Key key, LeftValue left, RigthValue rigth) {
    data.update(key, (value) => {left: rigth});
    return this;
  }
}
