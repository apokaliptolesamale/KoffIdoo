// Clase que encapsula el estado interno del objeto
// Clase que mantiene una lista de mementos
class CareTaker {
  final List<Memento> _mementos = [];

  void addMemento(Memento memento) {
    _mementos.add(memento);
  }

  Memento getMemento(int index) {
    return _mementos[index];
  }
}

class Memento {
  final String? _state;

  Memento(this._state);

  String? getState() => _state;
}

// Clase que crea y restaura los mementos
class Originator {
  String? _state;

  void getStateFromMemento(Memento memento) {
    _state = memento.getState();
  }

  Memento saveStateToMemento() {
    return Memento(_state);
  }

  void setState(String state) {
    _state = state;
  }
}
