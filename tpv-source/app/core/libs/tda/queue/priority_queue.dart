PriorityQueue<T> createPriorityQueue<T>(int Function(T, T) callback) {
  try {
    return _HeapPriorityQueue<T>(callback);
  } catch (e) {
    return PriorityQueue<T>(callback);
  }
}

class HeapPriorityQueue<T> {
  final List<_HeapPriorityQueueNode<T>> _queue = [];

  HeapPriorityQueue(int Function(T, T) callback) : super();

  /// Retorna el primer elemento de la cola de prioridad sin removerlo
  T? get first {
    if (_queue.isEmpty) {
      return null;
    }
    return _queue.first.item;
  }

  /// Retorna true si la cola de prioridad está vacía
  bool get isEmpty => _queue.isEmpty;

  /// Retorna el número de elementos en la cola de prioridad
  int get length => _queue.length;

  /// Añade un elemento a la cola de prioridad con la prioridad especificada
  void add(T item, int priority) {
    if (item == null) {
      throw ArgumentError('El elemento no puede ser nulo');
    }
    var node = _HeapPriorityQueueNode(item, priority);
    _queue.add(node);
    _bubbleUp(_queue.length - 1);
  }

  /// Remueve todos los elementos de la cola de prioridad
  void clear() {
    _queue.clear();
  }

  /// Retorna el elemento con la mayor prioridad sin removerlo de la cola
  T peek() {
    if (_queue.isEmpty) {
      throw StateError('La cola de prioridad está vacía');
    }
    return _queue.first.item;
  }

  /// Remueve y retorna el elemento con la mayor prioridad
  T remove() {
    if (_queue.isEmpty) {
      throw StateError('La cola de prioridad está vacía');
    }
    var node = _queue.first;
    _queue[0] = _queue.removeLast();
    _bubbleDown(0);
    return node.item;
  }

  /// Remueve y retorna el primer elemento de la cola de prioridad
  T? removeFirst() {
    if (_queue.isEmpty) {
      return null;
    }
    return remove();
  }

  void _bubbleDown(int index) {
    var node = _queue[index];
    var lastIndex = _queue.length - 1;
    while (true) {
      var leftChildIndex = 2 * index + 1;
      var rightChildIndex = 2 * index + 2;
      _HeapPriorityQueueNode<T>? leftChild, rightChild;
      int? swapIndex;
      if (leftChildIndex <= lastIndex) {
        leftChild = _queue[leftChildIndex];
        if (leftChild.priority > node.priority) {
          swapIndex = leftChildIndex;
        }
      }
      if (rightChildIndex <= lastIndex) {
        rightChild = _queue[rightChildIndex];
        if (rightChild.priority >
            (swapIndex == null ? node.priority : leftChild!.priority)) {
          swapIndex = rightChildIndex;
        }
      }
      if (swapIndex == null) {
        break;
      }
      _queue[index] = _queue[swapIndex];
      _queue[swapIndex] = node;
      index = swapIndex;
    }
  }

  void _bubbleUp(int index) {
    var node = _queue[index];
    while (index > 0) {
      var parentIndex = (index - 1) ~/ 2;
      var parent = _queue[parentIndex];
      if (node.priority <= parent.priority) {
        break;
      }
      _queue[index] = parent;
      _queue[parentIndex] = node;
      index = parentIndex;
    }
  }
}

class PriorityQueue<T> {
  final List<_PriorityQueueNode<T>> _queue = [];

  PriorityQueue(int Function(T, T) callback);

  /// Retorna true si la cola de prioridad está vacía
  bool get isEmpty => _queue.isEmpty;

  bool get isNotEmpty => _queue.isNotEmpty;

  /// Retorna el número de elementos en la cola de prioridad
  int get length => _queue.length;

  /// Añade un elemento a la cola de prioridad con la prioridad especificada
  void add(T item, int priority) {
    if (item == null) {
      throw ArgumentError('El elemento no puede ser nulo');
    }
    var node = _PriorityQueueNode(item, priority);
    var index = _queue.indexWhere((n) => n.priority > priority);
    if (index == -1) {
      _queue.add(node);
    } else {
      _queue.insert(index, node);
    }
  }

  void addAll(List list) {
    //TODO por implementar
  }

  /// Remueve todos los elementos de la cola de prioridad
  void clear() {
    _queue.clear();
  }

  /// Retorna el elemento con la mayor prioridad sin removerlo de la cola
  T peek() {
    if (_queue.isEmpty) {
      throw StateError('La cola de prioridad está vacía');
    }
    return _queue[0].item;
  }

  /// Remueve y retorna el elemento con la mayor prioridad
  T remove() {
    if (_queue.isEmpty) {
      throw StateError('La cola de prioridad está vacía');
    }
    return _queue.removeAt(0).item;
  }

  /// Remueve y retorna el primer elemento de la cola de prioridad
  T? removeFirst() {
    if (_queue.isEmpty) {
      return null;
    }
    return remove();
  }
}

class _HeapPriorityQueue<T> extends PriorityQueue<T> {
  final HeapPriorityQueue<_PriorityQueueNode<T>> _heapQueue =
      HeapPriorityQueue<_PriorityQueueNode<T>>(
          (a, b) => a.priority.compareTo(b.priority));

  _HeapPriorityQueue(int Function(T, T) callback) : super(callback);

  @override
  bool get isEmpty => _heapQueue.isEmpty;

  @override
  int get length => _heapQueue.length;

  @override
  void add(T item, int priority) {
    if (item == null) {
      throw ArgumentError('El elemento no puede ser nulo');
    }
    var node = _PriorityQueueNode(item, priority);
    _heapQueue.add(node, priority);
  }

  @override
  void clear() {
    _heapQueue.clear();
  }

  @override
  T peek() {
    if (_heapQueue.isEmpty) {
      throw StateError('La cola de prioridad está vacía');
    }
    return _heapQueue.first!.item;
  }

  @override
  T remove() {
    if (_heapQueue.isEmpty) {
      throw StateError('La cola de prioridad está vacía');
    }
    return _heapQueue.removeFirst()!.item;
  }
}

class _HeapPriorityQueueNode<T> {
  final T item;
  final int priority;
  _HeapPriorityQueueNode(this.item, this.priority);
}

class _PriorityQueueNode<T> {
  final T item;
  final int priority;
  _PriorityQueueNode(this.item, this.priority);
}
