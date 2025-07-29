import 'dart:isolate';

import '../../../insolate.dart';
import '../interfaces/module.dart';
import '../interfaces/resource.dart';

class ReflectionSource {
  ReflectionSource();

  Future<List<Module>> getModules() async {
    globalModules = globalModules.isEmpty
        ? (await loadFromAssets()).modules
        : globalModules;
    return Future.value(globalModules);
  }

  Future initAsync(Future<Resource> resource, Function(Resource) onValue) =>
      resource.then((value) => onValue);

  ReflectionSource initSync(Resource resource, Function(Resource) onValue) {
    onValue(resource);
    return this;
  }

  Future<dynamic> load(String functionName, List<dynamic> args) async {
    final receivePort = ReceivePort();
    calleable(List<dynamic> args) async {
      final SendPort port = args.elementAt(1);
      final funcArgs = args.elementAt(2);
      try {
        final function = Function.apply(findFunction(args.first), funcArgs);
        port.send(function);
      } catch (e) {}
    }

    final isolate = await Isolate.spawn(
        calleable, [functionName, receivePort.sendPort, args]);
    isolate.addOnExitListener(receivePort.sendPort);
    isolate.addErrorListener(receivePort.sendPort);
    final result = await receivePort.first;
    isolate.kill(priority: Isolate.immediate);
    return Future.value(result);
  }

  Future<Resource> loadFromAssets() => Resource.loadFromAssets();
}
