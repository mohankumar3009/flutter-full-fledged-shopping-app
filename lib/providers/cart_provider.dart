import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/list_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Item> _cartItems = [];
  final Map<String, int> _quantities = {}; // we using the item.name for the checking the quantitiy and avoiding the duplicated list items..
  int _counter = 0;

  UnmodifiableListView<Item> get cartItems => UnmodifiableListView(_cartItems);
  int get counter => _counter;

  double get totalPrice => _cartItems.fold<double>(
        0.0,
        (prev, item) => prev + item.price * (_quantities[item.name] ?? 1),
      );

  void addItem(Item item) {
    if (_quantities.containsKey(item.name)) {
      _quantities[item.name] = _quantities[item.name]! + 1;
    } else {
      _cartItems.add(item);
      _quantities[item.name] = 1;
    }
    _updateCounter();
  }

  void removeItem(Item item) {
    if (_quantities[item.name] != null) {
      if (_quantities[item.name]! > 1) {
        _quantities[item.name] = _quantities[item.name]! - 1;
      } else {
        _quantities.remove(item.name);
        _cartItems.remove(item);
      }
      _updateCounter();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _quantities.clear();
    _counter = 0;
    notifyListeners();
  }

  int getItemQuantity(Item item) => _quantities[item.name] ?? 0;

  void _updateCounter() {
    _counter = _quantities.values.fold(0, (sum, q) => sum + q);
    notifyListeners();
  }
}
