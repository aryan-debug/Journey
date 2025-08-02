import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journey/providers/google_user_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/week_calendar.dart';
import '../widgets/check_in_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final month = DateFormat("MMMM").format(currentDate);

    return Consumer<GoogleUserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8F2EE),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today, ${currentDate.day} $month",
                  style: const TextStyle(fontSize: 15),
                ),
                TextButton(
                  child: Text("Log Out"),
                  onPressed: () => userProvider.signOut(),
                ),
              ],
            ),
          ),
          body: const Center(
            child: Column(children: [WeekCalendar(), CheckInSection()]),
          ),
        );
      },
    );
  }
}
