import 'package:edupilot/screens/home/home.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {

  // allows firebase to use platform channels to call native code
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
      theme: primaryTheme,
      home: const Home(), 
    ),
  );
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SANDBOX'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: const Text('Sandbox'),
    );
  }
}
