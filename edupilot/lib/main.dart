import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/screens/main/main_screen.dart';
import 'package:edupilot/screens/splash/custom_splash_screen.dart';
import 'package:edupilot/screens/supervisor/home/supervisor_home_screen.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:edupilot/sessions/supervisor_session.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CustomSplashScreen(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> decideStartScreen() async {
    final studentId = await StudentSession.getStudentId();
    final supervisorId = await SupervisorSession.getSupervisorId();
    if (studentId != null) {
      return const MainScreen();
    } else if (supervisorId != null) {
      return const SupervisorHomeScreen();
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
            return Scaffold(body: Center(child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
              ))
            );
          } else if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const Scaffold(body: Center(child: Text('Error!')));
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr'), // Turkish
        Locale('en'), // Optional fallback
      ],
    );
  }
}