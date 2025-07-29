// ignore_for_file: must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';

import '../../core/patterns/observer.dart';
import '../patterns/publisher_subscriber.dart';

class CustomWidgetImpl extends Widget
    with SubscriberMixinImpl
    implements CustomWidgetInterface {
  @override
  CustomWidgetInterface? container;

  final Map<String, dynamic> _firedArgs = {};

  @override
  List<Subscriber> subscribers = [];

  CustomWidgetImpl({
    Key? key,
  });

  @override
  Map<String, List<void Function(Publisher<Subscriber> event)>>
      get getSubscriptionsFunction => throw UnimplementedError();

  @override
  Element createElement() {
    return StatelessElement(Container());
  }

  @override
  fireEvent(String eventName, Map<String, dynamic> args) {
    final asSubscriber = (this as Subscriber<Observer>);
    _firedArgs.addAll(args);
    final subscribersList =
        subscribers.where((element) => element != this).toList();
    _firedArgs.update("scope", (value) => this, ifAbsent: () => true);
    _firedArgs.update("subscribers", (value) => subscribersList,
        ifAbsent: () => subscribersList);
    for (var element in subscribers) {
      //
      if (element.getSubscriptionsFunction.containsKey(eventName)) {
        if (asSubscriber.getSubscriptionsFunction.isNotEmpty) {
          final list = asSubscriber.getSubscriptionsFunction[eventName]!;
          for (var i = 0; i < list.length; i++) {
            _firedArgs.update(eventName, (value) => eventName,
                ifAbsent: () => true);
          }
        }
        element.updateSubscriber(eventName, this);
      }
    }
  }

  @override
  Map<String, dynamic> getFiredArgs() => _firedArgs;

  @override
  bool isSubscribed(Subscriber subscriber) {
    return subscribers.contains(subscriber);
  }

  @override
  notifySubscribers(String? eventName) {
    subscribers.forEach((element) {
      element.updateSubscriber(eventName, this);
    });
  }

  @override
  CustomWidgetInterface setContainer(CustomWidgetInterface container) {
    this.container = container;
    return this;
  }

  @override
  subscribe(Subscriber subscriber) {
    if (!isSubscribed(subscriber)) {
      subscribers.add(subscriber);
    }
  }

  @override
  unsubscribe(Subscriber newSubscriber) {
    if (subscribers.contains(newSubscriber)) {
      subscribers.remove(newSubscriber);
    }
  }
}

abstract class CustomWidgetInterface extends Widget {
  late CustomWidgetInterface? container;
  CustomWidgetInterface setContainer(CustomWidgetInterface container);
}
