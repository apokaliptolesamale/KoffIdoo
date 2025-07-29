// Clase abstracta que define el comportamiento del componente y de los decoradores
abstract class Component {
  void operation();
}

// Clase concreta del componente que implementa el comportamiento definido en la clase Component
class ConcreteComponent implements Component {
  @override
  void operation() {}
}

// Clase concreta del decorador que agrega una funcionalidad adicional
class ConcreteDecoratorA extends Decorator {
  ConcreteDecoratorA(Component? component) : super(component);

  void addedBehavior() {}

  @override
  void operation() {
    super.operation();
    addedBehavior();
  }
}

// Clase concreta del decorador que agrega otra funcionalidad adicional
class ConcreteDecoratorB extends Decorator {
  ConcreteDecoratorB(Component? component) : super(component);

  void addedBehavior() {}

  @override
  void operation() {
    super.operation();
    addedBehavior();
  }
}

// Clase abstracta del decorador que extiende el comportamiento definido en la clase Component
abstract class Decorator implements Component {
  final Component? _component;

  Decorator(this._component);

  @override
  void operation() {
    // Usa el método operation del componente original y agrega funcionalidades adicionales
    if (_component != null) {
      _component!.operation();
    }
  }
}
