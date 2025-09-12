import 'package:flutter/material.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/screens/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/models/list_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: Text(
          'CART ITEMS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: items.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is Empty..',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: items.cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                final Item item = items.cartItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(item: item),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 243, 238, 238),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            item.imageUrl,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 42,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.white60,
                                          ),

                                          onPressed: () {
                                            items.removeItem(item);
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${items.getItemQuantity(item)}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 42,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.white60,
                                          ),

                                          onPressed: () {
                                            items.addItem(item);
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  "\$${item.price}",
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: (items.cartItems.isNotEmpty)
          ? Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.all(20),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${items.totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 86, 223, 90),
                    ),
                    onPressed: () {
                      items.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checkout Successfully.')),
                      );
                    },
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
