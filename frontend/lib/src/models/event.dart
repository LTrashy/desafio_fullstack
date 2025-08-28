// lib/src/models/event.dart
class Event {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final double lat;
  final double lng;
  final String address;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final location = json['location'];
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      lat: location['lat'],
      lng: location['lng'],
      address: location['address'],
    );
  }
}
