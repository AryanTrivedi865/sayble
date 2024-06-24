import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sayble/api/environment.dart';
import 'package:sayble/screen/parent_bottom_screen/home_screen.dart';
import 'package:sayble/screen/profile_tabs/profile_screen.dart';
import 'package:sayble/screen/welcome_screen.dart';
import 'package:sayble/util/page_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  static Future<void> logout(BuildContext context) async {
    final response = await http.post(
      Uri.parse("${Environment.apiUrl}/auth/logout"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${Environment.userToken}",
      },
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200 && responseData["success"] == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('apiToken');
      Environment.userToken = '';
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        showSnackBar(context, "Failed to logout. Status code: ${response.statusCode}");
      }
    }
  }

  static Future<void> login(String username, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("${Environment.apiUrl}/auth/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          log(responseData.toString());
          if (responseData["success"] == true) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('apiToken', responseData["token"]);
            Environment.userToken = responseData["token"];
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                SwipePageRoute(
                  routeAnimation: RouteAnimation.horizontal,
                  currentChild: context.widget,
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
          } else {
            if (context.mounted) {
              showSnackBar(context, "Failed to login. Please try again later");
            }
          }
        } catch (e) {
          if (context.mounted) {
            showSnackBar(context, "Unexpected response format");
          }
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, "Failed to login. Status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "Failed to login. Please try again later");
      }
    }
  }

  static Future<void> forgotPassword(String email, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("${Environment.apiUrl}/auth/forgotpassword"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          log(responseData.toString());
          if (responseData["success"] == true) {
            if (context.mounted) {
              showSnackBar(context, "Password reset mail sent to your email");
            }
          } else {
            if (context.mounted) {
              showSnackBar(context, "Failed to send password reset mail");
            }
          }
        } catch (e) {
          if (context.mounted) {
            showSnackBar(context, "Unexpected response format");
          }
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, "Failed to send password reset link. Status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "An error occurred. Please try again later.");
      }
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
