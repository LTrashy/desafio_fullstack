import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/paginated_events.dart';
import '../services/events_api.dart';

class EventsProvider extends ChangeNotifier {
  final List<Event> _events = [];
  String? _nextPageUrl;
  bool _loading = false;

  List<Event> get events => _events;
  bool get loading => _loading;
  bool get hasMore => _nextPageUrl != null;

  Future<void> fetchEvents({bool reset = false}) async {
    if (_loading) return;

    _loading = true;
    notifyListeners();

    try {
      final String? url = reset ? null : _nextPageUrl;
      final PaginatedEvents page = await EventsApi.fetchEvents(url: url);

      if (reset) _events.clear();

      for (var e in page.events) {
        if (!_events.any((existing) => existing.id == e.id)) {
          _events.add(e);
        }
      }

      _nextPageUrl = page.nextPageUrl;
    } catch (e) {
      debugPrint('Error fetching events: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
