// ignore_for_file: overridden_fields

import '../../../app/core/services/logger_service.dart';
import '../../../app/widgets/patterns/publisher_subscriber.dart';
import '../../../app/widgets/utils/encapsulate.dart';

class SingleStore<Key, LeftValue, RigthValue>
    extends Encapsulate<Key, LeftValue, RigthValue>
    with SubscriberMixinImpl<LeftValue>, PublisherMixinImpl<LeftValue> {
  static final SingleStore getInstance = SingleStore._internal(data: {});

  @override
  Map<String, List<void Function(Publisher<Subscriber<LeftValue>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;

  @override
  final Map<Key, Map<LeftValue, RigthValue>> data;

  SingleStore({required this.data}) : super(data: data);

  factory SingleStore.from(Key key, LeftValue left, RigthValue rigth) {
    final capsule = SingleStore(
      data: {
        key: {left: rigth}
      },
    );
    return capsule;
  }

  SingleStore._internal({required this.data}) {
    log("Iniciando instancia de Configuración de SingleStore Global.");
  }
  @override
  bool get isEmpty => data.isEmpty;

  @override
  bool get isNotEmpty => data.isNotEmpty;

  @override
  SingleStore add(Key key, LeftValue left, RigthValue rigth) {
    data.putIfAbsent(key, () => {left: rigth});
    fireEvent("add", {"key": key, "left": left, "rigth": rigth, "scope": this});
    return this;
  }

  @override
  LeftValue? getLeft(Key key) =>
      isNotEmpty && hasKey(key) ? data[key]!.keys.elementAt(0) : null;

  @override
  RigthValue? getRigth(Key key) =>
      isNotEmpty && hasKey(key) ? data[key]!.values.elementAt(0) : null;
  @override
  bool hasKey(Key key) {
    return data.containsKey(key);
  }

  @override
  SingleStore remove(Key key) {
    data.remove(key);
    fireEvent("remove", {"key": key, "scope": this});
    return this;
  }

  @override
  SingleStore replace(Key key, LeftValue left, RigthValue rigth) {
    data.update(key, (value) => {left: rigth});
    fireEvent(
        "replace", {"key": key, "left": left, "rigth": rigth, "scope": this});
    return this;
  }
}
