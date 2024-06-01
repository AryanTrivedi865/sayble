import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayble/fonts/sayble_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      log("Email: $email, Password: $password");
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all the fields."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return KeyboardVisibilityProvider(
      child: Scaffold(
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
                        fontFamily: GoogleFonts
                            .aBeeZee()
                            .fontFamily,
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
                child: KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isKeyboardVisible)
                          Column(
                            children: [
                              SizedBox(
                                width: width,
                                child: Text(
                                  "Welcome back!",
                                  style: TextStyle(
                                    height: 1.1,
                                    color: Colors.white,
                                    fontSize: width * 0.16,
                                    letterSpacing: 1.2,
                                    fontFamily:
                                    GoogleFonts
                                        .aBeeZee()
                                        .fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.016),
                              Container(
                                width: width * 0.8,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Let's dive back in. Please login to your account.",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: width * 0.048,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: height * 0.036),
                        Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: width * 0.048,
                                    horizontal: width * 0.064),
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: width * 0.036),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Password",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: width * 0.048,
                                    horizontal: width * 0.064),
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    },);
                                  },
                                  icon: Icon(
                                    !obscureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.white.withOpacity(0.8),
                                    size: width * 0.056,
                                  ),
                                ),
                              ),
                              obscureText: obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: width * 0.064),
                        SizedBox(
                          width: width,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: width * 0.032,
                                  horizontal: width * 0.064),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(width * 0.032),
                              ),
                            ),
                            icon: Icon(
                              Icons.login_rounded,
                              color: Colors.black,
                              size: width * 0.046,
                            ),
                            label: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.046,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: width * 0.032),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.32,
                              height: 1,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            SizedBox(width: width * 0.032),
                            Text(
                              "Or",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: width * 0.042,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: width * 0.032),
                            Container(
                              width: width * 0.32,
                              height: 1,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ],
                        ),
                        SizedBox(height: width * 0.032),
                        SizedBox(
                          width: width,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: width * 0.032,
                                  horizontal: width * 0.064),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(width * 0.032),
                              ),
                            ),
                            icon: Icon(
                              FontAwesomeIcons.google,
                              color: Colors.black,
                              size: width * 0.046,
                            ),
                            label: Text(
                              "Sign in with Google",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.046,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: width * 0.064),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Forgot Password? ",
                                style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontFamily: GoogleFonts
                                      .fredoka()
                                      .fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Click here",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xff1a1a1a),
                                                borderRadius:
                                                BorderRadius.vertical(
                                                  top: Radius.circular(
                                                      width * 0.064),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: width * 0.064,
                                                  horizontal: width * 0.064),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        top: -8,
                                                        right: 0,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          icon: Icon(
                                                            Icons.close_rounded,
                                                            color: Colors.white,
                                                            size: width * 0.064,
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "Forgot Password",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: width * 0.064,
                                                            fontFamily: GoogleFonts.aBeeZee().fontFamily,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: width * 0.048),
                                                  TextField(
                                                    decoration: InputDecoration(
                                                      hintText: "Email",
                                                      contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical:
                                                          width * 0.048,
                                                          horizontal:
                                                          width *
                                                              0.064),
                                                      hintStyle: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: width * 0.04,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            width *
                                                                0.04),
                                                        borderSide: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            width *
                                                                0.04),
                                                        borderSide: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ),
                                                    textInputAction:
                                                    TextInputAction.done,
                                                  ),
                                                  SizedBox(
                                                      height: width * 0.048),
                                                  SizedBox(
                                                    width: width,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                        Colors.white,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                            width *
                                                                0.032,
                                                            horizontal:
                                                            width *
                                                                0.064),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              width *
                                                                  0.032),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Send Verification Code",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                          width * 0.046,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: width * 0.042,
                                      fontFamily:
                                      GoogleFonts
                                          .fredoka()
                                          .fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
