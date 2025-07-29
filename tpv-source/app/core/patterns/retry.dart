import 'dart:async';

class Retry<T> {
  final FutureOr<T> Function() operation;
  final int maxAttempts;
  final Duration initialDelay;
  final double delayFactor;
  final Duration maxDelay;
  final Function(dynamic, StackTrace?) onError;

  Retry({
    required this.operation,
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.delayFactor = 2,
    this.maxDelay = const Duration(seconds: 30),
    this.onError = _defaultErrorHandler,
  });

  Future<T> execute() async {
    var attempts = 0;
    var delay = initialDelay;

    while (true) {
      try {
        // Ejecuta la operación y retorna su resultado si tiene éxito
        return await operation();
      } catch (e, stackTrace) {
        // Llama al manejador de errores para manejar la excepción
        onError(e, stackTrace);

        if (++attempts >= maxAttempts) {
          // Si se ha alcanzado el número máximo de intentos, reenvía la excepción original
          rethrow;
        }

        // Espera un tiempo de espera exponencialmente creciente antes de volver a intentar la operación
        await Future.delayed(delay);
        delay = _increaseDelay(delay);
      }
    }
  }

  Duration _increaseDelay(Duration delay) {
    final increasedDelay = delay * delayFactor;
    return increasedDelay < maxDelay ? increasedDelay : maxDelay;
  }

  static void _defaultErrorHandler(dynamic e, StackTrace? stackTrace) {}
}
