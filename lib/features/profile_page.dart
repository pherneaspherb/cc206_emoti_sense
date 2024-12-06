import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cc206_emoti_sense/features/journal.dart';
import 'package:cc206_emoti_sense/features/profile_edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = 'user@example.com';
  String _bio = 'Enter bio here.';
  File? _profileImage;

  // Fetch user name from Firestore
  Future<String> _fetchUserName() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        return userDoc['name'] ?? 'User'; 
      } else {
        return 'User'; 
      }
    } catch (e) {
      print("Error fetching user name: $e");
      return 'User'; 
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user details
        setState(() {
          _email = user.email ?? 'user@example.com';
        });

        // Fetch additional data from Firestore for bio
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            _bio = userDoc['bio'] ?? 'Enter bio here.';
          });
        }
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366),
              Color(0xFF006699), 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!) as ImageProvider
                      : const AssetImage('assets/yebe.png'),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 16),

                // Fetch user name using FutureBuilder
                FutureBuilder<String>(
                  future: _fetchUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return Text(
                      snapshot.data ?? 'User Name',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),

                // Email
                Text(
                  _email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Bio
                Text(
                  _bio,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildButton(
                  Icons.edit,
                  "Edit Profile",
                  onTap: () async {
                    print("Navigating to ProfileEdit page...");
                    final updatedProfile = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileEdit(),
                        settings: RouteSettings(
                          arguments: {
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            },
                          ),
                        ),
                      );
                      print("Returned from ProfileEdit page with: $updatedProfile");
                      if (updatedProfile != null && updatedProfile is Map<String, dynamic>) {
                        setState(() {
                          _bio = updatedProfile['bio'] ?? _bio;
                          _profileImage = updatedProfile['profileImage'];
                        });
                      }
                    },
                  ),

                _buildButton(
                  Icons.book,
                  "My Journal",
                  onTap: () {
                    String? uid = FirebaseAuth.instance.currentUser?.uid;
                    if (uid != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JournalPage(uid: uid),
                        ),
                      );
                    } else {
                      print("UID not found, cannot navigate to JournalPage.");
                    }
                  },
                ),
                _buildButton(
                  Icons.logout,
                  "Log Out",
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method for buttons
 Widget _buildButton(IconData icon, String label, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 0, 0, 159)),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 0, 0, 159),
            ),
          ),
        ],
      ),
    ),
  );
}
}
