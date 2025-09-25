import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationDetailedScreen extends StatelessWidget {
  final String title;
  final String body;
  const NotificationDetailedScreen({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Detailed')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(body)
          ],
        ),
      ),
    );
  }
}
