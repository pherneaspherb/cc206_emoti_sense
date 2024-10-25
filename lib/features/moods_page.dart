import 'package:flutter/material.dart';

class MoodsPage extends StatefulWidget {
  final List<String> moods; // The list of moods
  final List<String> favorites; // The list of favorite moods
  final ValueChanged<String> onMoodDeleted; // Callback for deleting a mood
  final VoidCallback onClearAll; // Callback for clearing all moods
  final ValueChanged<String> onToggleFavorite; // Callback for toggling favorite status
  final ValueChanged<String> onMoodEdited; // Callback for editing a mood

  MoodsPage({
    required this.moods,
    required this.favorites,
    required this.onMoodDeleted,
    required this.onClearAll,
    required this.onToggleFavorite,
    required this.onMoodEdited,
  });

  @override
  _MoodsPageState createState() => _MoodsPageState();
}

class _MoodsPageState extends State<MoodsPage> {
  List<String> _currentFavorites = []; // Maintain a local copy of current favorites

  @override
  void initState() {
    super.initState();
    _currentFavorites = List.from(widget.favorites); // Initialize with passed favorites
  }

  void _toggleFavorite(String mood) {
    setState(() {
      if (_currentFavorites.contains(mood)) {
        _currentFavorites.remove(mood); // Remove from favorites
      } else {
        _currentFavorites.add(mood); // Add to favorites
      }
    });
    widget.onToggleFavorite(mood); // Call the parent toggle function
  }

  void _editMood(String oldMood) {
    TextEditingController controller = TextEditingController(text: oldMood);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Mood'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter new mood"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newMood = controller.text.trim();
                if (newMood.isNotEmpty) {
                  setState(() {
                    int index = widget.moods.indexOf(oldMood);
                    if (index != -1) {
                      widget.moods[index] = newMood; // Update the mood
                      widget.onMoodEdited(newMood); // Notify the parent
                    }
                  });
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Save'),
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
        title: const Text('Your Moods'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              widget.onClearAll(); // Call the clear all function
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('All moods cleared.'),
                ),
              );
              setState(() {
                _currentFavorites.clear(); // Clear local favorites
              });
            },
            child: const Text('Clear All'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.moods.length,
              itemBuilder: (context, index) {
                final mood = widget.moods[index];
                final isFavorite = _currentFavorites.contains(mood); // Check local favorites

                return ListTile(
                  title: Text(mood),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          _toggleFavorite(mood); // Toggle favorite status locally
                          setState(() {}); // Refresh the UI
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue), // Edit icon
                        onPressed: () {
                          _editMood(mood); // Call the edit function
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.onMoodDeleted(mood); // Call the delete function
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mood "$mood" deleted.'),
                            ),
                          );
                          setState(() {
                            _currentFavorites.remove(mood); // Remove from local favorites if deleted
                          }); // Refresh the UI
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(), // Separator between moods and favorites
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Favorites',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _currentFavorites.length,
              itemBuilder: (context, index) {
                final favoriteMood = _currentFavorites[index];

                return ListTile(
                  title: Text(favoriteMood),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _toggleFavorite(favoriteMood); // Remove from favorites
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Favorite mood "$favoriteMood" removed.'),
                        ),
                      );
                      setState(() {}); // Refresh the UI
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
