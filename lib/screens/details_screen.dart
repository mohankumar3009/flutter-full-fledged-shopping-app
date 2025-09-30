import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/providers/cart_provider.dart' hide Product;
import 'package:flutter_application/providers/favorite_provider.dart';
import 'package:flutter_application/screens/cart_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedColor = 0;
  int selectedStorage = 1;

  final List<Color> colorOptions = [
    const Color(0xFFD9C3B2),
    const Color(0xFFCCC5BB),
    const Color(0xFFE5E7EB),
    const Color(0xFF222222),
  ];

  final List<String> storageOptions = ['256 GB', '512 GB', '1 TB'];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final size = MediaQuery.of(context).size;
    final favprovider = FavoriteProvider.of(context);
    int currentQuantity = cart.getItemQuantity(widget.product);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              favprovider.toggleFavorite(widget.product);
            },
            icon: Icon(
              favprovider.isExist(widget.product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: (favprovider.isExist(widget.product)
                  ? Colors.red
                  : Colors.black),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.share, color: Colors.black),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: size.height * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: size.height * 0.4,
                      color: Colors.grey,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 22, 114, 190),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: size.height * 0.4,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 70,

              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: index == 1 ? Colors.blue : Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image,
                    width: 76,
                    placeholder: (context, url) => Container(
                      width: 76,
                      color: Colors.grey,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 22, 114, 190),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 76,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              widget.product.title,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                (widget.product.category == "mobile" ||
                        widget.product.category == "electronics")
                    ? Text(
                        "By ",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      )
                    : SizedBox.shrink(),
                (widget.product.category == "mobile" ||
                        widget.product.category == "electronics")
                    ? Text(
                        "Apple",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      )
                    : SizedBox.shrink(),
                const SizedBox(width: 8),
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 2),
                Text(
                  "4.9 (2.2k)",
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "\$${widget.product.price}",
                      style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "\$1499.99",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        cart.removeItem(widget.product);
                      },
                    ),
                    Consumer(
                      builder: (_, cart, _) {
                        return Text(
                          currentQuantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        cart.addItem(widget.product);
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Text(
              "Color",
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            (widget.product.category == "mobile" ||
                    widget.product.category == "electronics")
                ? Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 30,
                      alignment: WrapAlignment.spaceAround,

                      children: List.generate(colorOptions.length, (index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: 50,
                            child: ChoiceChip(
                              avatar: CircleAvatar(
                                backgroundColor: Colors.transparent,
                              ),
                              padding: EdgeInsets.all(16),
                              backgroundColor: Colors.white,
                              label: Text(
                                [
                                  "Desert Titanium",
                                  "Natural Titanium",
                                  "White Titanium",
                                  "Black Titanium",
                                ][index],
                                style: GoogleFonts.lato(
                                  color: selectedColor == index
                                      ? Colors.blue
                                      : Colors.grey[700],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: selectedColor == index
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 0.9,
                                ),

                                borderRadius: BorderRadius.circular(40),
                              ),
                              selected: selectedColor == index,
                              onSelected: (_) =>
                                  setState(() => selectedColor = index),
                              selectedColor: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 12,
                      alignment: WrapAlignment.spaceAround,
                      children: List.generate(colorOptions.length, (index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: ChoiceChip(
                            backgroundColor: Colors.white,
                            label: Text(
                              ["black", "blue", "white", "green"][index],
                              style: GoogleFonts.lato(
                                color: selectedColor == index
                                    ? Colors.blue
                                    : Colors.grey[700],
                              ),
                            ),
                            selected: selectedColor == index,
                            onSelected: (_) =>
                                setState(() => selectedColor = index),
                            selectedColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: selectedColor == index
                                    ? Colors.blue
                                    : Colors.grey,
                                width: 0.9,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

            const SizedBox(height: 20),
            (widget.product.category == "mobile" ||
                    widget.product.category == "electronics")
                ? Text(
                    "Storage",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 12),
            (widget.product.category == "mobile" ||
                    widget.product.category == "electronics")
                ? Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 15,
                      children: List.generate(storageOptions.length, (index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: ChoiceChip(
                            backgroundColor: Colors.white,
                            label: Text(storageOptions[index]),
                            selected: selectedStorage == index,
                            onSelected: (_) =>
                                setState(() => selectedStorage = index),
                            selectedColor: Colors.blue[100],
                            labelStyle: GoogleFonts.lato(
                              color: selectedStorage == index
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                : SizedBox.shrink(),

            const SizedBox(height: 20),
            (widget.product.category == "mobile" ||
                    widget.product.category == "electronics")
                ? Text(
                    "A Snapshot View",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 8),
            (widget.product.category == "mobile" ||
                    widget.product.category == "electronics")
                ? ListTile(
                    dense: true,
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text(
                      "4K Ultra HD XDR Display",
                      style: GoogleFonts.lato(fontSize: 14),
                    ),
                  )
                : SizedBox.shrink(),
            (widget.product.category == "mobile" ||
                    widget.product.category == "electronics")
                ? ListTile(
                    dense: true,
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text(
                      "Wireless Charging System",
                      style: GoogleFonts.lato(fontSize: 14),
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 80),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[800],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Buy Now",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${widget.product.title} Added to cart",
                          ),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    child: Text(
                      "Add to Cart",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
