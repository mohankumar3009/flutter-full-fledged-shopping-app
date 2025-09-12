import 'package:flutter/material.dart';
import 'package:flutter_application/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 163, 220),
        title: Text(
          'Favorites List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favProvider, child) {
          final finalList = favProvider.favorites;

          if (finalList.isEmpty) {
            return const Center(
              child: Text(
                'Your favorite list is empty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: finalList.length,
            itemBuilder: (context, index) {
              final item = finalList[index];
              return Card(
                color: const Color.fromARGB(255, 243, 238, 238),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        autoClose: true,
                        onPressed: (context) {
                          favProvider.toggleFavorite(item);
                        },
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.remove_circle_outline_sharp,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red[100],
                      backgroundImage: NetworkImage(item.imageUrl),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("\$${item.price}"),
                    trailing: SizedBox(
                      height: 40,
                      width: 130,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Add to cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
