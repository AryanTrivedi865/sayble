import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sayble/api/environment.dart';
import 'package:sayble/models/user_model.dart';

class User {

  static Future<UserModel> getCurrentUser() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/user/current"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Environment.userToken}',
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Map<String, dynamic> user = responseData['extras'];
      return UserModel.fromJson(user);
    } else {
      throw Exception('Failed to load user');
    }
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
      body: jsonEncode({
        'image': base64Encode(imageFile.readAsBytesSync()),
        'file_extension': extension,
      }),
    );
    log(response.body);
  }
}
