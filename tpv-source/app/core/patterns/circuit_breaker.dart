import 'dart:async';

class CircuitBreaker<T> {
  final FutureOr<T> Function() operation;
  final Duration timeoutDuration;
  final int maxFailures;
  final int cooldownTime;
  final Function(dynamic, StackTrace?) onError;

  CircuitState _state = CircuitState.closed;
  Timer? _timer;
  int _failures = 0;

  CircuitBreaker({
    required this.operation,
    this.timeoutDuration = const Duration(seconds: 5),
    this.maxFailures = 3,
    this.cooldownTime = 10,
    this.onError = _defaultErrorHandler,
  });

  Future<T> execute() async {
    if (_state == CircuitState.open) {
      throw Exception('Circuit is open');
    }

    try {
      _state = CircuitState.closed;

      final result = await _runOperationWithTimeout();

      _failures = 0;
      _closeCircuit();

      return result;
    } catch (e, stackTrace) {
      _failures++;

      if (_failures >= maxFailures) {
        _tripCircuit();
      }

      onError(e, stackTrace);

      rethrow;
    }
  }

  void _closeCircuit() {
    _state = CircuitState.halfOpen;
    _failures = 0;
    _timer = null;
  }

  Future<T> _runOperationWithTimeout() async {
    try {
      return await operation();
    } on TimeoutException catch (_) {
      if (_state == CircuitState.closed) {
        _tripCircuit();
      }

      rethrow;
    }
  }

  Future<T> _runOperationWithTimeoutAndRetry() async {
    while (true) {
      try {
        return await _runOperationWithTimeout();
      } on TimeoutException catch (_) {
        if (_state == CircuitState.closed) {
          _tripCircuit();
        }

        await Future.delayed(Duration(seconds: cooldownTime));
      }
    }
  }

  void _tripCircuit() {
    _state = CircuitState.open;
    _timer = Timer(Duration(seconds: cooldownTime), _closeCircuit);
  }

  static void _defaultErrorHandler(dynamic e, StackTrace? stackTrace) {}
}

enum CircuitState {
  closed,
  open,
  halfOpen,
}
