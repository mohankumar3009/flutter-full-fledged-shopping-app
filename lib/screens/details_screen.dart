import 'package:flutter/material.dart';
import 'package:flutter_application/models/list_model.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/screens/cart_screen.dart';
import 'package:provider/provider.dart';
// ignore: duplicate_import
import 'package:flutter_application/providers/cart_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Item item;

  const DetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 163, 220),
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                      ? 300
                      : 350,
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                      ? 410
                      : 910,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Image.network(item.imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(16),
              height: 700,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 238, 238),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 5),
                              RichText(
                                text: TextSpan(
                                  text: '4.8 ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '(320 reviews)',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "\$${item.price}".toString(),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 29, 173, 34),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  Text(item.description, style: TextStyle(fontSize: 15)),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Available Colors',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: const [
                      CircleAvatar(radius: 15, backgroundColor: Colors.blue),
                      SizedBox(width: 15),
                      CircleAvatar(radius: 15, backgroundColor: Colors.purple),
                      SizedBox(width: 15),
                      CircleAvatar(radius: 15, backgroundColor: Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${item.price}".toString(),
                style: TextStyle(
                  color: const Color.fromARGB(255, 94, 163, 220),
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 94, 163, 220),
                  ),
                  onPressed: () {
                    items.addItem(item);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
