import 'package:flutter/material.dart';
import 'package:flutter_application/models/list_model.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Item> _favorites = [];
  List<Item> get favorites => _favorites;

  void toggleFavorite(Item item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  bool isExist(Item item) => _favorites.contains(item);

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
