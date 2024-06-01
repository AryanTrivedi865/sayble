import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayble/api/environment.dart';
import 'package:sayble/fonts/sayble_icons.dart';
import 'package:sayble/screen/auth/login_screen.dart';
import 'package:sayble/util/swipe_page_route.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _register() {
    if (_dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select your date of birth"),
        ),
      );
      return;
    }
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your email"),
        ),
      );
      return;
    }
    if (_lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your last name"),
        ),
      );
      return;
    }
    if (_firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your first name"),
        ),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Verification code sent to your email address"),
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
                                  "Welcome aboard!",
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
                                  "Explore, engage and empower your network",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: width * 0.048,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: height * 0.042),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "First Name",
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
                                    keyboardType: TextInputType.name,
                                    controller: _firstNameController,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.036),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Last Name",
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
                                    keyboardType: TextInputType.name,
                                    controller: _lastNameController,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: width * 0.036),
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
                              controller: _emailController,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: width * 0.036),
                            InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: IgnorePointer(
                                child: TextField(
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    hintText: "Date of Birth",
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: width * 0.048,
                                      horizontal: width * 0.064,
                                    ),
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
                                  keyboardType: TextInputType.datetime,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: width * 0.1),
                        SizedBox(
                          width: width,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _register();
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
                              "Register",
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
                                text: "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: width * 0.042,
                                  fontFamily: GoogleFonts
                                      .fredoka()
                                      .fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          SwipePageRoute(
                                            builder: (context) =>
                                            const LoginScreen(),
                                            currentChild:
                                            const RegistrationScreen(),
                                            routeAnimation:
                                            RouteAnimation.vertical,
                                          ),
                                        );
                                      },
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
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
