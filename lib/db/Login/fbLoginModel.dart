// To parse this JSON data, do
//
//     final fbLogin = fbLoginFromJson(jsonString);

import 'dart:convert';

FbLogin fbLoginFromJson(String str) => FbLogin.fromJson(json.decode(str));

String fbLoginToJson(FbLogin data) => json.encode(data.toJson());

class FbLogin {
  FbLogin({
    this.username,
    this.email,
    this.roles,
    this.phone,
    this.name,
    this.jwtCookie,
  });

  String? username;
  String? email;
  dynamic roles;
  dynamic phone;
  dynamic name;
  JwtCookie? jwtCookie;

  factory FbLogin.fromJson(Map<String, dynamic> json) => FbLogin(
        username: json["username"],
        email: json["email"],
        roles: json["roles"],
        phone: json["phone"],
        name: json["name"],
        jwtCookie: JwtCookie.fromJson(json["jwtCookie"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "roles": roles,
        "phone": phone,
        "name": name,
        "jwtCookie": jwtCookie!.toJson(),
      };
}

class JwtCookie {
  JwtCookie({
    this.name,
    this.value,
    this.maxAge,
    this.domain,
    this.path,
    this.secure,
    this.httpOnly,
    this.sameSite,
  });

  String? name;
  String? value;
  String? maxAge;
  dynamic domain;
  String? path;
  bool? secure;
  bool? httpOnly;
  dynamic sameSite;

  factory JwtCookie.fromJson(Map<String, dynamic> json) => JwtCookie(
        name: json["name"],
        value: json["value"],
        maxAge: json["maxAge"],
        domain: json["domain"],
        path: json["path"],
        secure: json["secure"],
        httpOnly: json["httpOnly"],
        sameSite: json["sameSite"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "maxAge": maxAge,
        "domain": domain,
        "path": path,
        "secure": secure,
        "httpOnly": httpOnly,
        "sameSite": sameSite,
      };
}
