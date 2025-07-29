// ignore_for_file: null_check_on_nullable_type_parameter

import 'dart:collection';

import 'tda/queue/priority_queue.dart';

//Edge
class Edge<T> {
  final T u;
  final T v;
  final int weight;

  Edge(this.u, this.v, this.weight);
}

class Graph<T> {
  final Map<T, List<T>> _adjacencyList = {};

  // Añadir una arista al grafo no dirigido
  void addEdge(T u, T v) {
    _adjacencyList.putIfAbsent(u, () => []).add(v);
    _adjacencyList.putIfAbsent(v, () => []).add(u); // undirected graph
  }

  // Realizar una búsqueda en anchura (BFS) desde un vértice de inicio
  List<T> bfs(T start) {
    var visited = <T>[];
    var queue = Queue<T>()..add(start);
    while (queue.isNotEmpty) {
      var vertex = queue.removeFirst();
      if (!visited.contains(vertex)) {
        visited.add(vertex);
        if (_adjacencyList.containsKey(vertex)) {
          queue.addAll(_adjacencyList[vertex]!);
        }
      }
    }
    return visited;
  }

  // Encontrar los componentes conectados del grafo
  List<List<T>> connectedComponents() {
    var visited = <T>{};
    var components = <List<T>>[];
    for (var vertex in _adjacencyList.keys) {
      if (!visited.contains(vertex)) {
        var component = <T>[];
        _dfsConnectedComponents(vertex, visited, component);
        components.add(component);
      }
    }
    return components;
  }

  // Realizar una búsqueda en profundidad (DFS) desde un vértice de inicio
  List<T> dfs(T start) {
    var visited = <T>[];
    var stack = [start];
    while (stack.isNotEmpty) {
      var vertex = stack.removeLast();
      if (!visited.contains(vertex)) {
        visited.add(vertex);
        if (_adjacencyList.containsKey(vertex)) {
          stack.addAll(_adjacencyList[vertex]!.reversed);
        }
      }
    }
    return visited;
  }

  // Encontrar el camino más corto desde un vértice de inicio hasta un vértice de destino utilizando el algoritmo de Dijkstra
  List<T> dijkstra(T start, T end) {
    var distances = <T, int>{};
    var previous = <T, T?>{};
    var unvisited = SplayTreeSet<T>();
    var path = <T>[];

    for (var vertex in _adjacencyList.keys) {
      distances[vertex] = double.infinity.toInt();
      previous[vertex] = null;
      unvisited.add(vertex);
    }

    distances[start] = 0;

    while (unvisited.isNotEmpty) {
      var current = unvisited.first;
      unvisited.remove(current);
      if (current == end) {
        while (previous[current] != null) {
          path.insert(0, current);
          current = previous[current]!;
        }
        path.insert(0, start);
        break;
      }
      if (distances[current] == double.infinity.toInt()) {
        break;
      }
      for (var neighbor in _adjacencyList[current]!) {
        var alt = distances[current]! + 1;
        if (alt < distances[neighbor]!) {
          distances[neighbor] = alt;
          previous[neighbor] = current;
          unvisited.remove(neighbor); // re-insert to maintain the ordering
          unvisited.add(neighbor);
        }
      }
    }

    return path;
  }

  // Determinar si el grafo tiene algún ciclo
  bool hasCycle() {
    var visited = <T>{};
    for (var vertex in _adjacencyList.keys) {
      if (!visited.contains(vertex)) {
        if (_dfsCycleDetection(vertex, visited, null)) {
          return true;
        }
      }
    }
    return false;
  }

  /// Encontrar el árbol de expansión mínimo utilizando el algoritmo de Kruskal
  List<Edge<T>> kruskal() {
    var edges = _getAllEdges();
    edges.sort((a, b) => a.weight.compareTo(b.weight));

    var mst = <Edge<T>>[];
    var uf = UnionFind<T>(_adjacencyList.keys.toList());

    for (var edge in edges) {
      if (!uf.connected(edge.u, edge.v)) {
        uf.union(edge.u, edge.v);
        mst.add(edge);
      }
    }

    return mst;
  }

  /// Encontrar el árbol de expansión mínimo utilizando el algoritmo de Prim
  List<Edge<T>> prim(T start) {
    var mst = <Edge<T>>[];
    var visited = <T>{start};
    var pq = PriorityQueue<Edge<T>>((a, b) => a.weight.compareTo(b.weight));
    List<T>? list = _adjacencyList[start];
    //TODO por implementar el addAll
    pq.addAll(list ?? []);

    while (pq.isNotEmpty) {
      Edge<T>? edge = pq.removeFirst();
      if (edge != null &&
          (!visited.contains(edge.u) || !visited.contains(edge.v))) {
        mst.add(edge);
        visited.add(edge.u);
        visited.add(edge.v);
        //TODO por implementar el addAll
        pq.addAll(_adjacencyList[edge.u] ?? []);
        pq.addAll(_adjacencyList[edge.v] ?? []);
      }
    }

    return mst;
  }

  // Función auxiliar para encontrar los componentes conectados utilizando DFS
  void _dfsConnectedComponents(T vertex, Set<T> visited, List<T> component) {
    visited.add(vertex);
    component.add(vertex);
    for (var neighbor in _adjacencyList[vertex]!) {
      if (!visited.contains(neighbor)) {
        _dfsConnectedComponents(neighbor, visited, component);
      }
    }
  }

  // Función auxiliar para detectar ciclos en el grafo utilizando DFS
  bool _dfsCycleDetection(T vertex, Set<T> visited, T? parent) {
    visited.add(vertex);
    for (var neighbor in _adjacencyList[vertex]!) {
      if (!visited.contains(neighbor)) {
        if (_dfsCycleDetection(neighbor, visited, vertex)) {
          return true;
        }
      } else if (neighbor != parent) {
        return true;
      }
    }
    return false;
  }

  void _dfsHelper(String vertex, List<String> visited) {
    visited.add(vertex);
    for (var neighbor in _adjacencyList[vertex] ?? []) {
      if (!visited.contains(neighbor)) {
        _dfsHelper(neighbor, visited);
      }
    }
  }

  List<Edge<T>> _getAllEdges() {
    var edges = <Edge<T>>[];
    for (var vertex in _adjacencyList.keys) {
      for (var edge in _adjacencyList[vertex] ?? []) {
        if (edge.v != vertex) {
          edges.add(edge);
        }
      }
    }
    return edges;
  }
}

class UnionFind<T> {
  final Map<T, T> _parent = {};
  final Map<T, int> _rank = {};

  UnionFind(List<T> vertices) {
    for (var vertex in vertices) {
      _parent[vertex] = vertex;
      _rank[vertex] = 0;
    }
  }

  bool connected(T u, T v) {
    return find(u) == find(v);
  }

  T find(T vertex) {
    if (_parent[vertex] != null && _parent[vertex] != vertex) {
      _parent[vertex] = find(_parent[vertex]!);
    }
    return _parent[vertex]!;
  }

  void union(T u, T v) {
    var rootU = find(u);
    var rootV = find(v);
    if (rootU == rootV) return;
    if (_rank[rootU]! < _rank[rootV]!) {
      _parent[rootU] = rootV;
    } else if (_rank[rootU]! > _rank[rootV]!) {
      _parent[rootV] = rootU;
    } else {
      _parent[rootV] = rootU;
      _rank[rootU] = _rank[rootU]! + 1;
    }
  }
}
