import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<void> logout() async {
    //firebase signout
    await FirebaseAuth.instance.signOut();

    //clear the shared preference storage for logout
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('isLogin');
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
      body: Stack(
        children: [
          Image.network(
            'https://tse2.mm.bing.net/th/id/OIP.u-4qDiYp1GZ8N8mgLhsrPQHaKX?rs=1&pid=ImgDetMain&o=7&rm=3',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 150),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },

                  child: Text(
                    ' Logout',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
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
