import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorites = [];
  List<Product> get favorites => _favorites;

  void toggleFavorite(Product product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isExist(Product product) => _favorites.contains(product);

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
