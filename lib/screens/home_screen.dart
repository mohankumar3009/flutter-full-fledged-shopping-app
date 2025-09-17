import 'package:flutter/material.dart';
import 'package:flutter_application/models/list_model.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/screens/all_product_screen.dart';
import 'package:flutter_application/screens/cart_screen.dart';
import 'package:flutter_application/screens/details_screen.dart';
import 'package:flutter_application/widgets/card_with_dots.dart';
// ignore: unused_import
import 'package:badges/badges.dart' as badges;
import 'package:flutter_application/widgets/item_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
      category: "Fashion",
    ),
    Item(
      name: "Shirt",
      price: 29.99,
      imageUrl:
          "https://images.pexels.com/photos/26546544/pexels-photo-26546544.jpeg",
      description: "Casual cotton shirt perfect for everyday wear.",
      category: "Fashion",
    ),
    Item(
      name: "Watch",
      price: 99.99,
      imageUrl:
          "https://images.pexels.com/photos/2113994/pexels-photo-2113994.jpeg?cs=srgb&dl=pexels-joey-nguy%E1%BB%85n-2113994.jpg&fm=jpg",
      description:
          "Classic wristwatch with leather strap and waterproof design.",
      category: "fashion",
    ),
    Item(
      name: "Cap",
      price: 14.99,
      imageUrl:
          "https://images.pexels.com/photos/1124465/pexels-photo-1124465.jpeg",
      description: "Stylish baseball cap made from premium cotton.",
      category: "Fashion",
    ),
    Item(
      name: "Mobile",
      price: 100.33,
      imageUrl:
          "https://images.pexels.com/photos/4549411/pexels-photo-4549411.jpeg",
      description:
          "Latest smartphone with HD display and long-lasting battery.",
      category: "electronics",
    ),
    Item(
      name: "Car",
      price: 200.33,
      imageUrl:
          "https://up.yimg.com/ib/th/id/OIP.-wtRKCICcILF5WqJLjODxgHaED?pid=Api&rs=1&c=1&qlt=95&w=210&h=115",
      description: "Premium toy car model with detailed design.",
      category: "transport",
    ),
    Item(
      name: "Bike",
      price: 150.99,
      imageUrl:
          "http://pluspng.com/img-png/png-hd-bike-ktm-rc-390-motorcycle-bike-png-image-1592.png",
      description: "Sport bike miniature with realistic finish.",
      category: "transport",
    ),
    Item(
      name: "Laptop",
      price: 80.99,
      imageUrl:
          "https://up.yimg.com/ib/th/id/OIP.-AtwxKY70S2aTwoDs2BL4AHaE8?pid=Api&rs=1&c=1&qlt=95&w=157&h=104",
      description: "Lightweight laptop ideal for students and professionals.",
      category: "electronics",
    ),
    Item(
      name: "Coolers",
      price: 30.45,
      imageUrl:
          "https://images.pexels.com/photos/424436/pexels-photo-424436.jpeg",
      description: "Trendy coolers with UV protection lenses.",
      category: "fashion",
    ),
    Item(
      name: "Sunglasses",
      price: 45.99,
      imageUrl:
          "https://images.pexels.com/photos/46710/pexels-photo-46710.jpeg?auto=compress&w=120&h=120",
      description: "Stylish sunglasses with polarized lenses.",
      category: "wearings",
    ),
    Item(
      name: "Backpack",
      price: 65.50,
      imageUrl:
          "https://sp.yimg.com/ib/th/id/OIP.Penytr3b5P6-5NvVg_myHwHaLG?pid=Api&w=148&h=148&c=7&dpr=2&rs=1",
      description: "Spacious backpack with multiple compartments.",
      category: "Needed",
    ),
    Item(
      name: "Headphones",
      price: 89.99,
      imageUrl:
          "https://images.pexels.com/photos/1037992/pexels-photo-1037992.jpeg",
      description: "Wireless headphones with noise cancellation.",
      category: "electronics",
    ),
    Item(
      name: "Tablet",
      price: 120.49,
      imageUrl:
          "https://images.pexels.com/photos/3263239/pexels-photo-3263239.jpeg",
      description: "Portable tablet with high-resolution screen.",
      category: "electronics",
    ),
    Item(
      name: "Smartwatch",
      price: 75.99,
      imageUrl:
          "https://media.istockphoto.com/id/601925382/photo/using-smart-watch-for-omnichannel.jpg?b=1&s=612x612&w=0&k=20&c=XgIkpMqBUfTbg7VXZql-cuTKrY4ejgZ4FL6EkfeQc-E=",
      description: "Smartwatch with fitness tracking and notifications.",
      category: "electronics",
    ),
    Item(
      name: "Camera",
      price: 199.99,
      imageUrl:
          "https://tse1.mm.bing.net/th/id/OIP.47PFr_H8LS33py9fj-qOwQHaE8?pid=Api&P=0&h=180",
      description: "High-resolution DSLR camera for photography lovers.",
      category: "electronics",
    ),
  ];

  List<Item> get flashdealsforyou => [
    catalog[1],
    catalog[2],
    catalog[3],
    catalog[4],
    catalog[5],
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
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: SizedBox(
          height: 50,
          child: TextFormField(
            textAlign: TextAlign.start,
            onTap: () {},
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 22, 114, 190),
                ),
                borderRadius: BorderRadius.circular(30),
              ),

              hintText: 'Search',
              hintStyle: GoogleFonts.lato(color: Colors.grey, fontSize: 18),
              prefixIcon: Icon(Icons.search, size: 30, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),

              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.camera_alt_outlined, color: Colors.black),
              ),
            ),
          ),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) => badges.Badge(
              showBadge: cart.counter > 0,
              badgeStyle: badges.BadgeStyle(
                badgeColor: const Color.fromARGB(255, 22, 114, 190),
                shape: badges.BadgeShape.circle,
                elevation: 4,
                padding: EdgeInsets.all(4),
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white, width: 1),
              ),
              badgeContent: SizedBox(
                width: 15,
                height: 15,
                child: Center(
                  child: Text(
                    cart.counter.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://tse2.mm.bing.net/th/id/OIP.u-4qDiYp1GZ8N8mgLhsrPQHaKX?rs=1&pid=ImgDetMain&o=7&rm=3',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
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
                          'Flash Deals for you',
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllProductScreen(products: catalog),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 22, 114, 190),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.67,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics:
                          MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? NeverScrollableScrollPhysics()
                          : AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 1,
                        childAspectRatio: 1,
                      ),
                      itemCount: flashdealsforyou.length,

                      scrollDirection:
                          MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(item: flashdealsforyou[index]),
                          ),
                        ),
                        child: ItemWidgets(item: flashdealsforyou[index]),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '  Most popular',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AllProductScreen(products: catalog),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 22, 114, 190),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.1,
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
                        '  Trending',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AllProductScreen(products: catalog),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 22, 114, 190),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.1,
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
                        '  Electronics',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProductScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 22, 114, 190),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.1,
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
                        '  Fashion',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AllProductScreen(products: catalog),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 22, 114, 190),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 1,
                        childAspectRatio:
                            MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 1
                            : 1.1,
                      ),
                      scrollDirection:
                          MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
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
          ),
        ],
      ),
    );
  }
}
