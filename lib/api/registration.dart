import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sayble/api/environment.dart';
import 'package:sayble/screen/auth/registration_screen.dart';
import 'package:sayble/screen/auth/verification_otp_screen.dart';
import 'package:sayble/screen/profile_screen.dart';
import 'package:sayble/util/swipe_page_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register{
  static Future<void> verifyOtp(String otp, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("${Environment.apiUrl}/auth/verify"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer ${Environment.userToken}",
        },
        body: jsonEncode({
          "OTP": otp,
        }),
      );

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);

          if (responseData["success"] == true) {
            Navigator.pushReplacement(
              context,
              SwipePageRoute(
                builder: (context) => const ProfileScreen(),
                routeAnimation: RouteAnimation.horizontal,
                currentChild: context.widget,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Invalid OTP"),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Unexpected response format"),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Failed to verify OTP. Status code: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
        ),
      );
    }
  }


  static Future<void> sendCode(String firstName, String lastName, String email, String dob, BuildContext context) async {
    final response = await http.post(
      Uri.parse("${Environment.apiUrl}/auth/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'dob': dob,
        },
      ),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['success']) {
        final apiToken = responseData['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('apiToken', apiToken);
        Environment.userToken = apiToken;
        Navigator.push(
          context,
          SwipePageRoute(
            builder: (context) => VerificationOtpScreen(
              email: email,
            ),
            currentChild: const RegistrationScreen(),
            routeAnimation: RouteAnimation.vertical,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to register: ${response.statusCode}"),
        ),
      );
      log(response.body);
    }
  }

  static Future<void> resendCode(BuildContext context) async {
    final response = await http.post(
      Uri.parse("${Environment.apiUrl}/auth/resendotp"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Environment.userToken}',
      },
    );
    if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      if(responseData['success']){
        log("OTP sent successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OTP sent successfully"),
          ),
        );
      }else{
        log("Failed to send OTP");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to send OTP"),
          ),
        );
      }
    }else{
      log("Failed to send OTP. Status code: ${response.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send OTP. Status code: ${response.statusCode}"),
        ),
      );
    }
  }
}