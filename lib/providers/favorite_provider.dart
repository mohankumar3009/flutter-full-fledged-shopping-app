import 'dart:convert';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  //generate per user sharedpreferences key

  String get _favKey {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? "guest";
    return 'favorites_$uid';
  }

  //add or remove favorites
  Future<void> toggleFavorite(Product product) async {
    if (isExist(product)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
    await _saveFavoritesToPrefs();
  }

  bool isExist(Product product) => _favorites.any((p) => p.id == product.id);

  //clear favorites(used on logout)
  Future<void> clearFavorites() async {
    _favorites.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favKey);
  }


  //save wishlist data to sharedpreferences

  Future<void> _saveFavoritesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favs = _favorites.map((p) => p.toMap()).toList();
    await prefs.setString(_favKey, jsonEncode(favs));
  }

  //Load favorites from sharedPreferences

  Future<void> loadFavoritesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_favKey);
    if (data == null) return;

    List decoded = jsonDecode(data) as List;
    _favorites.clear();
    for (var item in decoded) {
      _favorites.add(Product.fromJson(item));
    }
    notifyListeners();
  }
}
