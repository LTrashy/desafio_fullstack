import 'event.dart';

class PaginatedEvents {
  final List<Event> events;
  final String? nextPageUrl;

  PaginatedEvents({required this.events, this.nextPageUrl});

  factory PaginatedEvents.fromJson(Map<String, dynamic> json) {
    final List<Event> events = (json['results'] as List)
        .map((e) => Event.fromJson(e))
        .toList();

    return PaginatedEvents(
      events: events,
      nextPageUrl: json['next'],
    );
  }

  bool get hasNextPage => nextPageUrl != null;
}
