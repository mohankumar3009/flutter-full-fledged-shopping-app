import 'package:flutter/material.dart';
import 'package:flutter_application/screens/account_screen.dart';
// ignore: unused_import
import 'package:flutter_application/screens/cart_screen.dart';
import 'package:flutter_application/screens/favorite_screen.dart';
import 'package:flutter_application/screens/home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeScreen(), FavoriteScreen(), AccountScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 238, 238),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 243, 238, 238),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 94, 163, 220),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
