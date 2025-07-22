import 'dart:async';

typedef EventCallback = void Function(Map<dynamic, dynamic> args);

class TypedEventEmitter {
  final Map<String, List<EventCallback>> _listeners = {};

  TypedEventEmitter on(String event, EventCallback listener) {
    _listeners.putIfAbsent(event, () => []);
    _listeners[event]!.add(listener);
    return this;
  }

  TypedEventEmitter off(String event, EventCallback listener) {
    _listeners[event]?.remove(listener);
    return this;
  }

  TypedEventEmitter emit(String event, [dynamic args = const {}]) {
    final eventListeners = _listeners[event];
    if (eventListeners != null) {
      for (final listener in List<EventCallback>.from(eventListeners)) {
        listener(args);
      }
    }
    return this;
  }

  Future<List<dynamic>> waitFor(String event) {
    late EventCallback listener;

    final completer = Completer<List<dynamic>>();
    listener = (args) {
      off(event, listener);
      completer.complete(args as List<dynamic>);
    };

    on(event, listener);
    return completer.future;
  }
}
