
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayble/fonts/sayble_icons.dart';
import 'package:sayble/screen/auth/login_screen.dart';
import 'package:sayble/screen/auth/registration_screen.dart';
import 'package:sayble/util/swipe_page_route.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    child: Text(
                      "नमस्कार, welcome!",
                      style: TextStyle(
                        height: 1.1,
                        color: Colors.white,
                        fontSize: width * 0.16,
                        letterSpacing: 1.2,
                        fontFamily: GoogleFonts
                            .aBeeZee()
                            .fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.024),
                  Text(
                    "Share your thoughts, connect with friends, and discover the world.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: width * 0.048,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height * 0.036),
                  SizedBox(
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          SwipePageRoute(
                            builder: (context) =>
                            const RegistrationScreen(),
                            currentChild: this,
                            routeAnimation: RouteAnimation.horizontal,
                          ),
                        );
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
                        "Get Started",
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
                      text: "Already on Sayble? ",
                      style: TextStyle(
                        fontSize: width * 0.042,
                        fontFamily: GoogleFonts
                            .fredoka()
                            .fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in here",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                SwipePageRoute(
                                  builder: (context) => const LoginScreen(),
                                  currentChild: this,
                                  routeAnimation: RouteAnimation.horizontal,
                                ),
                              );
                            },
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: width * 0.042,
                            fontFamily: GoogleFonts
                                .fredoka()
                                .fontFamily,
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
