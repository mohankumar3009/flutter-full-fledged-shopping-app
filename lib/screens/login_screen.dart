import 'package:flutter/material.dart';
import 'package:flutter_application/screens/create_account_screen.dart';
import 'package:flutter_application/screens/home_screen.dart';
import 'package:flutter_application/widgets/bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _ispasswordVisible = false;
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 180),
            Center(
              child: Text(
                'Welcome Back!',
                style: GoogleFonts.nunitoSans(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Sign in to continue your app',
              style: GoogleFonts.inter(fontSize: 18),
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Email',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofocus: true,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Email';
                          } else if (value.startsWith(RegExp(r'[A-Z]'))) {
                            return 'Please Enter a Valid Email';
                          } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ).hasMatch(value)) {
                            return 'Please Enter a Valid Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Email',
                          hintStyle: GoogleFonts.lato(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Password',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_ispasswordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Your Password';
                          } else if (value.length < 8) {
                            return 'Your Password Must Be Atleast 8 Characters';
                          } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                            return 'Include at Least one Uppercase Letter';
                          } else if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
                            return 'Include at Least one Number';
                          } else if (!RegExp(
                            r'^(?=.*[!@#\$&*~])',
                          ).hasMatch(value)) {
                            return 'Include at Least one Special Character';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.lato(color: Colors.grey),
                          prefixIcon: Icon(Icons.key, color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _ispasswordVisible = !_ispasswordVisible;
                              });
                            },
                            icon: Icon(
                              _ispasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                                  color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              color: const Color.fromARGB(255, 22, 114, 190),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 65,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color.fromARGB(255, 22, 114, 190),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint('Email: ${_emailController.text}');
                    debugPrint('Password: ${_passwordController.text}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNav()),
                    );
                  }
                },
                child: Text(
                  'Sign In',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAccountScreen(),
                  ),
                );
              },
              child: Text(
                'Create New Account',
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 22, 114, 190),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
