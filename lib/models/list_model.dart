class Item {
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Item({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }
}
