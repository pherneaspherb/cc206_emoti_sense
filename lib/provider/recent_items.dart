import 'package:flutter/foundation.dart'; // Import required for ChangeNotifier

class RecentItems with ChangeNotifier {
  final List<Map<String, String>> _recentItems = [];

  List<Map<String, String>> get recentItems => _recentItems;

  // Add a recent item
  void addRecentItem(String title, String type) {
    if (_recentItems.length >= 3) {
      _recentItems.removeAt(0); // Remove the oldest item if there are more than 3
    }
    _recentItems.add({'title': title, 'type': type});
    notifyListeners();
  }
}
