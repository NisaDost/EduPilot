import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/screens/main/main_screen.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// firebase

void main() async {

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduPilot',
      theme: primaryTheme,
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
