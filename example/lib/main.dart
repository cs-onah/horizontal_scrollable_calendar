import 'package:flutter/material.dart';
import 'package:horizontal_scrollable_calendar/horizontal_scrollable_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Horizontal Calendar Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HorizontalScrollableCalendar(
              onSelect: (DateTime time) => debugPrint(time.toIso8601String()),
            ),
          ],
        ),
      ),
    );
  }
}
