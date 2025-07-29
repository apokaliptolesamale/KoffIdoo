// ignore_for_file: overridden_fields

class Between<T extends List, Filter extends Map<String, T>>
    extends Where<T, Filter> {
  @override
  String key;
  @override
  T value;
  @override
  Where<T, Filter>? next;
  @override
  Where<T, Filter>? before;

  Between({
    required this.key,
    required this.value,
    this.before,
    this.next,
  }) : super(key: key, value: value, before: before, next: next);

  @override
  String toString() {
    String str = value.isEmpty
        ? ""
        : "${before != null ? "&" : ""}filter[$key]=[${value.join(',')}]";
    if (next != null) str += next.toString();
    return str;
  }
}

class OrWhere<T extends List, Filter extends Map<String, T>>
    extends Where<T, Filter> {
  @override
  String key;
  @override
  T value;
  @override
  Where<T, Filter>? next;
  @override
  Where<T, Filter>? before;

  OrWhere({
    required this.key,
    required this.value,
    this.before,
    this.next,
  }) : super(
          key: key,
          value: value,
          before: before,
          next: next,
        );

  @override
  String toString() {
    String str = value.isEmpty
        ? ""
        : "${before != null ? "&" : ""}filter[$key]=[${value.join('|')}]";
    if (next != null) str += next.toString();
    return str;
  }
}

class PrestaShopQuery {
  String tableName;
  List<String> display;
  List<String> sort;
  List<Where> filters;

  int? offSet;
  int? limit;

  PrestaShopQuery({
    required this.tableName,
    this.offSet,
    this.limit,
    this.display = const [],
    this.filters = const [],
    this.sort = const [],
  });

  String queryService() => _queryBuilder(this);

  String _queryBuilder(PrestaShopQuery psq) {
    String select = psq.display.isEmpty
        ? "display=full"
        : "display=[${psq.display.join(',')}]";
    String where =
        psq.filters.isEmpty ? "" : psq.filters.elementAt(0).toString();
    String sortBy = psq.sort.isEmpty ? "" : "&[${psq.sort.join(',')}]";
    String strLimit = "";
    if (offSet != null && limit != null && offSet! < limit!) {
      strLimit = "&limit=$offSet,$limit";
    } else if (limit != null) {
      strLimit = "&limit=$limit";
    }
    return "$tableName/?$select&$where$sortBy$strLimit";
  }
}

class Where<T extends Object, Filter extends Map<String, T>> {
  String key;
  T value;

  Where<T, Filter>? next;
  Where<T, Filter>? before;

  Where({
    required this.key,
    required this.value,
    this.before,
    this.next,
  }) {
    if (before != null) before!.next = this;
    if (next != null) next!.before = this;
  }

  @override
  String toString() {
    String str = value.toString().isEmpty
        ? ""
        : "${before != null ? "&" : ""}filter[$key]=[${value.toString()}]";
    if (next != null) str += next.toString();
    return str;
  }
}
