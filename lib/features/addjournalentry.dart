import 'package:flutter/material.dart';

class AddEntryPage extends StatelessWidget {
  final Function(String, String) addJournalEntryCallback;

  AddEntryPage({super.key, required this.addJournalEntryCallback});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _entryController = TextEditingController();

  // Function to save the journal entry
  void _saveEntry(BuildContext context) {
    String title = _titleController.text.trim();
    String entry = _entryController.text.trim();

    if (title.isNotEmpty && entry.isNotEmpty) {
      // Add the journal entry via the callback
      addJournalEntryCallback(title, entry);

      // Clear text fields after saving
      _titleController.clear();
      _entryController.clear();

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Journal entry saved successfully!")),
      );

      // Navigate back to JournalPage
      Navigator.pop(context);
    } else {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out both title and entry fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Journal Entry',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF003366), // Deep Blue AppBar
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title input field
            InteractionTextField(
              controller: _titleController,
              label: 'Enter Journal Title',
            ),
            const SizedBox(height: 16),
            // Entry input field
            InteractionTextField(
              controller: _entryController,
              label: 'Enter Journal Entry',
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            // Save button
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

// Reusable Interaction Widget for TextField
class InteractionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const InteractionTextField({super.key, 
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
        labelStyle: const TextStyle(color: Colors.black87),
        filled: true,
        fillColor: Colors.white, // White background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: maxLines,
    );
  }
}

// Reusable Interaction Widget for Button
class InteractionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  const InteractionButton({super.key, 
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
        color: const Color(0xFF003366),
      ),
      label: Text(
        text,
        style: const TextStyle(color: Color(0xFF003366)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // White background for the button
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
