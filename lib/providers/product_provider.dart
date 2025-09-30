import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/services/api_services.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> allproducts = [];
  List<Product> electronics = [];
  List<Product> jewelery = [];
  List<Product> mensClothing = [];
  List<Product> womensClothing = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiServices _apiServices = ApiServices();

  Future<void> loadProducts() async {
    if (_products.isNotEmpty) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiServices.fetchproducts();

      // Categorize products safely
      allproducts = _products; // All products

      electronics = _products
          .where((p) => p.category.toString().toLowerCase() == 'electronics')
          .toList();

      jewelery = _products
          .where((p) => p.category.toString().toLowerCase() == 'jewelery')
          .toList();

      mensClothing = _products
          .where((p) => p.category.toString().toLowerCase() == "men's clothing")
          .toList();

      womensClothing = _products
          .where(
            (p) => p.category.toString().toLowerCase() == "women's clothing",
          )
          .toList();

      debugPrint("products loaded: ${_products.length}");
    } catch (e) {
      debugPrint("Error loading products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
