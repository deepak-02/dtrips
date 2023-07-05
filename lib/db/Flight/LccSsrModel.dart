// To parse this JSON data, do
//
//     final ssrWithLccModel = ssrWithLccModelFromJson(jsonString);

import 'dart:convert';

SsrWithLccModel ssrWithLccModelFromJson(String str) =>
    SsrWithLccModel.fromJson(json.decode(str));

String ssrWithLccModelToJson(SsrWithLccModel data) =>
    json.encode(data.toJson());

class SsrWithLccModel {
  Response? response;

  SsrWithLccModel({
    this.response,
  });

  factory SsrWithLccModel.fromJson(Map<String, dynamic> json) =>
      SsrWithLccModel(
        response: json["Response"] == null
            ? null
            : Response.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response?.toJson(),
      };
}

class Response {
  int? responseStatus;
  Error? error;
  String? traceId;
  List<List<Baggage>>? baggage;
  List<List<Baggage>>? mealDynamic;
  List<SeatDynamic>? seatDynamic;
  List<SpecialService>? specialServices;

  Response({
    this.responseStatus,
    this.error,
    this.traceId,
    this.baggage,
    this.mealDynamic,
    this.seatDynamic,
    this.specialServices,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        responseStatus: json["ResponseStatus"],
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        baggage: json["Baggage"] == null
            ? []
            : List<List<Baggage>>.from(json["Baggage"]!.map(
                (x) => List<Baggage>.from(x.map((x) => Baggage.fromJson(x))))),
        mealDynamic: json["MealDynamic"] == null
            ? []
            : List<List<Baggage>>.from(json["MealDynamic"]!.map(
                (x) => List<Baggage>.from(x.map((x) => Baggage.fromJson(x))))),
        seatDynamic: json["SeatDynamic"] == null
            ? []
            : List<SeatDynamic>.from(
                json["SeatDynamic"]!.map((x) => SeatDynamic.fromJson(x))),
        specialServices: json["SpecialServices"] == null
            ? []
            : List<SpecialService>.from(json["SpecialServices"]!
                .map((x) => SpecialService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseStatus": responseStatus,
        "Error": error?.toJson(),
        "TraceId": traceId,
        "Baggage": baggage == null
            ? []
            : List<dynamic>.from(baggage!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "MealDynamic": mealDynamic == null
            ? []
            : List<dynamic>.from(mealDynamic!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "SeatDynamic": seatDynamic == null
            ? []
            : List<dynamic>.from(seatDynamic!.map((x) => x.toJson())),
        "SpecialServices": specialServices == null
            ? []
            : List<dynamic>.from(specialServices!.map((x) => x.toJson())),
      };
}

class Baggage {
  String? airlineCode;
  String? flightNumber;
  dynamic wayType;
  String? code;
  dynamic description;
  dynamic weight;
  String? currency;
  dynamic price;
  String? origin;
  String? destination;
  String? airlineDescription;
  dynamic quantity;

  Baggage({
    this.airlineCode,
    this.flightNumber,
    this.wayType,
    this.code,
    this.description,
    this.weight,
    this.currency,
    this.price,
    this.origin,
    this.destination,
    this.airlineDescription,
    this.quantity,
  });

  factory Baggage.fromJson(Map<String, dynamic> json) => Baggage(
        airlineCode: json["AirlineCode"],
        flightNumber: json["FlightNumber"],
        wayType: json["WayType"],
        code: json["Code"],
        description: json["Description"],
        weight: json["Weight"],
        currency: json["Currency"],
        price: json["Price"],
        origin: json["Origin"],
        destination: json["Destination"],
        airlineDescription: json["AirlineDescription"],
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "AirlineCode": airlineCode,
        "FlightNumber": flightNumber,
        "WayType": wayType,
        "Code": code,
        "Description": description,
        "Weight": weight,
        "Currency": currency,
        "Price": price,
        "Origin": origin,
        "Destination": destination,
        "AirlineDescription": airlineDescription,
        "Quantity": quantity,
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

class SeatDynamic {
  List<SegmentSeat>? segmentSeat;

  SeatDynamic({
    this.segmentSeat,
  });

  factory SeatDynamic.fromJson(Map<String, dynamic> json) => SeatDynamic(
        segmentSeat: json["SegmentSeat"] == null
            ? []
            : List<SegmentSeat>.from(
                json["SegmentSeat"]!.map((x) => SegmentSeat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SegmentSeat": segmentSeat == null
            ? []
            : List<dynamic>.from(segmentSeat!.map((x) => x.toJson())),
      };
}

class SegmentSeat {
  List<RowSeat>? rowSeats;

  SegmentSeat({
    this.rowSeats,
  });

  factory SegmentSeat.fromJson(Map<String, dynamic> json) => SegmentSeat(
        rowSeats: json["RowSeats"] == null
            ? []
            : List<RowSeat>.from(
                json["RowSeats"]!.map((x) => RowSeat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "RowSeats": rowSeats == null
            ? []
            : List<dynamic>.from(rowSeats!.map((x) => x.toJson())),
      };
}

class RowSeat {
  List<Seat>? seats;

  RowSeat({
    this.seats,
  });

  factory RowSeat.fromJson(Map<String, dynamic> json) => RowSeat(
        seats: json["Seats"] == null
            ? []
            : List<Seat>.from(json["Seats"]!.map((x) => Seat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Seats": seats == null
            ? []
            : List<dynamic>.from(seats!.map((x) => x.toJson())),
      };
}

class Seat {
  String? airlineCode;
  String? flightNumber;
  String? craftType;
  String? origin;
  String? destination;
  dynamic availablityType;
  dynamic description;
  String? code;
  String? rowNo;
  String? seatNo;
  dynamic seatType;
  dynamic seatWayType;
  dynamic compartment;
  dynamic deck;
  String? currency;
  dynamic price;

  Seat({
    this.airlineCode,
    this.flightNumber,
    this.craftType,
    this.origin,
    this.destination,
    this.availablityType,
    this.description,
    this.code,
    this.rowNo,
    this.seatNo,
    this.seatType,
    this.seatWayType,
    this.compartment,
    this.deck,
    this.currency,
    this.price,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        airlineCode: json["AirlineCode"],
        flightNumber: json["FlightNumber"],
        craftType: json["CraftType"],
        origin: json["Origin"],
        destination: json["Destination"],
        availablityType: json["AvailablityType"],
        description: json["Description"],
        code: json["Code"],
        rowNo: json["RowNo"],
        seatNo: json["SeatNo"],
        seatType: json["SeatType"],
        seatWayType: json["SeatWayType"],
        compartment: json["Compartment"],
        deck: json["Deck"],
        currency: json["Currency"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "AirlineCode": airlineCode,
        "FlightNumber": flightNumber,
        "CraftType": craftType,
        "Origin": origin,
        "Destination": destination,
        "AvailablityType": availablityType,
        "Description": description,
        "Code": code,
        "RowNo": rowNo,
        "SeatNo": seatNo,
        "SeatType": seatType,
        "SeatWayType": seatWayType,
        "Compartment": compartment,
        "Deck": deck,
        "Currency": currency,
        "Price": price,
      };
}

class SpecialService {
  List<SegmentSpecialService>? segmentSpecialService;

  SpecialService({
    this.segmentSpecialService,
  });

  factory SpecialService.fromJson(Map<String, dynamic> json) => SpecialService(
        segmentSpecialService: json["SegmentSpecialService"] == null
            ? []
            : List<SegmentSpecialService>.from(json["SegmentSpecialService"]!
                .map((x) => SegmentSpecialService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SegmentSpecialService": segmentSpecialService == null
            ? []
            : List<dynamic>.from(segmentSpecialService!.map((x) => x.toJson())),
      };
}

class SegmentSpecialService {
  List<SsrService>? ssrService;

  SegmentSpecialService({
    this.ssrService,
  });

  factory SegmentSpecialService.fromJson(Map<String, dynamic> json) =>
      SegmentSpecialService(
        ssrService: json["SSRService"] == null
            ? []
            : List<SsrService>.from(
                json["SSRService"]!.map((x) => SsrService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SSRService": ssrService == null
            ? []
            : List<dynamic>.from(ssrService!.map((x) => x.toJson())),
      };
}

class SsrService {
  String? origin;
  String? destination;
  DateTime? departureTime;
  String? airlineCode;
  String? flightNumber;
  String? code;
  dynamic serviceType;
  String? text;
  dynamic wayType;
  String? currency;
  dynamic price;

  SsrService({
    this.origin,
    this.destination,
    this.departureTime,
    this.airlineCode,
    this.flightNumber,
    this.code,
    this.serviceType,
    this.text,
    this.wayType,
    this.currency,
    this.price,
  });

  factory SsrService.fromJson(Map<String, dynamic> json) => SsrService(
        origin: json["Origin"],
        destination: json["Destination"],
        departureTime: json["DepartureTime"] == null
            ? null
            : DateTime.parse(json["DepartureTime"]),
        airlineCode: json["AirlineCode"],
        flightNumber: json["FlightNumber"],
        code: json["Code"],
        serviceType: json["ServiceType"],
        text: json["Text"],
        wayType: json["WayType"],
        currency: json["Currency"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "Origin": origin,
        "Destination": destination,
        "DepartureTime": departureTime?.toIso8601String(),
        "AirlineCode": airlineCode,
        "FlightNumber": flightNumber,
        "Code": code,
        "ServiceType": serviceType,
        "Text": text,
        "WayType": wayType,
        "Currency": currency,
        "Price": price,
      };
}
