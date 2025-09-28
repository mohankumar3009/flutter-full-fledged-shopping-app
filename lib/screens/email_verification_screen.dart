import 'package:flutter/material.dart';
import 'package:flutter_application/screens/create_new_password_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<EmailVerificationScreen> {
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
                'assets/forgot_password_images/illustration-characters-sending-email.png',
              ),
            ),

            Center(
              child: Text(
                'Check your Email',
                style: GoogleFonts.nunitoSans(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "    We've sent a password reset link to your email address. Please follow the instructions to create new password.",
                style: GoogleFonts.inter(fontSize: 17, color: Colors.white),
              ),
            ),

            Container(
              height: 580,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "Please check your spam folder if you don't ",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Text(
                    'receive it.',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Back to login',
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
          ],
        ),
      ),
    );
  }
}
