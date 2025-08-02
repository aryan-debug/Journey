import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:journey/firebase_options.dart';
import 'package:journey/providers/google_user_provider.dart';
import 'package:journey/screens/auth_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => GoogleUserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journey',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F2EE),
        fontFamily: "PlayfairDisplay",
      ),
      home: AuthWrapper(),
    );
  }
}
