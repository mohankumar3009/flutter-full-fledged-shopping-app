import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/screens/details_screen.dart';
import 'package:flutter_application/widgets/bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/models/list_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<CartProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNav()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Cart',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                items.clearCart();
              },
              icon: Icon(Icons.delete_outline_sharp, size: 23),
            ),
          ),
          SizedBox(width: 10),
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
          if (items.cartItems.isEmpty)
            Center(
              child: Text(
                'Your cart is Empty..',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: items.cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final Item item = items.cartItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(item: item),
                        ),
                      );
                    },

                    child: SizedBox(
                      height: 200,
                      child: Card(
                        color: Colors.white,
                        elevation: 4,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 192,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: item.imageUrl,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: 100,
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
                                        height: 100,
                                        color: Colors.grey,
                                        child: Icon(
                                          Icons.broken_image_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  item.name,
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "\$${item.price}".toString(),
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),

                                TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  label: Text(
                                    'Edit',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  style: ButtonStyle(),

                                  focusNode: FocusNode(),
                                  autofocus: false,
                                ),

                                SizedBox(height: 20),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                iconSize: 15,
                                                iconColor: Colors.grey,
                                                overlayColor: Colors.blue,
                                                foregroundColor: Colors.blue,
                                                side: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),

                                              onPressed: () {
                                                items.removeItem(item);
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                                size: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${items.getItemQuantity(item)}",
                                            style: GoogleFonts.openSans(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                side: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                                foregroundColor: Colors.blue,
                                                iconColor: Colors.grey,
                                                iconSize: 15,
                                                overlayColor: Colors.blue,
                                                backgroundColor: Colors.white60,
                                              ),

                                              onPressed: () {
                                                items.addItem(item);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? 70
                                          : 550,
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        items.removeItem(item);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: (items.cartItems.isNotEmpty)
          ? Container(
              height: 330,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Enter Promo Code',
                        hintStyle: GoogleFonts.lato(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.discount_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: Icon(Icons.arrow_forward_ios_outlined),
                        suffixIconColor: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '    Sub Total',
                        style: GoogleFonts.lato(
                          color: Colors.grey[700],
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "\$${items.subtotalPrice.toStringAsFixed(2)}    ",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '    Shipping and Taxs',
                        style: GoogleFonts.lato(
                          color: Colors.grey[700],
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "\$${items.taxAmount.toStringAsFixed(2)}    ",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '    Total',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${items.totalAmount.toStringAsFixed(2)}    ",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 60,
                    width: 385,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          22,
                          114,
                          190,
                        ),
                      ),
                      onPressed: () {
                        items.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Items purchased Successful'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text(
                        'CheckOut',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
