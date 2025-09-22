import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _ispasswordVisible = false;
  bool _isconfirmPasswordVisible = false;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 114, 190),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 180,
              width: 180,

              child: Image.asset(
                'assets/forgot_password_images/phishing-account-concept.png',
              ),
            ),
            Center(
              child: Text(
                'Create New Password',
                style: GoogleFonts.nunitoSans(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Enter your new password below.',
              style: GoogleFonts.inter(fontSize: 17, color: Colors.white),
            ),

            SizedBox(height: 30),

            Container(
              height: 640,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'New Password',
                            style: GoogleFonts.lato(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_ispasswordVisible,
                          autofocus: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Password';
                            } else if (value.length < 8) {
                              return 'Your Password Must Be Atleast 8 Characters';
                            } else if (!RegExp(
                              r'^(?=.*[A-Z])',
                            ).hasMatch(value)) {
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
                            hintText: 'New Password',
                            hintStyle: GoogleFonts.lato(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.key_sharp,
                              color: Colors.grey,
                            ),
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
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Confirm Password',
                            style: GoogleFonts.lato(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_isconfirmPasswordVisible,
                          autofocus: true,
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Retype your Password';
                            } else if (value != _passwordController.text) {
                              return 'Password do not Match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Re-Type Password',
                            hintStyle: GoogleFonts.lato(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.key_sharp,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isconfirmPasswordVisible =
                                      !_isconfirmPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isconfirmPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 65,
                        width: 380,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Save Password',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
