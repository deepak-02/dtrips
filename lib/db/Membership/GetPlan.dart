// To parse this JSON data, do
//
//     final getPlan = getPlanFromJson(jsonString);

import 'dart:convert';

GetPlan getPlanFromJson(String str) => GetPlan.fromJson(json.decode(str));

String? getPlanToJson(GetPlan data) => json.encode(data.toJson());

class GetPlan {
  GetPlan({
    this.identity,
    this.plan,
  });

  dynamic identity;
  dynamic plan;

  factory GetPlan.fromJson(Map<String, dynamic> json) => GetPlan(
        identity: json["identity"],
        plan: json["plan"],
      );

  Map<String, dynamic> toJson() => {
        "identity": identity,
        "plan": plan,
      };
}
