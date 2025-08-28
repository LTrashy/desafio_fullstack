import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:intl/intl.dart';

class EventDetailModal extends StatelessWidget {
  final Event event;
  const EventDetailModal({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(event.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.description),
          const SizedBox(height: 8),
          Text("Fecha: ${DateFormat('dd/MM/yyyy – HH:mm').format(event.date)}"),
          const SizedBox(height: 8),
          Text("Lugar: ${event.address}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cerrar"),
        ),
      ],
    );
  }
}
