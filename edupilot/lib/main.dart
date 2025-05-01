import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/screens/main/main_screen.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> decideStartScreen() async {
    final studentId = await StudentSession.getStudentId();
    if (studentId != null) {
      return const MainScreen();
    } else {
      return const WelcomeScreen();
    }
  }

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduPilot',
      theme: primaryTheme,
      home: FutureBuilder<Widget>(
        future: decideStartScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const Scaffold(body: Center(child: Text('Error!')));
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
