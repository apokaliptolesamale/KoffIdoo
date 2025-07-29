// ignore_for_file: unused_field, prefer_final_fields

import 'dart:async';
import 'dart:collection';

import 'package:get/get.dart';

import '../../../app/core/services/logger_service.dart';

typedef FutureCacheable<T> = Future<T> Function();

class ApiFutureQueue<FutureType> {
  final _apiQueue = FutureQueue<FutureType?>();

  void close() {
    _apiQueue.close();
  }

  Future<FutureType?> requestApi(
      String key, Future<FutureType?> Function() request) async {
    FutureType? tmp;
    while (_apiQueue.hasNext && (tmp = await _apiQueue.next) != null) {
      //tmp = await _apiQueue.next;
      // tmp = tmp.containsKey(key) ? tmp : null;
      log("${tmp.hashCode}");
    }

    final future = request();
    _apiQueue.add(future.then((result) {
      final map = <String, dynamic>{};
      map[key] = result;
      return result;
    }));
    return future;
  }
}

class FutureCache {
  static FutureCache instance =
      !Get.isRegistered() ? FutureCache._internal() : Get.find();
  // 1. variable para verificar si ya se está agregando una operación futura con la misma clave
  bool _isAdding = false;

  Map<String, Future<dynamic>> _futures = {};
  Map<String, FutureStates> _futureStates = {};

  FutureCache._internal() {
    log("Inicializando instancia de registro de Futures para tratamiento de concurrencias");
  }
  Future<FutureType?> add<FutureType>({
    required String key,
    required FutureCacheable<FutureType?> future,
  }) async {
    final response = _queve(
      key: key,
      future: future,
    );
    return response;
  }

  /*void dispose() {
    _apiFutureQueue.close();
  }
  Future<FutureType?> add<FutureType>({
    required String key,
    required FutureCacheable<FutureType?> future,
  }) async {
    if (!_isAdding && _futures.containsKey(key) && wasCompleted(key)) {
      final tmp = _futures[key] as Future<FutureType?>;
      _futures.remove(key);
      final result = await tmp;
      return Future.value(result);
    }
    _isAdding = true;

    try {
      final tmp = future();
      final result = await tmp;
      tmp.asStream().listen((event) {
        _futureStates[key] = FutureStates.process;
      });
      tmp.whenComplete(() {
        _futureStates[key] = FutureStates.finish;
        _futures.remove(key);
        _isAdding = false;
      });
      tmp.onError((e, stackTrace) {
        _futureStates[key] = FutureStates.error;
        _futures.remove(key);
        error(e.toString());
        error(stackTrace.toString());
        _isAdding = false;
        throw Exception("Error en la caché de la llamada.");
      });
      _futures[key] = tmp;
      return Future.value(result);
    } catch (e, stackTrace) {
      _futureStates[key] = FutureStates.error;
      _futures.remove(key);
      error(e.toString());
      error(stackTrace.toString());
      _isAdding = false;
      rethrow;
    }
  }*/

  FutureType? get<FutureType>(String key) {
    if (has(key)) {
      _futures[key]! as FutureType?;
    }
    return null;
  }

  bool has(String key) {
    return _futures.isNotEmpty &&
        _futures.containsKey(key) &&
        _futures[key] != null;
  }

  remove(String key) {
    if (_futures.containsKey(key)) _futures.remove(key);
  }

  bool wasCompleted(String key) {
    return _futureStates.containsKey(key) &&
        [FutureStates.error, FutureStates.finish].contains(_futureStates[key]);
  }

  Future<FutureType?> _queve<FutureType>({
    required String key,
    required FutureCacheable<FutureType?> future,
  }) async {
    final apiFutureQueue = ApiFutureQueue<FutureType?>();
    final response = apiFutureQueue.requestApi(key, () async {
      // Aquí se realiza la solicitud a la API para obtener la información del usuario con el userId dado
      if (!_futures.containsKey(key)) {
        final result = future();
        result.asStream().listen((event) {
          _futureStates[key] = FutureStates.process;
        });
        result.whenComplete(() {
          _futureStates[key] = FutureStates.finish;
          _futures.remove(key);
        });
        result.onError((e, stackTrace) {
          //TODO implementar la salida o notificación global en caso de no exista conexión.
          _futureStates[key] = FutureStates.error;
          _futures.remove(key);
          error(e.toString());
          error(stackTrace.toString());
          throw Exception("Error en la caché de la llamada.");
        });
        _futures[key] = result;
        //_futureStates[key] = FutureStates.finish;
        _futureStates.remove(key);
        //final res = await result;
        //log(res.toString());
        return result;
      }

      final result = _futures[key]! as Future<FutureType?>;
      _futures.remove(key);
      _futureStates.remove(key);
      //final res = await result;
      //log(res.toString());
      return result;
    });
    await response;
    apiFutureQueue.close();
    return response;
  }
}

//
class FutureQueue<T> {
  final _queue = Queue<_FutureItem<T>>();
  bool _isOpen = true;

  bool get hasNext => _queue.isNotEmpty;

  Future<T> get next => _queue.first.future;

  void add(Future<T> future) {
    final item = _FutureItem(future);
    if (_isOpen) {
      _queue.add(item);
      _processQueue();
    } else {
      item.completeError(StateError('Queue is closed.'));
    }
  }

  void close() {
    _isOpen = false;
    while (_queue.isNotEmpty) {
      _queue.removeFirst().completeError(StateError('Queue is closed.'));
    }
  }

  void _processQueue() {
    if (_queue.isEmpty) return;
    final item = _queue.first;
    item.future.then((_) {
      _queue.removeFirst();
      _processQueue();
    }, onError: (_) {
      _queue.removeFirst();
      _processQueue();
    });
  }
}

enum FutureStates { process, finish, error }

class _FutureItem<T> {
  final Completer<T> completer = Completer<T>();
  final Future<T> future;

  _FutureItem(this.future);

  void completeError(Object error) {
    completer.completeError(error);
  }
}
