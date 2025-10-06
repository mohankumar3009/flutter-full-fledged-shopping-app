import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/providers/favorite_provider.dart';
import 'package:flutter_application/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:http/retry.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<void> logout() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favprovider = Provider.of<FavoriteProvider>(context, listen: false);
    //firebase signout
    await FirebaseAuth.instance.signOut();
    await cartProvider.clearCart();
    await favprovider.clearFavorites();

    //clear the shared preference storage for logout
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('isLogin');
      await preferences.reload();
      print("remaining keys: ${preferences.getKeys()}");
    } catch (_) {}

    //redirect to the login page

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );

    //scaffold messenger

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Logout successful')));
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    // ignore: unused_local_variable
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Account'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .snapshots(),
        builder: (context, Snapshot) {
          if (!Snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var userData = Snapshot.data!.data() as Map<String, dynamic>;
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://tse2.mm.bing.net/th/id/OIP.u-4qDiYp1GZ8N8mgLhsrPQHaKX?rs=1&pid=ImgDetMain&o=7&rm=3',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 100),

                    Container(
                      height: 150,
                      width: 370,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(5, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: ClipRect(
                                clipBehavior: Clip.hardEdge,

                                child: Icon(
                                  Icons.account_circle_sharp,
                                  size: 90,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 50),
                                Text(
                                  userData['name'] ?? 'unkown',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  userData['email'] ?? 'No email',
                                  style: GoogleFonts.lato(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          '   Settings',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),

                        SizedBox(height: 10),

                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.account_circle_outlined),

                          title: Text(
                            'Edit Profile',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.password),

                          title: Text(
                            'Change Password',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.language_sharp),

                          title: Text(
                            'Language',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.support_agent_sharp),

                          title: Text(
                            'Help Desk',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        ListTile(
                          onTap: logout,
                          leading: const Icon(Icons.logout_sharp),
                          title: Text(
                            'Logout',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
