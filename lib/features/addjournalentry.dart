import 'package:flutter/material.dart';

class AddEntryPage extends StatelessWidget {
  final Function(String, String) addJournalEntryCallback;

  AddEntryPage({required this.addJournalEntryCallback});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _entryController = TextEditingController();

  void _saveEntry(BuildContext context) {
    String title = _titleController.text;
    String entry = _entryController.text;

    if (title.isNotEmpty && entry.isNotEmpty) {
      // Add entry using the callback function
      addJournalEntryCallback(title, entry);
      
      // Navigate back to JournalPage
      Navigator.pop(context);
    } else {
      // Show error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill both title and entry")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Journal Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title input field (Interaction Widget)
            InteractionTextField(
              controller: _titleController,
              label: 'Enter Journal Title',
            ),
            SizedBox(height: 10),
            // Entry input field (Interaction Widget)
            InteractionTextField(
              controller: _entryController,
              label: 'Enter Journal Entry',
              maxLines: 5,
            ),
            SizedBox(height: 20),
            // Save button (Interaction Widget)
            InteractionButton(
              label: 'Save Entry',
              onPressed: () => _saveEntry(context),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Interaction Widget for TextField
class InteractionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  InteractionTextField({required this.controller, required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      maxLines: maxLines,
    );
  }
}

// Reusable Interaction Widget for Button
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
