import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/list_model.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/providers/favorite_provider.dart';

class ItemWidgets extends StatelessWidget {
  final Item item;

  const ItemWidgets({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final favProvider = Provider.of<FavoriteProvider>(context);

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
                  imageUrl: item.imageUrl,
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
          Column(
            children: [Text(item.name, style: theme.textTheme.bodyMedium)],
          ),
        ],
      ),
    );
  }
}
