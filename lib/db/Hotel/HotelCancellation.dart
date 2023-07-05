// To parse this JSON data, do
//
//     final hotelCancellation = hotelCancellationFromJson(jsonString);

import 'dart:convert';

HotelCancellation? hotelCancellationFromJson(String str) =>
    HotelCancellation.fromJson(json.decode(str));

String hotelCancellationToJson(HotelCancellation? data) =>
    json.encode(data!.toJson());

class HotelCancellation {
  HotelCancellation({
    this.hotelChangeRequestResult,
  });

  HotelChangeRequestResult? hotelChangeRequestResult;

  factory HotelCancellation.fromJson(Map<String, dynamic> json) =>
      HotelCancellation(
        hotelChangeRequestResult:
            HotelChangeRequestResult.fromJson(json["HotelChangeRequestResult"]),
      );

  Map<String, dynamic> toJson() => {
        "HotelChangeRequestResult": hotelChangeRequestResult!.toJson(),
      };
}

class HotelChangeRequestResult {
  HotelChangeRequestResult({
    this.b2B2BStatus,
    this.cancellationChargeBreakUp,
    this.totalServiceCharge,
    this.responseStatus,
    this.error,
    this.traceId,
    this.changeRequestId,
    this.changeRequestStatus,
  });

  bool? b2B2BStatus;
  dynamic cancellationChargeBreakUp;
  dynamic totalServiceCharge;
  dynamic responseStatus;
  Error? error;
  String? traceId;
  dynamic changeRequestId;
  dynamic changeRequestStatus;

  factory HotelChangeRequestResult.fromJson(Map<String, dynamic> json) =>
      HotelChangeRequestResult(
        b2B2BStatus: json["B2B2BStatus"],
        cancellationChargeBreakUp: json["CancellationChargeBreakUp"],
        totalServiceCharge: json["TotalServiceCharge"],
        responseStatus: json["ResponseStatus"],
        error: Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        changeRequestId: json["ChangeRequestId"],
        changeRequestStatus: json["ChangeRequestStatus"],
      );

  Map<String, dynamic> toJson() => {
        "B2B2BStatus": b2B2BStatus,
        "CancellationChargeBreakUp": cancellationChargeBreakUp,
        "TotalServiceCharge": totalServiceCharge,
        "ResponseStatus": responseStatus,
        "Error": error!.toJson(),
        "TraceId": traceId,
        "ChangeRequestId": changeRequestId,
        "ChangeRequestStatus": changeRequestStatus,
      };
}

class Error {
  Error({
    this.errorCode,
    this.errorMessage,
  });

  dynamic errorCode;
  String? errorMessage;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json["ErrorCode"],
        errorMessage: json["ErrorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "ErrorMessage": errorMessage,
      };
}
