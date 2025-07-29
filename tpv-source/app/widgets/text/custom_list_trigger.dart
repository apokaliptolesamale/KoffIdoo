// ignore_for_file: must_be_immutable, overridden_fields

import 'package:flutter/material.dart';

import '../../widgets/botton/custom_icon_botton.dart';
import '../../widgets/patterns/publisher_subscriber.dart';
import '../field/custom_form_field.dart';

class CustomTriggerListFormField<T> extends StatelessWidget
    with WidgetsBindingObserver, SubscriberMixinImpl<T>, PublisherMixinImpl<T> {
  CustomFormField<T> dropDown;
  CustomOutlinedIconButton<T> botton;

  @override
  Map<String, void Function(Publisher<Subscriber<T>> event)> listeners;

  EdgeInsetsGeometry? margin;

  bool visibleTriggerBotton;

  CustomTriggerListFormField({
    Key? key,
    required this.botton,
    required this.dropDown,
    this.listeners = const {},
    this.margin,
    this.visibleTriggerBotton = true,
  }) : super(key: key) {
    if (dropDown is Subscriber<T>) {
      botton.subscribe(dropDown as Subscriber<T>);
    }
    applyListeners();
  }

  @override
  Map<String, List<void Function(Publisher<Subscriber<T>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;

  void addObserver(WidgetsBindingObserver observer) =>
      WidgetsBinding.instance.addObserver(observer);
  void autoObservation() => addObserver(this);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(child: dropDown),
          if (visibleTriggerBotton)
            Container(
              width: 50,
              child: botton,
            )
        ],
      ),
    );
  }

  String? getValue() => dropDown.getValue;

  void removeAutoObservation() => removeObserver(this);

  void removeObserver(WidgetsBindingObserver observer) =>
      WidgetsBinding.instance.removeObserver(observer);
}
