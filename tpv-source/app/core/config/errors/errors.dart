// ignore_for_file: must_be_immutable, overridden_fields

import 'package:equatable/equatable.dart';

import 'exceptions.dart';

class AuthenticationFailure extends Failure {
  @override
  final String message;
  AuthenticationFailure({required this.message}) : super([message]);
  @override
  List<Object?> get props => [message];

  @override
  String getMessage() => message;
}

class CacheFailure extends Failure {
  @override
  final String message;
  CacheFailure({required this.message}) : super([message]);
  @override
  List<Object?> get props => [message];
  @override
  String getMessage() => message;
}

class EmptyParamsFailure extends Failure {
  @override
  final String message;
  EmptyParamsFailure({
    required this.message,
  }) : super([message]);
  @override
  List<Object?> get props => [message];
  @override
  String getMessage() => message;
}

abstract class Failure extends Equatable {
  final String message = "";
  Failure([List properties = const <dynamic>[]]) : super();
  String getMessage();
}

class InvalidParamsFailure extends Failure {
  @override
  final String message;
  InvalidParamsFailure({required this.message}) : super([message]);
  @override
  List<Object?> get props => [message];
  @override
  String getMessage() => message;
}

class NetWorkFailure extends Failure {
  @override
  final String message;
  NetWorkFailure({required this.message}) : super([message]);
  @override
  List<Object?> get props => [message];
  @override
  String getMessage() => message;
}

class NulleableFailure extends Failure {
  @override
  final String message;
  NulleableFailure({required this.message}) : super([message]);
  @override
  List<Object?> get props => [message];

  @override
  String getMessage() => message;
}

//General Failures
class ServerFailure extends Failure {
  @override
  final String message;
  ServerFailure({required this.message}) : super([message]);

  //

  factory ServerFailure.fromException(Exception e) => ServerFailure(
      message: e is CustomException ? e.toString() : "Error desconocido...");

  @override
  List<Object?> get props => [message];

  @override
  String getMessage() => message;
}
