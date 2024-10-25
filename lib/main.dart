import 'package:flutter/material.dart';
import 'features/dashboard.dart';
// OCTOBER 25
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
      home: Dashboard(), 
    );
  }
}
