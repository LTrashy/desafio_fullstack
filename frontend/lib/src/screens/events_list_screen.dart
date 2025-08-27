// lib/src/screens/events_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/events_provider.dart';
import 'event_detail_screen.dart';

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<EventsProvider>(context, listen: false).fetchEvents(reset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Eventos")),
      body: eventsProvider.loading && eventsProvider.events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!eventsProvider.loading &&
                    scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  eventsProvider.fetchEvents();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: eventsProvider.events.length + (eventsProvider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < eventsProvider.events.length) {
                    final event = eventsProvider.events[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.event, color: Colors.blue),
                        title: Text(
                          event.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          event.description.length > 60
                              ? "${event.description.substring(0, 60)}..."
                              : event.description,
                        ),
                        trailing: Text(
                          event.date.toString().split(" ").first,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EventDetailScreen(event: event),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
    );
  }
}
