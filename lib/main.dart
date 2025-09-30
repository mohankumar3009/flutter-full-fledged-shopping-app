import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/providers/favorite_provider.dart';
import 'package:flutter_application/providers/product_provider.dart';
import 'package:flutter_application/screens/login_screen.dart';
import 'package:flutter_application/services/notification_service.dart';
import 'package:flutter_application/widgets/bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize SharedPreferences safely user is already logged in
  final prefs = await SharedPreferences.getInstance();
  final bool spLogin = prefs.getBool('isLogin') ?? false;
  // save the cart data to the shared preferences
  final cartProvider = CartProvider();
  await cartProvider.loadCartFromPrefs();
  //save the favorite data to the shared preferences
  final favoriteProvider = FavoriteProvider();
  await favoriteProvider.loadFavoritesFromPrefs();

  // Initialize local notifications
  NotificationService.initializeNotification();

  //firebase auth
  final bool firebaseLogin = FirebaseAuth.instance.currentUser != null;

  //final
  final bool isLogin = spLogin && firebaseLogin;

  // Background notification handler
  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseMessagingBackgroundHandler,
  );

  // Get FCM token
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token (main): $token");
  } catch (e) {
    debugPrint("FCM token error: $e");
  }

  // Lock device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          textTheme: TextTheme(
            titleMedium: GoogleFonts.lato(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            titleSmall: GoogleFonts.lato(
              color: const Color.fromARGB(255, 22, 114, 190),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 22, 114, 190),
            ),
          ),
        ),
        // Show BottomNav if logged in, otherwise LoginScreen
        home: isLogin ? const BottomNav() : const LoginScreen(),
      ),
    );
  }
}
