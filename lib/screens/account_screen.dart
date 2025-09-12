import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 94, 163, 220),
        title: Text(
          'Account ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('This is your account page')),
    );
  }
}
