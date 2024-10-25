import 'package:flutter/material.dart';
import 'features/dashboard.dart'; // Import the dashboard file

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
      home: const Dashboard(), // Use the Dashboard as the initial screen
    );
  }
}
