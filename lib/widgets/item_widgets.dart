import 'package:flutter/material.dart';
import 'package:flutter_application/models/list_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/providers/favorite_provider.dart';
import 'package:flutter_application/providers/cart_provider.dart';

class ItemWidgets extends StatelessWidget {
  final Item item;

  const ItemWidgets({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    final items = Provider.of<CartProvider>(context);
    return Card(
      color: const Color.fromARGB(255, 243, 238, 238),
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black38,
      child: Column(
        children: [
          Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  item.imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => favProvider.toggleFavorite(item),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black26,
                    child: Icon(
                      favProvider.isExist(item)
                          ? Icons.favorite
                          : Icons.favorite_border_sharp,
                      color: Colors.white,

                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                item.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "\$${item.price.toString()}",
                style: TextStyle(
                  color: const Color.fromARGB(255, 94, 163, 220),
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 110,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 94, 163, 220),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  items.addItem(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${item.name} Added to Cart")),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Text(
                      'Add to cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    const Icon(
                      Icons.add_shopping_cart_sharp,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
