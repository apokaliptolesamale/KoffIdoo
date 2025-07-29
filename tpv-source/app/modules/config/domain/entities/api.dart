class Api {
  final String name;
  final String schema;
  final String hostname;
  final String endpoint;
  final String version;

  Api({
    required this.name,
    required this.hostname,
    required this.schema,
    required this.endpoint,
    required this.version,
  });
}
