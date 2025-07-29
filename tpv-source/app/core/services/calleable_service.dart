// ignore_for_file: public_member_api_docs, sort_constructors_first

import '/app/core/interfaces/calleable.dart';
import '/app/core/services/logger_service.dart';

mixin CalleableService implements Calleable {
  Map<String, Function> functions = {};

  @override
  int get hashCode;

  @override
  bool operator ==(other);

  @override
  invoke(
    String memberName,
    List<dynamic>? positionalArguments, [
    Map<Symbol, dynamic>? namedArguments,
  ]) {
    final func =
        functions.containsKey(memberName) ? functions[memberName] : null;
    return Function.apply(
        func ??
            () {
              return null;
            },
        positionalArguments,
        namedArguments);
  }

  @override
  noSuchMethod(Invocation invocation) {
    error("Error en la invocación del método:${invocation.memberName}");
    super.noSuchMethod(invocation); // Will throw.
  }
}
