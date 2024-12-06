import 'package:flutter/foundation.dart'; 

class RecentItems with ChangeNotifier {
  List<Map<String, String>> _recentItems = [];

  List<Map<String, String>> get recentItems => _recentItems;

  void addRecentItem(String title, String type) {
    if (_recentItems.length >= 3) {
      _recentItems.removeAt(0); 
    }
    _recentItems.add({'title': title, 'type': type});
    notifyListeners();
  }
}
