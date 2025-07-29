import '../../../app/core/services/logger_service.dart';

class InvokeableClass {
  final dynamic objectClass;
  late Type type;

  InvokeableClass(this.objectClass) {
    type = objectClass.runtimeType;
  }

  Future<dynamic> call(String method, Iterable<Object?>? positionalArguments,
      [Map<Symbol, Object?>? namedArguments]) async {
    bool exist =
        methodExists(method.toString(), positionalArguments, namedArguments);
    if (exist) {
      for (var i in objectClass) {
        log(objectClass[i]);
      }
      /*log(objectClass.objectClass);
      return Function.apply(objectClass[method], positionalArguments!.toList(),
          namedArguments ?? {});*/
      //inspect(objectClass);
      return objectClass[method];
    }
    return null;
  }

  dynamic invokeMethod(Object receiver, Symbol name,
          [List<Object?> args = const <Object>[],
          Map<Symbol, Object?> named = const <Symbol, Object>{}]) =>
      InvokeableClass(receiver)
          .noSuchMethod(Invocation.method(name, args, named));

  dynamic invokeOn(Object receiver, Invocation invocation) =>
      InvokeableClass(receiver).noSuchMethod(invocation);

  bool methodExists(String method, Iterable<Object?>? positionalArguments,
      [Map<Symbol, Object?>? namedArguments]) {
    return methodInvocation(method, positionalArguments, namedArguments)
        .isMethod;
  }

  Invocation methodInvocation(
      String method, Iterable<Object?>? positionalArguments,
      [Map<Symbol, Object?>? namedArguments]) {
    return Invocation.method(
        Symbol(method), positionalArguments, namedArguments);
  }

  bool propertyExists(String property) {
    final sym = Symbol(property);
    final Invocation inv = Invocation.getter(sym);
    return inv.isGetter;
  }
}
