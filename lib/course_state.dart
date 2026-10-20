import 'package:flutter/foundation.dart';

//I Komang Candra Aryadinata || 2415051085
class CourseState extends ChangeNotifier {
  final Set<String> favorites = {};

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    notifyListeners();
  }
}
