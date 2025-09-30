

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'price': price,
      'imageUrl': image,
      'description': description,
      'category': category,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      category: json['category'].toString().toLowerCase() ,
    );
  }
}
