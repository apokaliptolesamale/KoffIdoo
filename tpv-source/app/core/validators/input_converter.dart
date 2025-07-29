// ignore_for_file: overridden_fields

import 'package:dartz/dartz.dart';

import '../config/errors/errors.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String? str) {
    try {
      final integer = int.parse(str!);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure(message: 'Error de entrada de datos.'));
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  final String message;
  InvalidInputFailure({required this.message}) : super();

  @override
  List<Object?> get props => [message];

  @override
  String getMessage() => message;
}
