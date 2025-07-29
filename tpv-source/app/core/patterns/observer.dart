// Clase abstracta que define el comportamiento del sujeto

// Clase concreta del observador que implementa el comportamiento definido en la clase Observer
class ConcreteObserver implements Observer {
  final String _name;
  final ConcreteSubject _subject;

  ConcreteObserver(this._name, this._subject);

  // Método que se llama cuando el sujeto notifica un cambio
  @override
  void update() {}
}

// Clase concreta del sujeto que implementa el comportamiento definido en la clase Subject
class ConcreteSubject extends Subject {
  String? _state;

  String? get state => _state;

  set state(String? value) {
    _state = value;
    // Notifica a todos los observadores de un cambio en el estado del sujeto
    notify();
  }
}

// Clase abstracta que define el comportamiento del observador
abstract class Observer {
  void update();
}

abstract class Subject {
  final List<Observer> _observers = [];

  // Método para agregar un nuevo observador a la lista
  void attach(Observer observer) {
    _observers.add(observer);
  }

  // Método para remover un observador de la lista
  void detach(Observer observer) {
    _observers.remove(observer);
  }

  // Método para notificar a todos los observadores de un cambio en el sujeto
  void notify() {
    for (var observer in _observers) {
      observer.update();
    }
  }
}
