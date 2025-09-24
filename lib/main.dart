import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/providers/cart_provider.dart';
import 'package:flutter_application/providers/favorite_provider.dart';
import 'package:flutter_application/screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:flutter_application/widgets/bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
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
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          
           
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 22, 114, 190),
          ),
        ),
      ),

      home: const LoginScreen(),
    ),
  );
}
