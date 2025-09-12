import 'package:flutter/material.dart';
import 'package:flutter_application/models/list_model.dart';
import 'package:flutter_application/screens/cart_screen.dart';
import 'package:flutter_application/screens/details_screen.dart';
import 'package:flutter_application/widgets/card_with_dots.dart';
// ignore: unused_import
import 'package:badges/badges.dart' as badges;
import 'package:flutter_application/widgets/item_widgets.dart';
// ignore: unused_import
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> catalog = [
    Item(
      name: "Shoes",
      price: 59.99,
      imageUrl:
          "https://images.pexels.com/photos/2237456/pexels-photo-2237456.jpeg",
      description:
          "Comfortable running shoes with breathable material and cushioned soles.",
    ),
    Item(
      name: "Shirt",
      price: 29.99,
      imageUrl:
          "https://images.pexels.com/photos/26546544/pexels-photo-26546544.jpeg",
      description: "Casual cotton shirt perfect for everyday wear.",
    ),
    Item(
      name: "Watch",
      price: 99.99,
      imageUrl:
          "https://images.pexels.com/photos/2113994/pexels-photo-2113994.jpeg?cs=srgb&dl=pexels-joey-nguy%E1%BB%85n-2113994.jpg&fm=jpg",
      description:
          "Classic wristwatch with leather strap and waterproof design.",
    ),
    Item(
      name: "Cap",
      price: 14.99,
      imageUrl:
          "https://images.pexels.com/photos/1124465/pexels-photo-1124465.jpeg",
      description: "Stylish baseball cap made from premium cotton.",
    ),
    Item(
      name: "Mobile",
      price: 100.33,
      imageUrl:
          "https://images.pexels.com/photos/4549411/pexels-photo-4549411.jpeg",
      description:
          "Latest smartphone with HD display and long-lasting battery.",
    ),
    Item(
      name: "Car",
      price: 200.33,
      imageUrl:
          "https://up.yimg.com/ib/th/id/OIP.-wtRKCICcILF5WqJLjODxgHaED?pid=Api&rs=1&c=1&qlt=95&w=210&h=115",
      description: "Premium toy car model with detailed design.",
    ),
    Item(
      name: "Bike",
      price: 150.99,
      imageUrl:
          "http://pluspng.com/img-png/png-hd-bike-ktm-rc-390-motorcycle-bike-png-image-1592.png",
      description: "Sport bike miniature with realistic finish.",
    ),
    Item(
      name: "Laptop",
      price: 80.99,
      imageUrl:
          "https://up.yimg.com/ib/th/id/OIP.-AtwxKY70S2aTwoDs2BL4AHaE8?pid=Api&rs=1&c=1&qlt=95&w=157&h=104",
      description: "Lightweight laptop ideal for students and professionals.",
    ),
    Item(
      name: "Coolers",
      price: 30.45,
      imageUrl:
          "https://images.pexels.com/photos/424436/pexels-photo-424436.jpeg",
      description: "Trendy coolers with UV protection lenses.",
    ),
    Item(
      name: "Sunglasses",
      price: 45.99,
      imageUrl:
          "https://images.pexels.com/photos/46710/pexels-photo-46710.jpeg?auto=compress&w=120&h=120",
      description: "Stylish sunglasses with polarized lenses.",
    ),
    Item(
      name: "Backpack",
      price: 65.50,
      imageUrl:
          "https://sp.yimg.com/ib/th/id/OIP.Penytr3b5P6-5NvVg_myHwHaLG?pid=Api&w=148&h=148&c=7&dpr=2&rs=1",
      description: "Spacious backpack with multiple compartments.",
    ),
    Item(
      name: "Headphones",
      price: 89.99,
      imageUrl:
          "https://images.pexels.com/photos/1037992/pexels-photo-1037992.jpeg",
      description: "Wireless headphones with noise cancellation.",
    ),
    Item(
      name: "Tablet",
      price: 120.49,
      imageUrl:
          "https://images.pexels.com/photos/3263239/pexels-photo-3263239.jpeg",
      description: "Portable tablet with high-resolution screen.",
    ),
    Item(
      name: "Smartwatch",
      price: 75.99,
      imageUrl:
          "https://media.istockphoto.com/id/601925382/photo/using-smart-watch-for-omnichannel.jpg?b=1&s=612x612&w=0&k=20&c=XgIkpMqBUfTbg7VXZql-cuTKrY4ejgZ4FL6EkfeQc-E=",
      description: "Smartwatch with fitness tracking and notifications.",
    ),
    Item(
      name: "Camera",
      price: 199.99,
      imageUrl:
          "https://tse1.mm.bing.net/th/id/OIP.47PFr_H8LS33py9fj-qOwQHaE8?pid=Api&P=0&h=180",
      description: "High-resolution DSLR camera for photography lovers.",
    ),
  ];

  List<Item> get mostPopular => [
    catalog[12],
    catalog[13],
    catalog[11],
    catalog[8],
    catalog[7],
  ];

  List<Item> get trending => [catalog[0], catalog[2], catalog[9], catalog[13]];

  List<Item> get electronics => [
    catalog[4],
    catalog[7],
    catalog[11],
    catalog[12],
    catalog[13],
    catalog[14],
  ];

  List<Item> get fashion => [
    catalog[0],
    catalog[1],
    catalog[3],
    catalog[8],
    catalog[9],
    catalog[10],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 163, 220),
        title: Text(
          'shop',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined, size: 30),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 250, child: const CardWithDots()),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '     Featured',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 94, 163, 220),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                ),
                itemCount: 5,

                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(item: catalog[index]),
                    ),
                  ),
                  child: ItemWidgets(item: catalog[index]),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '     Most popular',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all      ',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 94, 163, 220),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 250,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                ),
                itemCount: 5,

                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(item: mostPopular[index]),
                    ),
                  ),
                  child: ItemWidgets(item: mostPopular[index]),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '     Trending',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all      ',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 94, 163, 220),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            SizedBox(
              height: 250,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(item: trending[index]),
                      ),
                    );
                  },
                  child: ItemWidgets(item: trending[index]),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '     Electronics',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all      ',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 94, 163, 220),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            SizedBox(
              height: 250,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: electronics.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(item: electronics[index]),
                      ),
                    );
                  },
                  child: ItemWidgets(item: electronics[index]),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '     Fashion',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all      ',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 94, 163, 220),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4,
                  childAspectRatio:
                      MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.8
                      : 0.9,
                ),
                scrollDirection: Axis.vertical,
                itemCount: fashion.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(item: fashion[index]),
                      ),
                    );
                  },
                  child: ItemWidgets(item: fashion[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
