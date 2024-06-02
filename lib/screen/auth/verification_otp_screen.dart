import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayble/api/registration.dart';
import 'package:sayble/fonts/sayble_icons.dart';
import 'package:sayble/util/otp_text_field.dart';

class VerificationOtpScreen extends StatefulWidget {
  final String email;

  const VerificationOtpScreen({super.key, required this.email});

  @override
  State<VerificationOtpScreen> createState() => _VerificationOtpScreenState();
}

class _VerificationOtpScreenState extends State<VerificationOtpScreen> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage("lib/assets/jpegs/welcome_screen.jpeg"),
            height: height,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.transparent,
                  Colors.black.withOpacity(0.85),
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(1),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: width * 0.12, horizontal: width * 0.064),
              child: Row(
                children: [
                  Icon(
                    SaybleIcons.sayble_logo,
                    color: Colors.white.withOpacity(0.8),
                    size: width * 0.060,
                  ),
                  SizedBox(width: width * 0.016),
                  Text(
                    "Sayble",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: width * 0.056,
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: width * 0.12, horizontal: width * 0.064),
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    child: Text(
                      "Verification Code",
                      style: TextStyle(
                        height: 1.1,
                        color: Colors.white,
                        fontSize: width * 0.14,
                        fontFamily: GoogleFonts.aBeeZee().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.024),
                  Text(
                    "Enter the 6-digit code sent to your email: ${widget.email}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: width * 0.048,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height * 0.036),
                  OtpTextField(
                    numberOfFields: 6,
                    onSubmit: (String value) {
                      setState(() {
                        otp = value;
                      });
                      Register.verifyOtp(value, context);
                    },
                  ),
                  SizedBox(
                    height: height * 0.036,
                  ),
                  SizedBox(
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {
                        Register.verifyOtp(otp, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: width * 0.032, horizontal: width * 0.064),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.032),
                        ),
                      ),
                      child: Text(
                        "Verify",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.046,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.036),
                  RichText(
                    text: TextSpan(
                      text: "Didn't receive the code? ",
                      style: TextStyle(
                        fontSize: width * 0.042,
                        fontFamily: GoogleFonts.fredoka().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Register.resendCode(context);
                            },
                          text: "Resend",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: width * 0.042,
                            fontFamily: GoogleFonts.fredoka().fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
