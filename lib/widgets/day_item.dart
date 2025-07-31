import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  const DayItem({
    super.key,
    required this.weekday,
    required this.date,
    required this.isToday,
    required this.isFutureDate,
  });

  final String weekday;
  final DateTime date;
  final bool isToday;
  final bool isFutureDate;

  @override
  Widget build(BuildContext context) {
    final textColor = isFutureDate
        ? const Color(0xFFE4E0DC)
        : (isToday ? const Color(0xFF2E2C28) : const Color(0xFF827E7B));

    return Column(
      children: [
        Text(weekday, style: TextStyle(color: textColor)),
        Text('${date.day}', style: TextStyle(color: textColor)),
        Image.asset(
          isFutureDate ? "assets/images/empty.png" : "assets/images/frown.png",
          width: 55,
          height: 55,
        ),
      ],
    );
  }
}
