// To parse this JSON data, do
//
//     final fareRule = fareRuleFromJson(jsonString);

import 'dart:convert';

FareRule fareRuleFromJson(String str) => FareRule.fromJson(json.decode(str));

String fareRuleToJson(FareRule data) => json.encode(data.toJson());

class FareRule {
  Response? response;

  FareRule({
    this.response,
  });

  factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
        response: json["Response"] == null
            ? null
            : Response.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response?.toJson(),
      };
}

class Response {
  Error? error;
  List<FareRuleElement>? fareRules;
  int? responseStatus;
  String? traceId;

  Response({
    this.error,
    this.fareRules,
    this.responseStatus,
    this.traceId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        fareRules: json["FareRules"] == null
            ? []
            : List<FareRuleElement>.from(
                json["FareRules"]!.map((x) => FareRuleElement.fromJson(x))),
        responseStatus: json["ResponseStatus"],
        traceId: json["TraceId"],
      );

  Map<String, dynamic> toJson() => {
        "Error": error?.toJson(),
        "FareRules": fareRules == null
            ? []
            : List<dynamic>.from(fareRules!.map((x) => x.toJson())),
        "ResponseStatus": responseStatus,
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

class FareRuleElement {
  String? airline;
  DateTime? departureTime;
  String? destination;
  String? fareBasisCode;
  dynamic fareRestriction;
  String? fareRuleDetail;
  int? flightId;
  String? origin;
  DateTime? returnDate;

  FareRuleElement({
    this.airline,
    this.departureTime,
    this.destination,
    this.fareBasisCode,
    this.fareRestriction,
    this.fareRuleDetail,
    this.flightId,
    this.origin,
    this.returnDate,
  });

  factory FareRuleElement.fromJson(Map<String, dynamic> json) =>
      FareRuleElement(
        airline: json["Airline"],
        departureTime: json["DepartureTime"] == null
            ? null
            : DateTime.parse(json["DepartureTime"]),
        destination: json["Destination"],
        fareBasisCode: json["FareBasisCode"],
        fareRestriction: json["FareRestriction"],
        fareRuleDetail: json["FareRuleDetail"],
        flightId: json["FlightId"],
        origin: json["Origin"],
        returnDate: json["ReturnDate"] == null
            ? null
            : DateTime.parse(json["ReturnDate"]),
      );

  Map<String, dynamic> toJson() => {
        "Airline": airline,
        "DepartureTime": departureTime?.toIso8601String(),
        "Destination": destination,
        "FareBasisCode": fareBasisCode,
        "FareRestriction": fareRestriction,
        "FareRuleDetail": fareRuleDetail,
        "FlightId": flightId,
        "Origin": origin,
        "ReturnDate": returnDate?.toIso8601String(),
      };
}
