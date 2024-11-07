import 'package:flutter/material.dart';

class MoodsPage extends StatefulWidget {
  final List<String> moods; 
  final List<String> favorites; 
  final ValueChanged<String> onMoodDeleted; 
  final VoidCallback onClearAll; 
  final ValueChanged<String> onToggleFavorite; 
  final ValueChanged<String> onMoodEdited; 

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
  List<String> _currentFavorites = []; 

  @override
  void initState() {
    super.initState();
    _currentFavorites = List.from(widget.favorites); 
  }

  void _toggleFavorite(String mood) {
    setState(() {
      if (_currentFavorites.contains(mood)) {
        _currentFavorites.remove(mood); 
      } else {
        _currentFavorites.add(mood); 
      }
    });
    widget.onToggleFavorite(mood); 
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
                Navigator.of(context).pop(); 
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
                      widget.moods[index] = newMood;
                      widget.onMoodEdited(newMood); 
                    }
                  });
                  Navigator.of(context).pop(); 
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
              widget.onClearAll(); 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('All moods cleared.'),
                ),
              );
              setState(() {
                _currentFavorites.clear(); 
              });
            },
            child: const Text('Clear All'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.moods.length,
              itemBuilder: (context, index) {
                final mood = widget.moods[index];
                final isFavorite = _currentFavorites.contains(mood); 

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
                          _toggleFavorite(mood); 
                          setState(() {}); 
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue), 
                        onPressed: () {
                          _editMood(mood); 
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.onMoodDeleted(mood); 
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mood "$mood" deleted.'),
                            ),
                          );
                          setState(() {
                            _currentFavorites.remove(mood); 
                          }); 
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(), 
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
                      _toggleFavorite(favoriteMood);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Favorite mood "$favoriteMood" removed.'),
                        ),
                      );
                      setState(() {});
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
