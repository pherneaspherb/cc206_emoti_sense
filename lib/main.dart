import 'package:cc206_emoti_sense/features/login.dart';
import 'package:cc206_emoti_sense/features/profile_edit.dart';
import 'package:cc206_emoti_sense/features/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/welcome.dart';
import 'package:cc206_emoti_sense/features/dashboard.dart'; 
import 'package:cc206_emoti_sense/features/discover_page.dart';
import 'package:cc206_emoti_sense/features/games_page.dart'; 
import 'package:cc206_emoti_sense/features/profile_page.dart'; 
import 'package:cc206_emoti_sense/features/discover_sections/music.dart'; 
import 'package:cc206_emoti_sense/features/discover_sections/meditation.dart';
import 'package:cc206_emoti_sense/features/discover_sections/breathwork.dart';
import 'package:cc206_emoti_sense/features/discover_sections/stories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
      routes: {
        '/': (context) => WelcomeScreen(), 
        '/dashboard': (context) => const Dashboard(), 
        '/login': (context) =>  LoginScreen(), 
        '/signup': (context) => SignUpScreen(), 
        '/discover': (context) => const DiscoverPage(),
        '/games': (context) => const GamesPage(), 
        '/profile': (context) => const ProfilePage(), 
        '/editprofile': (context) => const ProfileEdit(), 
        '/music': (context) => MusicPage(),
        '/meditation': (context) => MeditationPage(),
        '/breathwork': (context) => BreathworkPage(), 
        '/stories': (context) => PoemsPage(), 
      },
    );
  }
}
