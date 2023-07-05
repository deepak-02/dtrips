// To parse this JSON data, do
//
//     final getProfile = getProfileFromJson(jsonString);

import 'dart:convert';

GetProfile getProfileFromJson(String str) =>
    GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
  GetProfile({
    this.email,
    this.name,
    this.phone,
    this.gender,
    this.address,
  });

  dynamic email;
  dynamic name;
  dynamic phone;
  dynamic gender;
  dynamic address;

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        gender: json["gender"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone": phone,
        "gender": gender,
        "address": address,
      };
}
