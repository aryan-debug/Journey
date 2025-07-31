import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'day_item.dart';

class WeekCalendar extends StatelessWidget {
  const WeekCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekDates = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
    final weekdays = DateFormat().dateSymbols.SHORTWEEKDAYS;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return DayItem(
          weekday: weekdays[(index + 1) % 7],
          date: weekDates[index],
          isToday: weekDates[index].day == now.day,
          isFutureDate: weekDates[index].isAfter(now),
        );
      }),
    );
  }
}
