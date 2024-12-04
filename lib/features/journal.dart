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

  // Function to edit an existing journal entry
  void _editJournalEntry(int index, String newTitle, String newEntry) {
    setState(() {
      _journalTitles[index] = newTitle;
      _journalEntries[index] = newEntry;
    });
  }

  // Function to delete a journal entry
  void _deleteJournalEntry(int index) {
    setState(() {
      _journalTitles.removeAt(index);
      _journalEntries.removeAt(index);
    });
  }

  // Function to delete all journal entries
  void _deleteAllEntries() {
    setState(() {
      _journalTitles.clear();
      _journalEntries.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366), // Deep Blue AppBar
        actions: [
          // "Delete All" icon button in the upper-right corner
          if (_journalTitles.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: _deleteAllEntries,
            ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366), // Deep blue
              Color(0xFF006699), // Lighter deep blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Button to navigate to AddEntryPage with a plus sign icon
            InteractionButton(
              icon: Icons.add, // Plus sign icon
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
                      onEdit: () {
                        _showEditDialog(context, index); // Show the edit dialog
                      },
                      onDelete: () {
                        _deleteJournalEntry(index);
                      },
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to show the edit dialog
  void _showEditDialog(BuildContext context, int index) {
    final TextEditingController titleController = TextEditingController(text: _journalTitles[index]);
    final TextEditingController entryController = TextEditingController(text: _journalEntries[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Journal Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: entryController,
                decoration: InputDecoration(labelText: 'Entry'),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Cancel the edit and close the dialog
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save the changes to the journal entry
                _editJournalEntry(index, titleController.text, entryController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
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
        child: Text(
          message,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
  final IconData icon; // Icon for the button
  final VoidCallback onPressed;

  InteractionButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
      ),
      child: Icon(icon, color: Colors.black),
    );
  }
}

// Reusable Value Widget to show journal title and content
class InteractionJournalItem extends StatefulWidget {
  final String title;
  final String entry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  InteractionJournalItem({
    required this.title,
    required this.entry,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _InteractionJournalItemState createState() => _InteractionJournalItemState();
}

class _InteractionJournalItemState extends State<InteractionJournalItem> {
  bool _isViewing = false; // Flag to toggle between viewing and editing

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title with dark color
            Expanded(child: Text(widget.title, style: TextStyle(fontSize: 16, color: Colors.black))),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Show the journal entry content
                Text(widget.entry, style: TextStyle(fontSize: 16, color: Colors.black)),
                ButtonBar(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: widget.onEdit, // Edit action
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: widget.onDelete, // Delete action
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
