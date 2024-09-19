import 'package:flutter/material.dart';
import 'features/sign_up.dart';
import 'features/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stress Relief App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpPage(),
        '/dashboard': (context) => const Dashboard(),
      },
    );
  }
}