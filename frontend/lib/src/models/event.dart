// lib/src/models/event.dart
class Event {
  final int id;
  final String title;
  final String description;
  final String date;
  final String address;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.address,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: json['date'],
        address: json['location']?['address'] ?? '',
      );
}
