// To parse this JSON data, do
//
//     final membership = membershipFromJson(jsonString);

import 'dart:convert';

List<Membership?>? membershipFromJson(String str) => json.decode(str) == null
    ? []
    : List<Membership?>.from(
        json.decode(str)!.map((x) => Membership.fromJson(x)));

String membershipToJson(List<Membership?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class Membership {
  Membership({
    this.plan,
    this.price,
    this.details1,
    this.details2,
    this.details3,
    this.details4,
    this.discounts1,
    this.discounts2,
    this.discounts3,
    this.discounts4,
    this.discounts5,
    this.discounts6,
    this.discounts7,
    this.getplan1,
    this.getplan2,
  });

  String? plan;
  String? price;
  String? details1;
  String? details2;
  String? details3;
  String? details4;
  String? discounts1;
  String? discounts2;
  String? discounts3;
  String? discounts4;
  String? discounts5;
  String? discounts6;
  String? discounts7;
  String? getplan1;
  String? getplan2;

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        plan: json["plan"],
        price: json["price"],
        details1: json["details1"],
        details2: json["details2"],
        details3: json["details3"],
        details4: json["details4"],
        discounts1: json["discounts1"],
        discounts2: json["discounts2"],
        discounts3: json["discounts3"],
        discounts4: json["discounts4"],
        discounts5: json["discounts5"],
        discounts6: json["discounts6"],
        discounts7: json["discounts7"],
        getplan1: json["getplan1"],
        getplan2: json["getplan2"],
      );

  Map<String, dynamic> toJson() => {
        "plan": plan,
        "price": price,
        "details1": details1,
        "details2": details2,
        "details3": details3,
        "details4": details4,
        "discounts1": discounts1,
        "discounts2": discounts2,
        "discounts3": discounts3,
        "discounts4": discounts4,
        "discounts5": discounts5,
        "discounts6": discounts6,
        "discounts7": discounts7,
        "getplan1": getplan1,
        "getplan2": getplan2,
      };
}
