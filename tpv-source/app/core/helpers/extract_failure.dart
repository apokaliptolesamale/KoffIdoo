import 'package:dartz/dartz.dart';

import '../../core/config/errors/errors.dart';

class FailureExtractor {
  final Left failureContainer;
  FailureExtractor({
    required this.failureContainer,
  });

  Failure getFailure() {
    return failureContainer.value;
  }

  String getMessage() {
    return getFailure().message;
  }

  static Failure failure(Left failureContainer) {
    return FailureExtractor(failureContainer: failureContainer).getFailure();
  }

  static String message(Left failureContainer) {
    return FailureExtractor.failure(failureContainer).message;
  }
}
