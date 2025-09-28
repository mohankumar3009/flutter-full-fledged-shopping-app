import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/providers/product_provider.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/providers/favorite_provider.dart';

class ItemWidgets extends StatelessWidget {
  final Product product;

  const ItemWidgets({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final favProvider = Provider.of<FavoriteProvider>(context);
    // ignore: unused_local_variable
    final productProvider = Provider.of<ProductProvider>(context);

    return Card(
      color: Colors.white,
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
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 130,
                    width: double.infinity,
                    color: Colors.grey,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 22, 114, 190),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 130,
                    width: double.infinity,
                    color: Colors.grey,
                    child: const Icon(
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
                  onTap: () => favProvider.toggleFavorite(product),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black26,
                    child: Icon(
                      favProvider.isExist(product)
                          ? Icons.favorite
                          : Icons.favorite_border_sharp,
                      color: (favProvider.isExist(product)
                          ? Colors.red
                          : Colors.white),

                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Column(
            children: [ 
              Text(
                product.title,

                style: theme.textTheme.bodyMedium,

                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
