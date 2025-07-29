// Clase abstracta que define el comportamiento del objeto real y del proxy
// Clase concreta del proxy que implementa el comportamiento definido en la clase Subject
class Proxy implements Subject {
  RealSubject? _realSubject;

  @override
  void request() {
    // Usa el objeto real para manejar la petición
    _getRealSubject().request();
  }

  // Método para acceder al objeto real, creándolo si aún no existe
  RealSubject _getRealSubject() {
    _realSubject ??= RealSubject();
    return _realSubject!;
  }
}

// Clase concreta del objeto real que implementa el comportamiento definido en la clase Subject
class RealSubject implements Subject {
  @override
  void request() {}
}

abstract class Subject {
  void request();
}
