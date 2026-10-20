import 'package:flutter/foundation.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseState extends ChangeNotifier {
  final Set<String> favorites = {};

  bool isFavorite(String id) {
    return favorites.contains(id);
  }

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    // notifyListeners(); // Dinonaktifkan sementara
  }

  int get favoriteCount => favorites.length;
}
