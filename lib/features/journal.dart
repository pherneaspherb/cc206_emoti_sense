import 'package:flutter/material.dart';
import 'addjournalentry.dart'; // Import AddEntryPage

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  List<String> _journalTitles = [];
  List<String> _journalEntries = [];

  // Function to add a new journal entry
  void _addJournalEntry(String title, String entry) {
    setState(() {
      _journalTitles.add(title);
      _journalEntries.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Column(
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
          
          // Layout for journal entries
          if (_journalTitles.isEmpty)
            LayoutEmptyState(message: 'No journal entries yet. Start adding some!'),

          if (_journalTitles.isNotEmpty)
            Expanded(
              child: LayoutListView(
                items: List.generate(_journalTitles.length, (index) {
                  return InteractionJournalItem(
                    title: _journalTitles[index],
                    entry: _journalEntries[index],
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

// Reusable Value Widget to show journal title and content
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

// Reusable Layout Widget for Empty State
class LayoutEmptyState extends StatelessWidget {
  final String message;

  LayoutEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ValueText(value: message),
      ),
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
