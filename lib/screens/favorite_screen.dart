import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/providers/favorite_provider.dart';
// ignore: unused_import
import 'package:flutter_application/screens/cart_screen.dart';
import 'package:flutter_application/screens/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<CartProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.network(
              'https://tse2.mm.bing.net/th/id/OIP.u-4qDiYp1GZ8N8mgLhsrPQHaKX?rs=1&pid=ImgDetMain&o=7&rm=3',
              fit: BoxFit.cover,
            ),
          ),
          Consumer<FavoriteProvider>(
            builder: (context, favProvider, child) {
              final finalList = favProvider.favorites;

              if (finalList.isEmpty) {
                return Center(
                  child: Text(
                    'Your favorite list is empty',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  SizedBox(height: kToolbarHeight + 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      padding: EdgeInsets.zero,
                      itemCount: finalList.length,
                      itemBuilder: (context, index) {
                        final item = finalList[index];

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
                            color: Colors.white,
                            margin: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            shadowColor: Colors.black87,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: item.imageUrl,
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      height: 140,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromARGB(
                                            255,
                                            22,
                                            114,
                                            190,
                                          ),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          height: 140,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          child: const Icon(
                                            Icons.broken_image_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.name,
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        items.addItem(item);

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: (Text(
                                              "${item.name} Added to cart",
                                            )),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add_shopping_cart_sharp,
                                        color: const Color.fromARGB(
                                          255,
                                          22,
                                          114,
                                          190,
                                        ),
                                        size: 20,
                                      ),
                                      tooltip: 'Add to cart',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
