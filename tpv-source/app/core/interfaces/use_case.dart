// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/config/errors/errors.dart';

class NoParametizable extends Equatable {
  NoParametizable();

  @override
  List<Object> get props => [];
}

class Parametizable extends Equatable {
  Parametizable();

  @override
  List<Object> get props => [];

  bool isValid() {
    return true;
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

/*
generic abstraction for all usecases

generic attribute Type is for referency any entity on features

generic attribute Params is for referency any of this classes:

   NoParametizable: for all usecase implementation that not need any params for execute it.

   Parametizable: for all usecase implementation that need at lease one param for execute it.
*/

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params? params);
  Params? getParams();
  UseCase<Type, Params> setParams(Params params);
  UseCase<Type, Params> setParamsFromMap(Map params);
}
