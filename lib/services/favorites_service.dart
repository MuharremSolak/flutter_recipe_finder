import 'package:flutter/material.dart';

class FavoritesService extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  bool isFavorite(String id) {
    return _favorites.contains(id);
  }

  void addToFavorites(String id) {
    _favorites.add(id);
    notifyListeners();
  }

  void removeFromFavorites(String id) {
    _favorites.remove(id);
    notifyListeners();
  }
}
