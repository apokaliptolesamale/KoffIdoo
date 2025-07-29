// ignore_for_file: must_be_immutable, overridden_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/interfaces/use_case.dart';
import '../../../app/core/services/logger_service.dart';
import '../field/custom_get_view.dart';

class CustomFutureBuilder<T> extends FutureBuilder<T> {
  @override
  Future<T>? future;
  @override
  AsyncWidgetBuilder<T> builder;
  @override
  T? initialData;
  BuildContext context;
  UseCase? usecase;

  _CustomFutureBuilderState<T>? _state;

  CustomFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    required this.context,
    this.usecase,
    this.initialData,
  }) : super(
          key: key,
          builder: builder,
          future: future,
          initialData: initialData,
        ) {
    _state = createState();
  }

  _CustomFutureBuilderState<T> get getState => _state ?? createState();

  @override
  _CustomFutureBuilderState<T> createState() =>
      _state = _CustomFutureBuilderState<T>();

  setBuilder(AsyncWidgetBuilder<T> newBuilder) {
    if (getState.mounted) {
      getState.setBuilder(newBuilder);
    }
  }

  setFuture(Future<T>? newFuture) {
    if (getState.mounted) {
      getState.setFuture(newFuture);
    }
  }

  setInitialData(T? newInitialData) {
    if (getState.mounted) {
      getState.setInitialData(newInitialData);
    }
  }

  setUseCase<View extends CustomView>(UseCase newUseCase) {
    usecase = newUseCase;
    View view = Get.find<View>();
    if (getState.mounted) {
      getState.setFuture(view.getFutureByUseCase<T>(usecase!));
      getState.setBuilder(view.getBuilderByUseCase<T>(usecase!));
      getState.setUseCase(usecase!);
    }
  }
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  Object? _activeCallbackIdentity;

  late AsyncSnapshot<T> _snapshot;

  late AsyncWidgetBuilder<T> localBuilder;

  Future<T>? localFuture;

  T? initialData;

  UseCase? localUseCase;

  @override
  Widget build(BuildContext context) {
    try {
      return widget.builder(context, _snapshot);
    } catch (e) {
      return Container();
    }
  }

  @override
  void didUpdateWidget(CustomFutureBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.future != widget.future) {
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _snapshot = _snapshot.inState(ConnectionState.none);
      }
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget._state = this;
    localUseCase = widget.usecase;
    localFuture = widget.future;
    localBuilder = widget.builder;
    _snapshot = widget.initialData == null
        ? AsyncSnapshot<T>.nothing()
        : AsyncSnapshot<T>.withData(
            ConnectionState.none, widget.initialData as T);
    _subscribe();
  }

  setBuilder(AsyncWidgetBuilder<T> newBuilder) {
    _unsubscribe();
    localBuilder = widget.builder = newBuilder;
    _subscribe();
  }

  setFuture(Future<T>? newFuture) {
    _unsubscribe();
    localFuture = widget.future = newFuture;
    _subscribe();
  }

  setInitialData(T? newInitialData) {
    _unsubscribe();
    initialData = widget.initialData = newInitialData;
    _subscribe();
  }

  setUseCase(UseCase newUseCase) {
    _unsubscribe();
    localUseCase = widget.usecase = newUseCase;
    _snapshot = widget.initialData == null
        ? AsyncSnapshot<T>.nothing()
        : AsyncSnapshot<T>.withData(
            ConnectionState.none, widget.initialData as T);
    _subscribe();
  }

  void _subscribe() {
    if (widget.future != null) {
      final Object callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      widget.future!.then<void>((T data) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
          });
        }
      }, onError: (Object error, StackTrace stackTrace) {
        log(stackTrace);
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withError(
                ConnectionState.done, error, stackTrace);
          });
        }
        assert(() {
          if (FutureBuilder.debugRethrowError) {
            Future<Object>.error(error, stackTrace);
          }
          return true;
        }());
      });
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
