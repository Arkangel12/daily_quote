// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String name;
  String lastName;
  String email;
  String password;
  String phoneNumber;
  String address;
  String image;

  User({
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.address,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "last_name": lastName,
    "email": email,
    "password": password,
    "phone_number": phoneNumber,
    "address": address,
    "image": image,
  };
}
