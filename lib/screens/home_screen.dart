import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/providers/product_provider.dart';
import 'package:flutter_application/screens/all_product_screen.dart';
import 'package:flutter_application/screens/cart_screen.dart';
import 'package:flutter_application/screens/details_screen.dart';
import 'package:flutter_application/widgets/card_with_dots.dart';
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
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ProductProvider>(context, listen: false).loadProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final ThemeData theme = Theme.of(context);

    if (productProvider.isLoading) {
      return Scaffold(body: const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                          style: theme.textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllProductScreen(
                                  products: productProvider.allproducts,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: theme.textTheme.titleSmall,
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
                      itemCount: productProvider.allproducts.length,

                      scrollDirection:
                          MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: productProvider.allproducts[index],
                            ),
                          ),
                        ),
                        child: ItemWidgets(
                          product: productProvider.allproducts[index],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('  Electronics', style: theme.textTheme.titleMedium),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProductScreen(
                                products: productProvider.electronics,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: theme.textTheme.titleSmall,
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
                      itemCount: productProvider.electronics.length,

                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: productProvider.electronics[index],
                            ),
                          ),
                        ),
                        child: ItemWidgets(
                          product: productProvider.electronics[index],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('  Jewelery', style: theme.textTheme.titleMedium),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProductScreen(
                                products: productProvider.jewelery,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: theme.textTheme.titleSmall,
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
                      itemCount: productProvider.jewelery.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: productProvider.jewelery[index],
                              ),
                            ),
                          );
                        },
                        child: ItemWidgets(
                          product: productProvider.jewelery[index],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '  Mens Clothing',
                        style: theme.textTheme.titleMedium,
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProductScreen(
                                products: productProvider.mensClothing,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: theme.textTheme.titleSmall,
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
                      itemCount: productProvider.mensClothing.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: productProvider.mensClothing[index],
                              ),
                            ),
                          );
                        },
                        child: ItemWidgets(
                          product: productProvider.mensClothing[index],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '  Womens Clothing',
                        style: theme.textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProductScreen(
                                products: productProvider.womensClothing,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'See all      ',
                          style: theme.textTheme.titleSmall,
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
                      itemCount: productProvider.womensClothing.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: productProvider.womensClothing[index],
                              ),
                            ),
                          );
                        },
                        child: ItemWidgets(
                          product: productProvider.womensClothing[index],
                        ),
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
