import 'package:cc206_emoti_sense/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Method to create a new user with email and password
  Future<User?> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      // Create user credentials
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Check if user is not null and update the database with their name
      if (cred.user != null) {
        await DatabaseService(uid: cred.user!.uid)
            .updateUserData(name);
      }

      return cred.user;
    } catch (e) {
      log("Something went wrong in createUserWithEmailAndPassword: $e");
    }
    return null;
  }

  // Method to log in an existing user with email and password
  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong in loginUserWithEmailAndPassword: $e");
    }
    return null;
  }

  // Method to sign out the current user
  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong in signout: $e");
    }
  }
}
