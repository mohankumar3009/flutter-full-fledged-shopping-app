import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/providers/favorite_provider.dart';
import 'package:flutter_application/providers/product_provider.dart';
import 'package:flutter_application/screens/details_screen.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllProductScreen extends StatefulWidget {
  final List<Product> products; //  Only list of products is needed
  const AllProductScreen({super.key, this.products = const []});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // ignore: unused_local_variable
    final productProvider = Provider.of<ProductProvider>(context);
    final favProvider = FavoriteProvider.of(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('All Products'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://tse2.mm.bing.net/th/id/OIP.u-4qDiYp1GZ8N8mgLhsrPQHaKX?rs=1&pid=ImgDetMain&o=7&rm=3',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                      ? 60
                      : 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.87,
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
                    itemCount: widget.products.length,
                    itemBuilder: (context, index) {
                      final item = widget.products[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(product: item),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: Colors.black38,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                clipBehavior: Clip.hardEdge,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: item.image,
                                      height: 130,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        height: 130,
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
                                            height: 130,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            child: Icon(
                                              Icons.broken_image_outlined,
                                              color: Colors.grey,
                                            ),
                                          ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        favProvider.toggleFavorite(item);
                                        setState(() {}); // refresh UI
                                      },
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
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  item.title,
                                  style: theme.textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
