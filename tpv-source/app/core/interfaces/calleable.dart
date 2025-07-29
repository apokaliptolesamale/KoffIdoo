abstract class Calleable {
  @override
  int get hashCode;
  @override
  bool operator ==(other);

  invoke(
    String memberName,
    List<dynamic>? positionalArguments, [
    Map<Symbol, dynamic>? namedArguments,
  ]);
}
