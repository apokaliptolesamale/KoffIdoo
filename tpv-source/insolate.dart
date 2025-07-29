import '/app/core/services/store_service.dart';

Map<String, dynamic>? mappedFunctions =
    StoreService.instance.get("system", "functions", value: {
  "add": (int a, int b) => a + b,
});
//buscar funciones
Function findFunction(String functionName) {
  if (mappedFunctions != null && mappedFunctions!.containsKey(functionName)) {
    return mappedFunctions![functionName];
  }
  throw ArgumentError('Function not found: $functionName');
}
