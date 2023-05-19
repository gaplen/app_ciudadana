import 'package:flutter/foundation.dart';
import 'package:app_ciudadana/src/models/event.dart';

class EventNotifier extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }
}
