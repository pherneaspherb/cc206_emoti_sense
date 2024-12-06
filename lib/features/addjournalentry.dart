import 'package:flutter/material.dart';

class AddEntryPage extends StatelessWidget {
  final Function(String, String) addJournalEntryCallback;

  AddEntryPage({required this.addJournalEntryCallback});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _entryController = TextEditingController();

  // Function to save the journal entry
  void _saveEntry(BuildContext context) {
    String title = _titleController.text.trim();
    String entry = _entryController.text.trim();

    if (title.isNotEmpty && entry.isNotEmpty) {
      addJournalEntryCallback(title, entry);
      _titleController.clear();
      _entryController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Journal entry saved successfully!")),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill out both title and entry fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Journal Entry',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF003366), 
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366), 
              Color(0xFF006699), 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InteractionTextField(
              controller: _titleController,
              label: 'Enter Journal Title',
            ),
            SizedBox(height: 16),
            InteractionTextField(
              controller: _entryController,
              label: 'Enter Journal Entry',
              maxLines: 5,
            ),
            SizedBox(height: 24),
            InteractionButton(
              onPressed: () => _saveEntry(context),
              text: 'Save Entry',
              icon: Icons.save,
            ),
          ],
        ),
      ),
    );
  }
}

class InteractionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const InteractionTextField({
    required this.controller,
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black87),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: maxLines,
    );
  }
}

class InteractionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  const InteractionButton({
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Color(0xFF003366),
      ),
      label: Text(
        text,
        style: TextStyle(color: Color(0xFF003366)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
