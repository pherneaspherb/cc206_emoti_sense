import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/sign_up.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Log In Title
            Text(
              'Log In',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            // Username or Email Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Username or Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Password Input
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Remember Me and Forgot Password Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Switch(value: false, onChanged: (bool value) {}),
                    Text('Enable Face ID'),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Forgot your password?'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Log In Button
            ElevatedButton(
              onPressed: () {
                //for Dashboard
              },
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Google Login Button
            ElevatedButton.icon(
              onPressed: () {
                // Handle Google login
              },
              icon: Icon(Icons.login),
              label: Text('Log In with Google'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.red, // Google red color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Social Media Login Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.apple),
                  iconSize: 40,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.facebook),
                  iconSize: 40,
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            // Sign Up Prompt
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('New to EmotiSense? Sign up for free'),
            ),
          ],
        ),
      ),
    );
  }
}