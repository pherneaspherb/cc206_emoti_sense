import 'package:cc206_emoti_sense/features/login.dart';
import 'package:cc206_emoti_sense/features/profile_edit.dart';
import 'package:cc206_emoti_sense/features/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/welcome.dart';
import 'package:cc206_emoti_sense/features/dashboard_page.dart'; 
import 'package:cc206_emoti_sense/features/discover_page.dart';
import 'package:cc206_emoti_sense/features/games_page.dart'; 
import 'package:cc206_emoti_sense/features/profile_page.dart'; 
import 'package:cc206_emoti_sense/features/discover_sections/music.dart'; 
import 'package:cc206_emoti_sense/features/discover_sections/meditation.dart';
import 'package:cc206_emoti_sense/features/discover_sections/breathwork.dart';
import 'package:cc206_emoti_sense/features/discover_sections/readings.dart';
import 'package:provider/provider.dart';
import 'package:cc206_emoti_sense/provider/recent_items.dart'; 

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC-9BQmg8TmMh9jXpl3jl5xYjXi6jdfrCY",
  authDomain: "aesync-emotisense.firebaseapp.com",

  projectId: "aesync-emotisense",

  storageBucket: "aesync-emotisense.firebasestorage.app",

  messagingSenderId: "584166979867",

  appId: "1:584166979867:web:01a04895718fb73ddb7bbe"));
  }else{
    await Firebase.initializeApp();
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => RecentItems(), // Provide RecentItems globally
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
      routes: {
        '/': (context) => const WelcomeScreen(), 
        '/dashboard': (context) => const Dashboard(), 
        '/login': (context) =>  const LoginScreen(), 
        '/signup': (context) => SignUpScreen(), 
        '/discover': (context) => const DiscoverPage(),
        '/games': (context) => const GamesPage(), 
        '/profile': (context) => const ProfilePage(),    
        '/editProfile': (context) => const ProfileEdit(),
        '/music': (context) => const MusicPage(),
        '/meditation': (context) => const MeditationPage(),
        '/breathwork': (context) => const BreathworkPage(), 
        '/stories': (context) => const ReadingsPage(), 
      },
    );
  }
}
