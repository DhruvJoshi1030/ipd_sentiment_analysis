import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sentimentanalysis/firebase_options.dart';
import 'package:sentimentanalysis/login.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for Firebase initialization

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}
