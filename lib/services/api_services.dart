import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application/models/product_model.dart';

class ApiServices {
  static const String url = "https://fakestoreapi.com/products";

  Future<List<Product>> fetchproducts() async {
    final Response = await http.get(Uri.parse(url));

    if (Response.statusCode == 200) {
      final List data = json.decode(Response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception(
        "Failed to load Products(status code: ${Response.statusCode})",
      );
    }
  }
}
