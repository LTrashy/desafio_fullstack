import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';
import '../models/paginated_events.dart';

class EventsApi {
  static Future<PaginatedEvents> fetchEvents({int page = 1, int size = 10}) async {
    final url = Uri.parse("http://localhost:8000/api/events/?page=$page&page_size=$size");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return PaginatedEvents.fromJson(data);
    } else {
      throw Exception('Failed to load events');
    }
  }
}
