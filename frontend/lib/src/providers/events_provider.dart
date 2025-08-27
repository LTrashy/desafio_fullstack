// lib/src/providers/events_provider.dart
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/paginated_events.dart';
import '../services/events_api.dart';

class EventsProvider extends ChangeNotifier {
  final List<Event> _events = [];
  int _page = 1;
  final int _size = 10;
  bool _loading = false;
  bool _hasMore = true;

  List<Event> get events => _events;
  bool get loading => _loading;
  bool get hasMore => _hasMore;

  Future<void> fetchEvents({bool reset = false}) async {
    if (_loading) return;

    if (reset) {
      _events.clear();
      _page = 1;
      _hasMore = true;
    }

    _loading = true;
    notifyListeners();

    try {
      final PaginatedEvents newEvents =
          await EventsApi.fetchEvents(page: _page, size: _size);

      if (newEvents.results.isEmpty) {
        _hasMore = false;
      } else {
        _events.addAll(newEvents.results); // ✅ usar la lista results
        _page++;
      }
    } catch (e) {
      debugPrint("Error fetching events: $e");
    }

    _loading = false;
    notifyListeners();
  }
}
