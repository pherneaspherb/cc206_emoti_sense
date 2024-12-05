import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  // Method to add a journal entry
  Future<void> addJournalEntry(String title, String entry) async {
    try {
      // Add the journal entry to the 'journal_entries' subcollection for the specific user
      await userCollection
          .doc(uid)
          .collection('journal_entries')
          .add({
        'title': title,
        'entry': entry,
        'created_at': Timestamp.now(),
      });
    } catch (e) {
      print("Error adding journal entry: $e");
    }
  }

  // Method to add or update user data
  Future<void> updateUserData(String name) async {
    try {
      await userCollection.doc(uid).set({
        'name': name,
      }, SetOptions(merge: true));  // Merge ensures we don't overwrite existing fields
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  // Method to update user's mood in Firestore
  Future<void> updateUserMood(String mood) async {
    try {
      // Access the user's document in Firestore and update the mood field
      await userCollection.doc(uid).update({
        'mood': mood,  // Update the 'mood' field with the new mood value
      });
    } catch (e) {
      throw Exception("Failed to update mood: $e");
    }
  }

  // Method to fetch all journal entries for the user
  Future<List<Map<String, dynamic>>> getJournalEntries() async {
    try {
      // Fetch all the journal entries for the user, ordered by the 'created_at' field
      QuerySnapshot snapshot = await userCollection
          .doc(uid)
          .collection('journal_entries')
          .orderBy('created_at', descending: true)
          .get();

      // Convert the snapshot data to a list of journal entries
      return snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print("Error fetching journal entries: $e");
      return [];
    }
  }

  // Method to fetch the user's name from Firestore
  Future<String> getUserName() async {
  try {
    DocumentSnapshot userDoc = await userCollection.doc(uid).get();
    if (userDoc.exists) {
      return userDoc['name'] ?? 'User'; // Fallback to 'User' if 'name' is not found
    } else {
      return 'User'; // Return 'User' if the document does not exist
    }
  } catch (e) {
    print("Error fetching user name: $e");
    return 'User';
  }
}


  // Method to fetch all moods for the user
  Future<List<String>> getMoodHistory() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        List<dynamic> moods = userDoc['moods'] ?? [];
        return List<String>.from(moods);  // Convert list to String list
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching mood history: $e");
      return [];
    }
  }
}
