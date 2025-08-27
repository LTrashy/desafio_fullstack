// lib/src/models/paginated_events.dart
import 'event.dart';

class PaginatedEvents {
  final List<Event> results;
  final int page;
  final int totalPages;

  PaginatedEvents({
    required this.results,
    required this.page,
    required this.totalPages,
  });

  factory PaginatedEvents.fromJson(Map<String, dynamic> json) {
    return PaginatedEvents(
      results: (json['results'] as List)
          .map((e) => Event.fromJson(e))
          .toList(),
      page: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
