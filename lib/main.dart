import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final month = DateFormat("MMMM").format(currentDate);

    return MaterialApp(
      title: 'Journey',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F2EE),
        fontFamily: 'PlayfairDisplay',
      ),
      home: HomeScreen(title: 'Today, ${currentDate.day} $month'),
    );
  }
}
