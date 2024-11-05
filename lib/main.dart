// NOVEMBER 11 pushed by pher
// enhanced features and added games - maggiiee1

import 'package:flutter/material.dart';
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
      home: const Dashboard(), 
    );
  }
}
