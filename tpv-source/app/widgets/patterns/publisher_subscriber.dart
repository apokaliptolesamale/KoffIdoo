// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_function_declarations_over_variables, unused_field, override_on_non_overriding_member

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

String generateRandom({int? range}) {
  return (Random().nextDouble() * (range ?? 100)).toString();
}

class CustomWidgetsBindingObserver<Observer> extends WidgetsBindingObserver
    with SubscriberMixinImpl<Observer>, PublisherMixinImpl<Observer> {
  static final CustomWidgetsBindingObserver instance =
      CustomWidgetsBindingObserver._internal();
  CustomWidgetsBindingObserver._internal() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  // TODO: implement getSubscriptionsFunction
  Map<String, List<void Function(Publisher<Subscriber<Observer>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;
  void add() => addObserver(this);

  void addObserver(WidgetsBindingObserver observer) =>
      WidgetsBinding.instance.addObserver(observer);

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    fireEvent("onWindowResize", {
      "change": true,
    });
  }

  void remove() => removeObserver(this);

  void removeObserver(WidgetsBindingObserver observer) =>
      WidgetsBinding.instance.removeObserver(observer);
}

abstract class Publisher<S extends Subscriber> {
  List<S> subscribers = [];
  fireEvent(String eventName, Map<String, dynamic> args);
  Map<String, dynamic> getFiredArgs();
  notifySubscribers(String? eventName);
  subscribe(S newSubscriber);
  unsubscribe(S newSubscriber);
}

mixin PublisherMixinImpl<Observer> implements Publisher<Subscriber<Observer>> {
  @override
  List<Subscriber<Observer>> subscribers = [];

  @override
  final Map<String, dynamic> _firedArgs = {};

  @override
  fireEvent(String eventName, Map<String, dynamic> args) {
    final asSubscriber = (this as Subscriber<Observer>);
    _firedArgs.addAll(args);
    final subscribersList =
        subscribers.where((element) => element != this).toList();
    _firedArgs.update("scope", (value) => this, ifAbsent: () => true);
    _firedArgs.update("subscribers", (value) => subscribersList,
        ifAbsent: () => subscribersList);
    subscribers.forEach((element) {
      //
      if (element.subscriptionsFunction.containsKey(eventName)) {
        if (asSubscriber.subscriptionsFunction.isNotEmpty) {
          final list = asSubscriber.subscriptionsFunction[eventName]!;
          for (var i = 0; i < list.length; i++) {
            _firedArgs.update(eventName, (value) => eventName,
                ifAbsent: () => true);
          }
        }
        element.updateSubscriber(eventName, this);
      }
    });
  }

  @override
  Map<String, dynamic> getFiredArgs() => _firedArgs;

  bool isSubscribed(Subscriber<Observer> subscriber) {
    return subscribers.contains(subscriber);
  }

  @override
  notifySubscribers(String? eventName) {
    subscribers.forEach((element) {
      element.updateSubscriber(eventName, this);
    });
  }

  @override
  subscribe(Subscriber<Observer> subscriber) {
    if (!isSubscribed(subscriber)) {
      subscribers.add(subscriber);
    }
  }

  @override
  unsubscribe(Subscriber<Observer> newSubscriber) {
    if (subscribers.contains(newSubscriber)) {
      subscribers.remove(newSubscriber);
    }
  }
}

abstract class Subscriber<Observer> {
  final id = generateRandom(range: 9999999);
  final Map<String, StreamController<Publisher<Subscriber<Observer>>>>
      observerStreamControllers = {};
  final Map<String, List<StreamSubscription>> subscriptions = {};

  final Map<String, List<void Function(Publisher<Subscriber<Observer>> event)>>
      subscriptionsFunction = {};

  String get getId => id;

  Map<String, List<void Function(Publisher<Subscriber<Observer>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;

  closeSubscriptions();
  List<void Function(Publisher<Subscriber<Observer>> event)>
      getFunctionsByEventName(String eventName);
  Stream<Publisher<Subscriber<Observer>>> observerStream(String eventName) =>
      observerStreamControllers[eventName]!.stream;

  on(String eventName, void Function(Publisher<Subscriber<Observer>> even) func,
      Subscriber<Observer> scope);
  updateSubscriber(String? eventName, Publisher<Subscriber<Observer>> event);
}

mixin SubscriberMixinImpl<Observer>
    implements Subscriber<Observer>, PublisherMixinImpl<Observer> {
  Function() onUpdate = () {};

  Map<String, void Function(Publisher<Subscriber<Observer>> event)> listeners =
      {};

  @override
  final id = generateRandom(range: 9999999);

  @override
  final Map<String, StreamController<Publisher<Subscriber<Observer>>>>
      observerStreamControllers = {};

  @override
  final Map<String, List<StreamSubscription>> subscriptions = {};

  @override
  final Map<String, List<void Function(Publisher<Subscriber<Observer>> event)>>
      subscriptionsFunction = {};

  @override
  String get getId => id;

  applyListeners() {
    if (listeners.isNotEmpty) {
      listeners.forEach((key, value) {
        on(key, value, this);
      });
    }
  }

  @override
  closeSubscriptions() {
    subscriptions.forEach((key, subscriptionEventList) {
      subscriptionEventList.forEach((subscription) {
        subscription.cancel();
      });
    });
    subscriptions.clear();
  }

  @override
  List<void Function(Publisher<Subscriber<Observer>> event)>
      getFunctionsByEventName(String eventName) {
    if (subscriptionsFunction.isNotEmpty &&
        subscriptionsFunction.containsKey(eventName)) {
      return subscriptionsFunction[eventName] ?? [];
    }
    return [];
  }

  @override
  Stream<Publisher<Subscriber<Observer>>> observerStream(String eventName) =>
      observerStreamControllers[eventName]!.stream;

  @override
  on(
      String eventName,
      void Function(Publisher<Subscriber<Observer>> event) func,
      Subscriber<Observer> scope) {
    if (!subscriptions.containsKey(eventName)) {
      observerStreamControllers.putIfAbsent(
          eventName, () => StreamController.broadcast());
      subscriptionsFunction.putIfAbsent(eventName, () => [func]);
      subscriptions.putIfAbsent(
          eventName, () => [observerStream(eventName).listen(func)]);
    } else {
      subscriptionsFunction[eventName]!.add(func);
      subscriptions[eventName]!.add(observerStream(eventName).listen(func));
    }
    subscribe(this);
  }

  @override
  updateSubscriber(String? eventName, Publisher<Subscriber<Observer>> event) {
    if (eventName != null && observerStreamControllers.containsKey(eventName)) {
      observerStreamControllers[eventName]!.add(event);
    }
  }
}
