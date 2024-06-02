import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sayble/api/environment.dart';

class User {
  static void getCurrentUser() {
    final response = http.get(Uri.parse("${Environment.apiUrl}/user/current"));
  }

  static Future<void> uploadProfileImage(String imagePath) async {
    File imageFile = File(imagePath);
    String extension = imageFile.path.split('.').last;
    final response = await http.post(
      Uri.parse("${Environment.apiUrl}/user/profile/image"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Environment.userToken}',
      },
      body: jsonEncode(
        {
          'image' : base64Encode(imageFile.readAsBytesSync()),
          'file_extension' : extension,
        }
      ),
    );
    log(response.body);
  }
}
