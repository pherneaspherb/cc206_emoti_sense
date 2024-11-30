import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/login.dart';
import 'package:cc206_emoti_sense/features/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF7FF), // Soft gradient base color
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 133, 216, 206), // Top gradient color
              Color(0xFFEEF7FF), // Bottom gradient color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png', // Your logo image
                      height: 120, // Adjust to match the mockup
                    ),
                    SizedBox(height: 16),
                    Text(
                      'EmotiSense',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF012B54), // Deep blue
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your Calm in Every Heartbeat',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5A738E), // Soft text color
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF225BDF), // Deep blue color
                  foregroundColor: Colors.white, // Text color
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Log In Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF225BDF), // Deep blue color
                  foregroundColor: Colors.white, // Text color
                 // side: BorderSide(color: Color(0xFF225BDF), width: 2), // Outline
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
