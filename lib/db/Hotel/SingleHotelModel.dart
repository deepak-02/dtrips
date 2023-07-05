// // To parse this JSON data, do
// //
// //     final singleHotel = singleHotelFromJson(jsonString);
//
// import 'dart:convert';
//
// SingleHotel singleHotelFromJson(String str) => SingleHotel.fromJson(json.decode(str));
//
// String singleHotelToJson(SingleHotel data) => json.encode(data.toJson());
//
// class SingleHotel {
//   SingleHotel({
//      this.hotelInfoResult,
//   });
//
//   HotelInfoResult ? hotelInfoResult;
//
//   factory SingleHotel.fromJson(Map<String, dynamic> json) => SingleHotel(
//     hotelInfoResult: HotelInfoResult.fromJson(json["HotelInfoResult"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "HotelInfoResult": hotelInfoResult!.toJson(),
//   };
// }
//
// class HotelInfoResult {
//   HotelInfoResult({
//     this.responseStatus,
//     this.error,
//     this.traceId,
//     this.hotelDetails,
//   });
//
//   int ? responseStatus;
//   Error ? error;
//   String ? traceId;
//   HotelDetails ? hotelDetails;
//
//   factory HotelInfoResult.fromJson(Map<String, dynamic> json) => HotelInfoResult(
//     responseStatus: json["ResponseStatus"],
//     error: Error.fromJson(json["Error"]),
//     traceId: json["TraceId"],
//     hotelDetails: HotelDetails.fromJson(json["HotelDetails"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ResponseStatus": responseStatus,
//     "Error": error!.toJson(),
//     "TraceId": traceId,
//     "HotelDetails": hotelDetails!.toJson(),
//   };
// }
//
// class Error {
//   Error({
//     this.errorCode,
//     this.errorMessage,
//   });
//
//   int ? errorCode;
//   String ? errorMessage;
//
//   factory Error.fromJson(Map<String, dynamic> json) => Error(
//     errorCode: json["ErrorCode"],
//     errorMessage: json["ErrorMessage"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ErrorCode": errorCode,
//     "ErrorMessage": errorMessage,
//   };
// }
//
// class HotelDetails {
//   HotelDetails({
//     this.hotelName,
//     this.starRating,
//     this.hotelUrl,
//     this.description,
//     this.attractions,
//     this.hotelFacilities,
//     this.hotelPolicy,
//     this.specialInstructions,
//     this.hotelPicture,
//     this.images,
//     this.address,
//     this.countryName,
//     this.pinCode,
//     this.hotelContactNo,
//     this.faxNumber,
//     this.email,
//     this.latitude,
//     this.longitude,
//     this.roomData,
//     this.roomFacilities,
//     this.services,
//   });
//
//   String ? hotelName;
//   int ? starRating;
//   dynamic hotelUrl;
//   String ? description;
//   List<Attraction> ? attractions;
//   List<String> ? hotelFacilities;
//   dynamic hotelPolicy;
//   dynamic specialInstructions;
//   dynamic hotelPicture;
//   List<String> ? images;
//   String ? address;
//   String ? countryName;
//   String ? pinCode;
//   String ? hotelContactNo;
//   dynamic faxNumber;
//   dynamic email;
//   String ? latitude;
//   String ? longitude;
//   dynamic roomData;
//   dynamic roomFacilities;
//   dynamic services;
//
//   factory HotelDetails.fromJson(Map<String, dynamic> json) => HotelDetails(
//     hotelName: json["HotelName"],
//     starRating: json["StarRating"],
//     hotelUrl: json["HotelURL"],
//     description: json["Description"],
//    // attractions: List<Attraction>.from(json["Attractions"].map((x) => Attraction.fromJson(x))).toList(),
//     hotelFacilities: List<String>.from(json["HotelFacilities"].map((x) => x)),
//     hotelPolicy: json["HotelPolicy"],
//     specialInstructions: json["SpecialInstructions"],
//     hotelPicture: json["HotelPicture"],
//     images: List<String>.from(json["Images"].map((x) => x)),
//     address: json["Address"],
//     countryName: json["CountryName"],
//     pinCode: json["PinCode"],
//     hotelContactNo: json["HotelContactNo"],
//     faxNumber: json["FaxNumber"],
//     email: json["Email"],
//     latitude: json["Latitude"],
//     longitude: json["Longitude"],
//     roomData: json["RoomData"],
//     roomFacilities: json["RoomFacilities"],
//     services: json["Services"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "HotelName": hotelName,
//     "StarRating": starRating,
//     "HotelURL": hotelUrl,
//     "Description": description,
//     "Attractions": List<dynamic>.from(attractions!.map((x) => x.toJson())),
//     "HotelFacilities": List<dynamic>.from(hotelFacilities!.map((x) => x)),
//     "HotelPolicy": hotelPolicy,
//     "SpecialInstructions": specialInstructions,
//     "HotelPicture": hotelPicture,
//     "Images": List<dynamic>.from(images!.map((x) => x)),
//     "Address": address,
//     "CountryName": countryName,
//     "PinCode": pinCode,
//     "HotelContactNo": hotelContactNo,
//     "FaxNumber": faxNumber,
//     "Email": email,
//     "Latitude": latitude,
//     "Longitude": longitude,
//     "RoomData": roomData,
//     "RoomFacilities": roomFacilities,
//     "Services": services,
//   };
// }
//
// class Attraction {
//   Attraction({
//     this.key,
//     this.value,
//   });
//
//   dynamic  key;
//   dynamic value;
//
//   factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
//     key: json["Key"],
//     value: json["Value"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Key": key,
//     "Value": value,
//   };
// }

