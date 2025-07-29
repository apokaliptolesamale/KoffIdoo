// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/patterns/publisher_subscriber.dart';

class CustomState<T>
    with WidgetsBindingObserver, SubscriberMixinImpl<T>, PublisherMixinImpl<T> {
  T value;
  CustomState<T>? before;
  final List<CustomState<T>> targetStates;
  CustomState({
    required this.value,
    this.before,
    this.targetStates = const [],
  }) {
    on("change", (event) {
      //event.notifySubscribers("change");
    }, this);
    for (var element in targetStates) {
      element.subscribe(this);
    }
  }
  @override
  Map<String, List<void Function(Publisher<Subscriber<T>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;
  bool get isFinalState => targetStates.isEmpty;

  bool get isInitialState => before != null;

  bool moveToState(CustomState<T> state) {
    state.before = this;
    return true;
  }
}

class CustomStateMachine<T, S extends CustomState<T>> {
  S start;
  late S started;
  T? startOn;

  CustomStateMachine({
    required this.start,
    this.startOn,
  }) {
    if (startOn != null && startOn != start.value) {
      started = getByValue(start, startOn as T) ?? start;
    }
  }

  S? getByValue(S state, T value) {
    S? result;
    if (value == startOn) return result = state;
    for (var element in state.targetStates) {
      if (element.value == value) {
        return element as S;
      } else {
        result = getByValue(element as S, value);
      }
      if (result != null) {
        return result;
      }
    }
    return result;
  }

  bool moveToState(S state) {
    started.fireEvent(
        "change", {"target": state, "source": started, "machine": this});
    started = state;
    return true;
  }

  List<Either<S, T>> targetStatesOf({
    T? value,
    bool asState = true,
  }) {
    List<Either<S, T>> list = [];
    if (value == null) return list;

    final state = getByValue(start, value);
    if (state != null) {
      for (var element in state.targetStates) {
        list.add(asState ? Left(element as S) : Right(element.value));
      }
    }
    return list;
  }

  List<T> targetStatesValues({
    required T searchValue,
  }) {
    List<T> list = [];
    if (start.value == searchValue) {
      return start.targetStates.map((e) => e.value).toList();
    }
    final state = getByValue(start, searchValue);
    if (state != null) {
      for (var element in state.targetStates) {
        list.add(element.value);
      }
    }
    return list;
  }

  static CustomStateMachine<T, CustomState<T>> loadStateMachine<T>(
      {T? startOnValue}) {
    CustomState<T> entregado = CustomState(
      value: "Entregado" as T,
      targetStates: [],
    );

    CustomState<T> reembolso = CustomState(
      value: "Reembolso" as T,
      targetStates: [],
    );

    CustomState<T> entregaDomicilio = CustomState(
      value: "Entregado domicilio" as T,
      targetStates: [],
    );

    CustomState<T> transporting = CustomState(
      value: "Transportándose" as T,
      targetStates: [entregaDomicilio, reembolso],
    );

    CustomState<T> listoRecoger = CustomState(
      value: "Listo para recoger" as T,
      targetStates: [entregado, reembolso],
    );

    CustomState<T> entregaTransportista = CustomState(
      value: "Entregado a Transportista" as T,
      targetStates: [transporting, reembolso],
    );

    CustomState<T> listoEntregar = CustomState(
      value: "Listo para entregar" as T,
      targetStates: [entregaTransportista, reembolso],
    );

    CustomState<T> preparandose = CustomState(
      value: "Preparándose" as T,
      targetStates: [listoEntregar, listoRecoger, reembolso],
    );

    CustomState<T> pagoAceptado = CustomState(
      value: "Pago aceptado" as T,
      targetStates: [preparandose, reembolso],
    );

    final CustomStateMachine<T, CustomState<T>> machine = CustomStateMachine(
      start: pagoAceptado,
    );

    final tmp =
        machine.getByValue(pagoAceptado, startOnValue ?? machine.start.value);
    machine.started = tmp ?? machine.start;

    return machine;
  }
}
