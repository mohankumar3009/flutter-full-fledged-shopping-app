import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];
  final Map<int, int> _quantities = {}; // product.id -> quantity

  UnmodifiableListView<Product> get cartItems =>
      UnmodifiableListView(_cartItems);
  int get counter => _quantities.values.fold(0, (sum, q) => sum + q);
  double get subtotalPrice => _cartItems.fold(
    0.0,
    (sum, item) => sum + item.price * (_quantities[item.id] ?? 1),
  );
  double taxRate = 0.18;
  double get taxAmount => subtotalPrice * taxRate;
  double get totalAmount => subtotalPrice + taxAmount;

  int getItemQuantity(Product product) => _quantities[product.id] ?? 0;

  void _updateCounter() => notifyListeners();

  Future<void> addItem(Product product) async {
    if (_quantities.containsKey(product.id)) {
      _quantities[product.id] = _quantities[product.id]! + 1;
    } else {
      _cartItems.add(product);
      _quantities[product.id] = 1;
    }
    _updateCounter();
    await _saveCartToPrefs();
  }

  Future<void> removeItem(Product product) async {
    if (_quantities.containsKey(product.id)) {
      if (_quantities[product.id]! > 1) {
        _quantities[product.id] = _quantities[product.id]! - 1;
      } else {
        _quantities.remove(product.id);
        _cartItems.removeWhere((p) => p.id == product.id);
      }
      _updateCounter();
      await _saveCartToPrefs();
    }
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    _quantities.clear();
    _updateCounter();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_data');
  }

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> cartJson = _cartItems.map((p) {
      return {'product': p.toMap(), 'quantity': _quantities[p.id] ?? 1};
    }).toList();
    await prefs.setString('cart_data', jsonEncode(cartJson));
  }

  Future<void> loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('cart_data');
    if (data == null) return;

    List decoded = jsonDecode(data) as List;
    _cartItems.clear();
    _quantities.clear();

    for (var item in decoded) {
      Product product = Product.fromJson(item['product']);
      int quantity = item['quantity'];
      _cartItems.add(product);
      _quantities[product.id] = quantity;
    }
    _updateCounter();
    notifyListeners();
  }
}
