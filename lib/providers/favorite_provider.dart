import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorites = [];
  List<Product> get favorites => _favorites;

  Future<void> toggleFavorite(Product product) async {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
    await _saveFavoritesToPrefs();
  }

  bool isExist(Product product) => _favorites.any((p) => p.id == product.id);

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }

  //save wishlist data to sharedpreferences

  Future<void> _saveFavoritesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favs = _favorites.map((p) => p.toMap()).toList();
    await prefs.setString('favorites_data', jsonEncode(favs));
  }

  //Load favorites from sharedPreferences

  Future<void> loadFavoritesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('favorites_data');
    if (data == null) return;

    List decoded = jsonDecode(data) as List;
    _favorites.clear();
    for (var item in decoded) {
      _favorites.add(Product.fromJson(item));
    }
    notifyListeners();
  }
}
