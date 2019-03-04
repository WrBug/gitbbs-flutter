import 'package:event_bus/event_bus.dart';

class EventBusHelper {
  static EventBus _eventBus = new EventBus();

  static EventBus getDefault() {
    return _eventBus;
  }

  static Stream<T> on<T>() {
    return _eventBus.on<T>();
  }

  static fire(event){
    _eventBus.fire(event);
  }
}
