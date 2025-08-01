

import 'package:hive/hive.dart';

part 'login_response.g.dart';

@HiveType(typeId: 1)
class LoginResponse extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? maidenName;
  @HiveField(4)
  int? age;
  @HiveField(5)
  String? gender;
  @HiveField(6)
  String? email;
  @HiveField(7)
  String? phone;
  @HiveField(8)
  String? username;
  @HiveField(9)
  String? password;
  @HiveField(10)
  String? birthDate;
  @HiveField(11)
  String? image;
  @HiveField(12)
  String? bloodGroup;
  @HiveField(13)
  double? height;
  @HiveField(14)
  double? weight;
  @HiveField(15)
  String? eyeColor;

  LoginResponse(
      {this.id,
        this.firstName,
        this.lastName,
        this.maidenName,
        this.age,
        this.gender,
        this.email,
        this.phone,
        this.username,
        this.password,
        this.birthDate,
        this.image,
        this.bloodGroup,
        this.height,
        this.weight,
        this.eyeColor});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    birthDate = json['birthDate'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    height = json['height'];
    weight = json['weight'];
    eyeColor = json['eyeColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['maidenName'] = this.maidenName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['password'] = this.password;
    data['birthDate'] = this.birthDate;
    data['image'] = this.image;
    data['bloodGroup'] = this.bloodGroup;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['eyeColor'] = this.eyeColor;
    return data;
  }
}