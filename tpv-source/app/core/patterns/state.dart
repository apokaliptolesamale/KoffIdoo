// Clase abstracta que define el comportamiento del estado
// Clase concreta del estado que implementa el comportamiento definido en la clase State
class ConcreteStateA implements State {
  @override
  void handle() {}
}

// Clase concreta del estado que implementa otro comportamiento definido en la clase State
class ConcreteStateB implements State {
  @override
  void handle() {}
}

// Clase de contexto que mantiene una referencia al estado actual y delega todas las solicitudes al estado actual
class Context {
  State? _state;

  Context(State state) {
    transitionTo(state);
  }

  void request() {
    _state?.handle();
  }

  void transitionTo(State state) {
    _state = state;
    _state?.handle();
  }
}

abstract class State {
  void handle();
}
