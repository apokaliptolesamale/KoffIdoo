// Clase que representa un mensaje enviado por el publicador a los suscriptores
// Clase concreta del publicador que implementa el comportamiento definido en la clase Publisher
import '../services/logger_service.dart';

class ConcretePublisher<T> extends Publisher<T> {
  T? _state;

  T? get state => _state;

  set state(T? value) {
    _state = value;
    // Envía un mensaje a todos los suscriptores de un cambio en el estado del publicador
    publishMessage(Message<T>(
        'El estado del publicador ha cambiado a ${_state.toString()}', _state));
  }
}

// Clase concreta del suscriptor que implementa el comportamiento definido en la clase Subscriber
class ConcreteSubscriber implements Subscriber {
  final String _name;

  ConcreteSubscriber(this._name);

  // Método que se llama cuando el publicador envía un mensaje
  @override
  void receiveMessage(Message message) {
    log('$_name ha recibido el mensaje: ${message.content}');
  }
}

class Message<T> {
  final String content;
  final T? state;
  Message(this.content, this.state);
}

// Clase abstracta que define el comportamiento del publicador
abstract class Publisher<T> {
  final List<Subscriber<T>> _subscribers = [];

  // Método para agregar un nuevo suscriptor a la lista
  void addSubscriber(Subscriber<T> subscriber) {
    _subscribers.add(subscriber);
  }

  // Método para enviar un mensaje a todos los suscriptores
  void publishMessage(Message<T> message) {
    for (var subscriber in _subscribers) {
      subscriber.receiveMessage(message);
    }
  }

  // Método para remover un suscriptor de la lista
  void removeSubscriber(Subscriber<T> subscriber) {
    _subscribers.remove(subscriber);
  }
}

// Clase abstracta que define el comportamiento del suscriptor
abstract class Subscriber<T> {
  void receiveMessage(Message<T> message);
}
