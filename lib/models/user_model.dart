import 'dart:convert';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? dob;
  String? image;
  bool? isVerified;
  bool? isLoggedIn;
  String? otp;
  String? salt;
  String? tempPassword;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.dob,
    this.image,
    this.isVerified,
    this.isLoggedIn,
    this.otp,
    this.salt,
    this.tempPassword,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] as String?;
    firstName = json["firstName"] as String?;
    lastName = json["lastName"] as String?;
    username = json["username"] as String?;
    email = json["email"] as String?;
    password = json["password"] as String?;
    dob = json["dob"] as String?;
    image = json["image"] as String?;
    isVerified = json["isVerified"] as bool?;
    isLoggedIn = json["isLoggedIn"] as bool?;
    otp = json["otp"] as String?;
    salt = json["salt"] as String?;
    tempPassword = json["temp_password"] as String?;
    createdAt = json["createdAt"] as String?;
    updatedAt = json["updatedAt"] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["username"] = username;
    _data["email"] = email;
    _data["password"] = password;
    _data["dob"] = dob;
    _data["image"] = image;
    _data["isVerified"] = isVerified;
    _data["isLoggedIn"] = isLoggedIn;
    _data["otp"] = otp;
    _data["salt"] = salt;
    _data["temp_password"] = tempPassword;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    return _data;
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? dob,
    String? image,
    bool? isVerified,
    bool? isLoggedIn,
    String? otp,
    String? salt,
    String? tempPassword,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      dob: dob ?? this.dob,
      image: image ?? this.image,
      isVerified: isVerified ?? this.isVerified,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      otp: otp ?? this.otp,
      salt: salt ?? this.salt,
      tempPassword: tempPassword ?? this.tempPassword,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static List<UserModel> fromList(List<dynamic> list) {
    return list.map((e) => UserModel.fromJson(e)).toList();
  }
}
