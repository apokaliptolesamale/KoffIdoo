import 'package:equatable/equatable.dart';

abstract class BodyRequest<value> implements Equatable {
  final Map<String, value> bodyRequest = <String, value>{};

  BodyRequest();

  Object getBody() {
    return bodyRequest;
  }
}

class EmptyBodyRequest implements BodyRequest {
  @override
  Map<String, dynamic> get bodyRequest => {};

  @override
  Object getBody() {
    return bodyRequest;
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
