// To parse this JSON data, do
//
//     final hotelBook = hotelBookFromJson(jsonString);

import 'dart:convert';

HotelBook hotelBookFromJson(String str) => HotelBook.fromJson(json.decode(str));

String hotelBookToJson(HotelBook data) => json.encode(data.toJson());

class HotelBook {
  HotelBook({
    this.bookResult,
  });

  BookResult? bookResult;

  factory HotelBook.fromJson(Map<String, dynamic> json) => HotelBook(
        bookResult: BookResult.fromJson(json["BookResult"]),
      );

  Map<String, dynamic> toJson() => {
        "BookResult": bookResult!.toJson(),
      };
}

class BookResult {
  BookResult({
    this.voucherStatus,
    this.responseStatus,
    this.error,
    this.traceId,
    this.status,
    this.hotelBookingStatus,
    this.invoiceNumber,
    this.confirmationNo,
    this.bookingRefNo,
    this.bookingId,
    this.isPriceChanged,
    this.isCancellationPolicyChanged,
  });

  bool? voucherStatus;
  int? responseStatus;
  Error? error;
  String? traceId;
  int? status;
  String? hotelBookingStatus;
  String? invoiceNumber;
  String? confirmationNo;
  String? bookingRefNo;
  int? bookingId;
  bool? isPriceChanged;
  bool? isCancellationPolicyChanged;

  factory BookResult.fromJson(Map<String, dynamic> json) => BookResult(
        voucherStatus: json["VoucherStatus"],
        responseStatus: json["ResponseStatus"],
        error: Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        status: json["Status"],
        hotelBookingStatus: json["HotelBookingStatus"],
        invoiceNumber: json["InvoiceNumber"],
        confirmationNo: json["ConfirmationNo"],
        bookingRefNo: json["BookingRefNo"],
        bookingId: json["BookingId"],
        isPriceChanged: json["IsPriceChanged"],
        isCancellationPolicyChanged: json["IsCancellationPolicyChanged"],
      );

  Map<String, dynamic> toJson() => {
        "VoucherStatus": voucherStatus,
        "ResponseStatus": responseStatus,
        "Error": error!.toJson(),
        "TraceId": traceId,
        "Status": status,
        "HotelBookingStatus": hotelBookingStatus,
        "InvoiceNumber": invoiceNumber,
        "ConfirmationNo": confirmationNo,
        "BookingRefNo": bookingRefNo,
        "BookingId": bookingId,
        "IsPriceChanged": isPriceChanged,
        "IsCancellationPolicyChanged": isCancellationPolicyChanged,
      };
}

class Error {
  Error({
    this.errorCode,
    this.errorMessage,
  });

  int? errorCode;
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
