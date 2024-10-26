// chill_beats_page.dart
import 'package:flutter/material.dart';

class ChillBeatsPage extends StatefulWidget {
  const ChillBeatsPage({super.key});

  @override
  _ChillBeatsPageState createState() => _ChillBeatsPageState();
}

class _ChillBeatsPageState extends State<ChillBeatsPage> {
  final List<String> chillBeatsSongs = [
    'Midnight Vibes',
    'Calm Waves',
    'Dreamy Nights',
    'Smooth Chill',
    'Soft Beats',
    'Moonlight Jazz',
    'Relaxed Moods',
    'Quiet Thoughts',
    'Lo-Fi Sunset',
    'Serene Escape',
  ];

  final List<String> favoriteSongs = [];

  void _addToFavorites(String song) {
    setState(() {
      favoriteSongs.add(song);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$song added to favorites')),
    );
  }

  void _removeFromFavorites(String song) {
    setState(() {
      favoriteSongs.remove(song);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$song removed from favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chill Beats'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: chillBeatsSongs.length,
              itemBuilder: (context, index) {
                final song = chillBeatsSongs[index];
                return ListTile(
                  leading: Icon(Icons.music_note, color: Colors.purpleAccent),
                  title: Text(
                    song,
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      favoriteSongs.contains(song)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteSongs.contains(song)
                          ? Colors.red
                          : null,
                    ),
                    onPressed: () {
                      if (favoriteSongs.contains(song)) {
                        _removeFromFavorites(song);
                      } else {
                        _addToFavorites(song);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(thickness: 2, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Favorites',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: favoriteSongs.length,
              itemBuilder: (context, index) {
                final favoriteSong = favoriteSongs[index];
                return Dismissible(
                  key: Key(favoriteSong),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeFromFavorites(favoriteSong);
                  },
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you want to remove this song from favorites?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.music_note, color: Colors.purpleAccent),
                    title: Text(
                      favoriteSong,
                      style: const TextStyle(fontSize: 18),
                    ),
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
