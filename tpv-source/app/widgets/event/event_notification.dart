import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventNotification extends Notification {
  const EventNotification();
}

class EventNotifier extends SingleChildRenderObjectWidget {
  EventNotifier({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          child: EventStatus(child: child),
        );
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _EventChangedWithCallback(
      onEventChangedCallback: () {
        const EventNotification().dispatch(context);
      },
    );
  }

  static EventStatus of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<EventStatus>()!;
}

class EventStatus extends InheritedWidget {
  final StreamController<dynamic> _statusController =
      StreamController<dynamic>();
  final Map<dynamic, StreamSubscription> _subscriptions = {};

  EventStatus({
    Widget? child,
  }) : super(
          child: child ?? Container(),
        );
  StreamController<dynamic> get getStatusController => _statusController;

  StreamSubscription addScription(
    dynamic key,
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    if (_subscriptions.containsKey(key)) return _subscriptions[key]!;

    StreamSubscription last = _statusController.stream.listen(
      onData,
      cancelOnError: cancelOnError,
      onDone: onDone,
      onError: onError,
    );
    _subscriptions[key] = last;
    return last;
  }

  Future<dynamic> close() => _statusController.close();

  StreamSubscription createScription(
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _statusController.stream.listen(
      onData,
      cancelOnError: cancelOnError,
      onDone: onDone,
      onError: onError,
    );
  }

  EventStatus fire(dynamic data) {
    _statusController.add(data);
    return this;
  }

  bool hasKey(dynamic key) {
    return _subscriptions.containsKey(key);
  }

  void stopScription(dynamic key) {
    if (hasKey(key)) {
      StreamSubscription<dynamic> subscription = _subscriptions[key]!;
      subscription.cancel();
      _subscriptions.removeWhere((key1, value) => key1 == key);
    }
  }

  @override
  bool updateShouldNotify(oldWidget) => true;
  static EventStatus of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<EventStatus>()!;
}

class _EventChangedWithCallback extends RenderProxyBox {
  // There's a 1:1 relationship between the _RenderSizeChangedWithCallback and
  // the `context` that is captured by the closure created by createRenderObject
  // above to assign to onLayoutChangedCallback, and thus we know that the
  // onLayoutChangedCallback will never change nor need to change.

  final VoidCallback onEventChangedCallback;

  Size? _oldSize;

  Object? _state;

  Object? _oldState;
  _EventChangedWithCallback({
    RenderBox? child,
    required this.onEventChangedCallback,
  }) : super(child);

  @override
  void performLayout() {
    super.performLayout();
    // Don't send the initial notification, or this will be SizeObserver all
    // over again!
    if ((_oldSize != null && size != _oldSize) ||
        (_oldState != null && _state != _oldState)) {
      _state = _oldState;
      _oldState = null;
      onEventChangedCallback();
    }
    _oldSize = size;
    _oldState = _state;
  }
}
