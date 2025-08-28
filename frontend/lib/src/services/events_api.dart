import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/paginated_events.dart';

class EventsApi {
  static const String baseUrl = 'http://localhost:8000/api';

  static Future<PaginatedEvents> fetchEvents({String? url}) async {
    final response = await http.get(Uri.parse(url ?? '$baseUrl/events/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return PaginatedEvents.fromJson(data);
    } else {
      throw Exception('Error fetching events');
    }
  }
}
