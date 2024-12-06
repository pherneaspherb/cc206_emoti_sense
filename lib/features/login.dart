import 'package:cc206_emoti_sense/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF56E1E9),
      appBar: AppBar(
        leading: BackButton(color: const Color.fromARGB(255, 8, 3, 87)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF56E1E9),
              Color(0xFFEEF7FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 36, 99),
                  ),
                ),
                SizedBox(height: 20),
                // Email Input with Validation
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: emailError, 
                    errorStyle: TextStyle(
                      color: Colors.red, 
                      fontSize: 14, 
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        emailError = 'Please enter your email';
                      });
                      return '';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      setState(() {
                        emailError = 'Please enter a valid email address';
                      });
                      return '';
                    }
                    setState(() {
                      emailError = null;
                    });
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: passwordError, 
                    errorStyle: TextStyle(
                      color: Colors.red, 
                      fontSize: 14, 
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        passwordError = 'Please enter your password';
                      });
                      return '';
                    }
                    setState(() {
                      passwordError = null;
                    });
                    return null;
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      _login(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1B3C73), 
                          Color(0xFF3371D9), 
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'New to EmotiSense? Sign up for free',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  _login(BuildContext context) async {
    try {
      final user = await _auth.loginUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      if (user != null) {
        log("User Logged In");
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        
        setState(() {
          emailError = 'Invalid email or password';
          passwordError = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        emailError = 'Error: $e'; 
        passwordError = 'Error: $e'; 
      });
    }
  }
}
