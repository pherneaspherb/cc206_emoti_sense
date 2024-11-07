import 'package:cc206_emoti_sense/features/login.dart';
import 'package:cc206_emoti_sense/features/profile_edit.dart';
import 'package:cc206_emoti_sense/features/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/welcome.dart';
import 'package:cc206_emoti_sense/features/dashboard.dart'; // Import your other pages/screens
import 'package:cc206_emoti_sense/features/discover_page.dart'; // Import Discover Page
import 'package:cc206_emoti_sense/features/games_page.dart'; // Import Games Page
import 'package:cc206_emoti_sense/features/profile_page.dart'; // Import Profile Page
import 'package:cc206_emoti_sense/features/discover_sections/music.dart'; // Import Music Screen
import 'package:cc206_emoti_sense/features/discover_sections/meditation.dart'; // Import Meditation Screen
import 'package:cc206_emoti_sense/features/discover_sections/breathwork.dart'; // Import Breathwork Screen
import 'package:cc206_emoti_sense/features/discover_sections/stories.dart'; // Import Stories Screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the default route when the app starts
      routes: {
        '/': (context) => WelcomeScreen(), // Welcome Screen as the starting point
        '/dashboard': (context) => const Dashboard(), // Dashboard Screen
        '/login': (context) =>  LoginScreen(), // Login Screen
        '/singup': (context) => SignUpScreen(), // Signup Screen
        '/discover': (context) => const DiscoverPage(), // Discover Page
        '/games': (context) => const GamesPage(), // Games Page
        '/profile': (context) => const ProfilePage(), // Profile Page
        '/editprofile': (context) => const ProfileEdit(), // Edit Profile Screen
        '/music': (context) => MusicScreen(), // Music Screen
        '/meditation': (context) =>  MeditationScreen(), // Meditation Screen
        '/breathwork': (context) => BreathworkScreen(), // Breathwork Screen
        '/stories': (context) => StoriesScreen(), // Stories Screen
      },
    );
  }
}
