import 'package:flutter/material.dart';
import 'addjournalentry.dart'; 
import 'package:cc206_emoti_sense/services/database.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 

class JournalPage extends StatefulWidget {
  final String uid;  // Pass UID from user authentication

  JournalPage({required this.uid});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  late Future<List<Map<String, dynamic>>> journalEntries; // Future to hold journal entries

  @override
  void initState() {
    super.initState();
    // Fetch journal entries when the page loads
    journalEntries = DatabaseService(uid: widget.uid).getJournalEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entries'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: journalEntries, // Use Future to fetch journal entries
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No journal entries found.'));
          }

          // Display journal entries in a ListView when data is fetched
          return Column(
            children: [
              // Button to navigate to AddEntryPage
              InteractionButton(
                label: 'Add New Entry',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEntryPage(
                        addJournalEntryCallback: _addJournalEntry,
                      ),
                    ),
                  );
                },
              ),
              
              // List of journal entries
              Expanded(
                child: LayoutListView(
                  items: List.generate(snapshot.data!.length, (index) {
                    final entry = snapshot.data![index];
                    return InteractionJournalItem(
                      title: entry['title'],
                      entry: entry['entry'],
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Function to add a new journal entry
  void _addJournalEntry(String title, String entry) async {
    try {
      await DatabaseService(uid: widget.uid).addJournalEntry(title, entry);
      setState(() {
        journalEntries = DatabaseService(uid: widget.uid).getJournalEntries(); // Refresh the entries
      });
    } catch (e) {
      print("Error adding journal entry: $e");
    }
  }
}

// Reusable Widget to show journal title and content
class InteractionJournalItem extends StatelessWidget {
  final String title;
  final String entry;

  InteractionJournalItem({required this.title, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ExpansionTile(
        title: ValueText(value: title),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ValueText(value: entry),
          ),
        ],
      ),
    );
  }
}

// ValueText Widget: Displays a string value
class ValueText extends StatelessWidget {
  final String value;

  ValueText({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(fontSize: 16, color: Colors.black87),
    );
  }
}

// Reusable Layout Widget for ListView
class LayoutListView extends StatelessWidget {
  final List<Widget> items;

  LayoutListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: items,
    );
  }
}

// Reusable Interaction Widget for Buttons
class InteractionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  InteractionButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
