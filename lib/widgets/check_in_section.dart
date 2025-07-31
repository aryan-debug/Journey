import 'package:flutter/material.dart';
import 'check_in_button.dart';

class CheckInSection extends StatelessWidget {
  const CheckInSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          const Text(
            "How do you feel?",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CheckInButton(onPressed: () {}),
        ],
      ),
    );
  }
}
