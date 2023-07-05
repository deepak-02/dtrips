// To parse this JSON data, do
//
//     final nonLccSsrModel = nonLccSsrModelFromJson(jsonString);

import 'dart:convert';

NonLccSsrModel nonLccSsrModelFromJson(String str) =>
    NonLccSsrModel.fromJson(json.decode(str));

String nonLccSsrModelToJson(NonLccSsrModel data) => json.encode(data.toJson());

class NonLccSsrModel {
  Response? response;

  NonLccSsrModel({
    this.response,
  });

  factory NonLccSsrModel.fromJson(Map<String, dynamic> json) => NonLccSsrModel(
        response: json["Response"] == null
            ? null
            : Response.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response?.toJson(),
      };
}

class Response {
  List<Meal>? meal;
  List<Meal>? seatPreference;
  int? responseStatus;
  Error? error;
  String? traceId;

  Response({
    this.meal,
    this.seatPreference,
    this.responseStatus,
    this.error,
    this.traceId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        meal: json["Meal"] == null
            ? []
            : List<Meal>.from(json["Meal"]!.map((x) => Meal.fromJson(x))),
        seatPreference: json["SeatPreference"] == null
            ? []
            : List<Meal>.from(
                json["SeatPreference"]!.map((x) => Meal.fromJson(x))),
        responseStatus: json["ResponseStatus"],
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
      );

  Map<String, dynamic> toJson() => {
        "Meal": meal == null
            ? []
            : List<dynamic>.from(meal!.map((x) => x.toJson())),
        "SeatPreference": seatPreference == null
            ? []
            : List<dynamic>.from(seatPreference!.map((x) => x.toJson())),
        "ResponseStatus": responseStatus,
        "Error": error?.toJson(),
        "TraceId": traceId,
      };
}

class Error {
  int? errorCode;
  String? errorMessage;

  Error({
    this.errorCode,
    this.errorMessage,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json["ErrorCode"],
        errorMessage: json["ErrorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "ErrorMessage": errorMessage,
      };
}

class Meal {
  String? code;
  String? description;

  Meal({
    this.code,
    this.description,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        code: json["Code"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Description": description,
      };
}
