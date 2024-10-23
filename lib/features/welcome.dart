import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/login.dart';
import 'package:cc206_emoti_sense/features/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // EmotiSense Logo
            Center(
              child: Column(
                children: [
                  Text(
                    'EmotiSense',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 50, 136),
                    ),
                  ),
                  SizedBox(height: 20),
                  // EmotiSense Image Logo
                  Image.asset(
                    'assets/logo.png', 
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Sign Up & Log In Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Log In'),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
