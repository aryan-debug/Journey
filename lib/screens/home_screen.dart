import 'package:flutter/material.dart';
import '../widgets/week_calendar.dart';
import '../widgets/check_in_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F2EE),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 15)),
            const Icon(Icons.settings_outlined),
          ],
        ),
      ),
      body: const Center(
        child: Column(children: [WeekCalendar(), CheckInSection()]),
      ),
    );
  }
}
