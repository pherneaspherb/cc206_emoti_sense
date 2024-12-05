import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addjournalentry.dart';

class JournalPage extends StatefulWidget {
  final String uid;

  const JournalPage({required this.uid});

  @override
  JournalPageState createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _journalEntries = []; // Store title and entry together

  @override
  void initState() {
    super.initState();
    _fetchJournalEntries();
  }

  Future<void> _fetchJournalEntries() async {
    try {
      final querySnapshot = await _firestore
          .collection('journals')
          .doc(widget.uid)
          .collection('entries')
          .orderBy('timestamp', descending: true)
          .get();

      setState(() {
        _journalEntries = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'title': data['title'] ?? 'Untitled',
            'entry': data['entry'] ?? '',
          };
        }).toList();
      });
    } catch (e) {
      print("Error fetching journal entries: $e");
    }
  }

  Future<void> _saveJournalEntry(String title, String entry) async {
    try {
      final docRef = await _firestore
          .collection('journals')
          .doc(widget.uid)
          .collection('entries')
          .add({
        'title': title,
        'entry': entry,
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() {
        _journalEntries.insert(0, {'id': docRef.id, 'title': title, 'entry': entry});
      });
    } catch (e) {
      print("Error saving journal entry: $e");
    }
  }

  Future<void> _deleteJournalEntryFromFirestore(String id, int index) async {
    try {
      await _firestore
          .collection('journals')
          .doc(widget.uid)
          .collection('entries')
          .doc(id)
          .delete();
      setState(() {
        _journalEntries.removeAt(index);
      });
    } catch (e) {
      print("Error deleting journal entry: $e");
    }
  }

  Future<void> _updateJournalEntry(String id, int index, String title, String entry) async {
    try {
      await _firestore
          .collection('journals')
          .doc(widget.uid)
          .collection('entries')
          .doc(id)
          .update({'title': title, 'entry': entry});
      setState(() {
        _journalEntries[index] = {'id': id, 'title': title, 'entry': entry};
      });
    } catch (e) {
      print("Error updating journal entry: $e");
    }
  }

  void _showEditDialog(BuildContext context, int index) {
    final entry = _journalEntries[index];
    final TextEditingController titleController =
        TextEditingController(text: entry['title']);
    final TextEditingController entryController =
        TextEditingController(text: entry['entry']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Journal Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: entryController,
                decoration: const InputDecoration(labelText: 'Entry'),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateJournalEntry(
                  entry['id'],
                  index,
                  titleController.text,
                  entryController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        backgroundColor: const Color(0xFF003366),
        actions: [
          if (_journalEntries.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => print('Add delete all functionality if required'),
            ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003366), Color(0xFF006699)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            InteractionButton(
              icon: Icons.add,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEntryPage(
                      addJournalEntryCallback: _saveJournalEntry,
                    ),
                  ),
                );
              },
            ),
            if (_journalEntries.isEmpty)
              const LayoutEmptyState(message: 'No journal entries yet. Start adding some!'),
            if (_journalEntries.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _journalEntries.length,
                  itemBuilder: (context, index) {
                    final entry = _journalEntries[index];
                    return InteractionJournalItem(
                      title: entry['title'],
                      entry: entry['entry'],
                      onEdit: () => _showEditDialog(context, index),
                      onDelete: () =>
                          _deleteJournalEntryFromFirestore(entry['id'], index),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class InteractionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const InteractionButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white,
      ),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}

class LayoutEmptyState extends StatelessWidget {
  final String message;

  const LayoutEmptyState({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class InteractionJournalItem extends StatelessWidget {
  final String title;
  final String entry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InteractionJournalItem({
    required this.title,
    required this.entry,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(entry),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
