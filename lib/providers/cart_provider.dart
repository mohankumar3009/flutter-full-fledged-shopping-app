import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];
  final Map<String, int> _quantities =
      {}; // we using the item.name for the checking the quantitiy and avoiding the duplicated list items..
  int _counter = 0;

  UnmodifiableListView<Product> get cartItems => UnmodifiableListView(_cartItems);
  int get counter => _counter;

  double get subtotalPrice => _cartItems.fold<double>(
    0.0,
    (prev, item) => prev + item.price * (_quantities[item.title] ?? 1),
  );

  double taxRate = 0.18;

  double get taxAmount => taxRate * subtotalPrice;

  double get totalAmount => subtotalPrice + taxAmount;

  void  addItem(Product product) {
    if (_quantities.containsKey(product.title)) {
      _quantities[product.title] = _quantities[product.title]! + 1;
    } else {
      _cartItems.add(product);
      _quantities[product.title] = 1;
    }
    _updateCounter();
  }

  void removeItem(Product product) {
    if (_quantities[product.title] != null) {
      if (_quantities[product.title]! > 1) {
        _quantities[product.title] = _quantities[product.title]! - 1;
      } else {
        _quantities.remove(product.title);
        _cartItems.remove(product);
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

  int getItemQuantity(Product product) => _quantities[product.title] ?? 0;

  void _updateCounter() {
    _counter = _quantities.values.fold(0, (sum, q) => sum + q);
    notifyListeners();
  }
}
