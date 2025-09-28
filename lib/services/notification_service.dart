import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // the notification received when the app is terminated or background
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    //firebase initialization
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //local notification plugin initialization

    await _initializeLocalNotification();
    await _showFlutterNotification(message);
  }

  ///initializes Firebase Messaging and Local Notifications
  static Future<void> initializeNotification() async {
    //requst permissions(required on ios, optional on android)
    await _firebaseMessaging.requestPermission();

    //foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showFlutterNotification(message);
    });

    //foreground from background message
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("App opened from background notification: ${message.data}");
    });

    //print the FCM Token
    await _getFcmToken();

    //initialize the local notification plugin
    await _initializeLocalNotification();

    //check if app was launched by tapping a notification
    await _getInitialNotification();
  }

  //fetch and print the FCM Token
  static Future<void> _getFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }

  ///show a local notification when a message is received
  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    Map<String, dynamic>? data = message.data;

    String title = notification?.title ?? data['title'] ?? 'No Title';
    String body = notification?.body ?? data['body'] ?? 'No body';

    //Android notification config
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_ID',
      'channel_NAME',
      channelDescription: 'Notification channel for basic tests',
      importance: Importance.high,
      priority: Priority.high,
    );

    //ios notification config
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    //combine platform-specific settings
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    //show notification
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<void> _initializeLocalNotification() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@drawable/ic_notification');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("user tapped notification: ${response.payload}");
      },
    );
  }

  ///Handbles notification tap when app is terminated
  static Future<void> _getInitialNotification() async {
    RemoteMessage? message = await FirebaseMessaging.instance
        .getInitialMessage();

    if (message != null) {
      print(
        "App launched from terminated state via notification: ${message.data}",
      );
    }
  }
}
