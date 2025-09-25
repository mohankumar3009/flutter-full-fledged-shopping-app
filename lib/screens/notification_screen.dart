import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/screens/notification_detailed_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //push notificaion
  void firebaseMessaging() async {
    //firebasemessaging initialize
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    //permission for notification
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Permission status: ${settings.authorizationStatus}');

    //FCM Token
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    //inapp notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "No Title";
      final body = message.notification?.body ?? "No Body";

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(
              body,
              maxLines: 1,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NotificationDetailedScreen(title: title, body: body),
                    ),
                  );
                },
                child: Text('Next'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
              ),
            ],
          ),
        );
      }
    });

    //app is not close but it is in background

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "No Title";
      final body = message.notification?.body ?? "No body";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              NotificationDetailedScreen(title: title, body: body),
        ),
      );
    });

    // background notification in the app, The will closed

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final title = message.notification?.title ?? "No Title";
        final body = message.notification?.body ?? "No Body";

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NotificationDetailedScreen(title: title, body: body),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // call the function
    firebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          'Push notification',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}
