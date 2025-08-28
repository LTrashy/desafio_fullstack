// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/events_provider.dart';
import 'src/screens/events_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eventos App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const EventsListScreen(),
      ),
    );
  }
}