// To parse this JSON data, do
//
//     final singleHotel = singleHotelFromJson(jsonString);

import 'dart:convert';

SingleHotel singleHotelFromJson(String str) =>
    SingleHotel.fromJson(json.decode(str));

String singleHotelToJson(SingleHotel data) => json.encode(data.toJson());

class SingleHotel {
  SingleHotel({
    this.hotelInfoResult,
  });

  HotelInfoResult? hotelInfoResult;

  factory SingleHotel.fromJson(Map<String, dynamic> json) => SingleHotel(
        hotelInfoResult: HotelInfoResult.fromJson(json["HotelInfoResult"]),
      );

  Map<String, dynamic> toJson() => {
        "HotelInfoResult": hotelInfoResult!.toJson(),
      };
}

class HotelInfoResult {
  HotelInfoResult({
    this.responseStatus,
    this.error,
    this.traceId,
    this.hotelDetails,
  });

  int? responseStatus;
  Error? error;
  String? traceId;
  HotelDetails? hotelDetails;

  factory HotelInfoResult.fromJson(Map<String, dynamic> json) =>
      HotelInfoResult(
        responseStatus: json["ResponseStatus"],
        error: Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        hotelDetails: json["HotelDetails"] == null
            ? null
            : HotelDetails.fromJson(json["HotelDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "ResponseStatus": responseStatus,
        "Error": error!.toJson(),
        "TraceId": traceId,
        "HotelDetails": hotelDetails!.toJson(),
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

class HotelDetails {
  HotelDetails({
    this.hotelName,
    this.starRating,
    this.hotelUrl,
    this.description,
    this.attractions,
    this.hotelFacilities,
    this.hotelPolicy,
    this.specialInstructions,
    this.hotelPicture,
    this.images,
    this.address,
    this.countryName,
    this.pinCode,
    this.hotelContactNo,
    this.faxNumber,
    this.email,
    this.latitude,
    this.longitude,
    this.roomData,
    this.roomFacilities,
    this.services,
  });

  String? hotelName;
  int? starRating;
  dynamic hotelUrl;
  String? description;
  List<Attraction>? attractions;
  List<String>? hotelFacilities;
  dynamic hotelPolicy;
  dynamic specialInstructions;
  dynamic hotelPicture;
  List<String>? images;
  String? address;
  String? countryName;
  String? pinCode;
  String? hotelContactNo;
  String? faxNumber;
  dynamic email;
  String? latitude;
  String? longitude;
  dynamic roomData;
  dynamic roomFacilities;
  dynamic services;

  factory HotelDetails.fromJson(Map<String, dynamic> json) => HotelDetails(
        hotelName: json["HotelName"],
        starRating: json["StarRating"],
        hotelUrl: json["HotelURL"],
        description: json["Description"],
        // attractions: List<Attraction>.from(json["Attractions"].map((x) => Attraction.fromJson(x))),
        hotelFacilities:
            List<String>.from(json["HotelFacilities"].map((x) => x)),
        hotelPolicy: json["HotelPolicy"],
        specialInstructions: json["SpecialInstructions"],
        hotelPicture: json["HotelPicture"],
        images: json["Images"] != null
            ? List<String>.from(json["Images"].map((x) => x))
            : [],
        address: json["Address"],
        countryName: json["CountryName"],
        pinCode: json["PinCode"],
        hotelContactNo: json["HotelContactNo"],
        faxNumber: json["FaxNumber"],
        email: json["Email"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        roomData: json["RoomData"],
        roomFacilities: json["RoomFacilities"],
        services: json["Services"],
      );

  Map<String, dynamic> toJson() => {
        "HotelName": hotelName,
        "StarRating": starRating,
        "HotelURL": hotelUrl,
        "Description": description,
        "Attractions": List<dynamic>.from(attractions!.map((x) => x.toJson())),
        "HotelFacilities": List<dynamic>.from(hotelFacilities!.map((x) => x)),
        "HotelPolicy": hotelPolicy,
        "SpecialInstructions": specialInstructions,
        "HotelPicture": hotelPicture,
        "Images": List<dynamic>.from(images!.map((x) => x)),
        "Address": address,
        "CountryName": countryName,
        "PinCode": pinCode,
        "HotelContactNo": hotelContactNo,
        "FaxNumber": faxNumber,
        "Email": email,
        "Latitude": latitude,
        "Longitude": longitude,
        "RoomData": roomData,
        "RoomFacilities": roomFacilities,
        "Services": services,
      };
}

class Attraction {
  Attraction({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        key: json["Key"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Key": key,
        "Value": value,
      };
}
