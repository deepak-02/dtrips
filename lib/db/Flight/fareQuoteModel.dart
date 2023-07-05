// To parse this JSON data, do
//
//     final fareQuoteModel = fareQuoteModelFromJson(jsonString);

import 'dart:convert';

FareQuoteModel fareQuoteModelFromJson(String str) =>
    FareQuoteModel.fromJson(json.decode(str));

String fareQuoteModelToJson(FareQuoteModel data) => json.encode(data.toJson());

class FareQuoteModel {
  Response? response;

  FareQuoteModel({
    this.response,
  });

  factory FareQuoteModel.fromJson(Map<String, dynamic> json) => FareQuoteModel(
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
  dynamic flightDetailChangeInfo;
  bool? isPriceChanged;
  int? responseStatus;
  Results? results;
  String? traceId;

  Response({
    this.error,
    this.flightDetailChangeInfo,
    this.isPriceChanged,
    this.responseStatus,
    this.results,
    this.traceId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        flightDetailChangeInfo: json["FlightDetailChangeInfo"],
        isPriceChanged: json["IsPriceChanged"],
        responseStatus: json["ResponseStatus"],
        results:
            json["Results"] == null ? null : Results.fromJson(json["Results"]),
        traceId: json["TraceId"],
      );

  Map<String, dynamic> toJson() => {
        "Error": error?.toJson(),
        "FlightDetailChangeInfo": flightDetailChangeInfo,
        "IsPriceChanged": isPriceChanged,
        "ResponseStatus": responseStatus,
        "Results": results?.toJson(),
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

class Results {
  bool? isHoldAllowedWithSsr;
  String? resultIndex;
  int? source;
  bool? isLcc;
  bool? isRefundable;
  bool? isPanRequiredAtBook;
  bool? isPanRequiredAtTicket;
  bool? isPassportRequiredAtBook;
  bool? isPassportRequiredAtTicket;
  bool? gstAllowed;
  bool? isCouponAppilcable;
  bool? isGstMandatory;
  bool? isHoldAllowed;
  dynamic airlineRemark;
  String? resultFareType;
  Fare? fare;
  List<FareBreakdown>? fareBreakdown;
  List<List<Segment>>? segments;
  String? lastTicketDate;
  String? ticketAdvisory;
  List<FareRule>? fareRules;
  PenaltyCharges? penaltyCharges;
  String? airlineCode;
  List<List<MiniFareRule>>? miniFareRules;
  String? validatingAirline;
  ResultsFareClassification? fareClassification;

  Results({
    this.isHoldAllowedWithSsr,
    this.resultIndex,
    this.source,
    this.isLcc,
    this.isRefundable,
    this.isPanRequiredAtBook,
    this.isPanRequiredAtTicket,
    this.isPassportRequiredAtBook,
    this.isPassportRequiredAtTicket,
    this.gstAllowed,
    this.isCouponAppilcable,
    this.isGstMandatory,
    this.isHoldAllowed,
    this.airlineRemark,
    this.resultFareType,
    this.fare,
    this.fareBreakdown,
    this.segments,
    this.lastTicketDate,
    this.ticketAdvisory,
    this.fareRules,
    this.penaltyCharges,
    this.airlineCode,
    this.miniFareRules,
    this.validatingAirline,
    this.fareClassification,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        isHoldAllowedWithSsr: json["IsHoldAllowedWithSSR"],
        resultIndex: json["ResultIndex"],
        source: json["Source"],
        isLcc: json["IsLCC"],
        isRefundable: json["IsRefundable"],
        isPanRequiredAtBook: json["IsPanRequiredAtBook"],
        isPanRequiredAtTicket: json["IsPanRequiredAtTicket"],
        isPassportRequiredAtBook: json["IsPassportRequiredAtBook"],
        isPassportRequiredAtTicket: json["IsPassportRequiredAtTicket"],
        gstAllowed: json["GSTAllowed"],
        isCouponAppilcable: json["IsCouponAppilcable"],
        isGstMandatory: json["IsGSTMandatory"],
        isHoldAllowed: json["IsHoldAllowed"],
        airlineRemark: json["AirlineRemark"],
        resultFareType: json["ResultFareType"],
        fare: json["Fare"] == null ? null : Fare.fromJson(json["Fare"]),
        fareBreakdown: json["FareBreakdown"] == null
            ? []
            : List<FareBreakdown>.from(
                json["FareBreakdown"]!.map((x) => FareBreakdown.fromJson(x))),
        segments: json["Segments"] == null
            ? []
            : List<List<Segment>>.from(json["Segments"]!.map(
                (x) => List<Segment>.from(x.map((x) => Segment.fromJson(x))))),
        lastTicketDate: json["LastTicketDate"],
        ticketAdvisory: json["TicketAdvisory"],
        fareRules: json["FareRules"] == null
            ? []
            : List<FareRule>.from(
                json["FareRules"]!.map((x) => FareRule.fromJson(x))),
        penaltyCharges: json["PenaltyCharges"] == null
            ? null
            : PenaltyCharges.fromJson(json["PenaltyCharges"]),
        airlineCode: json["AirlineCode"],
        miniFareRules: json["MiniFareRules"] == null
            ? []
            : List<List<MiniFareRule>>.from(json["MiniFareRules"]!.map((x) =>
                List<MiniFareRule>.from(
                    x.map((x) => MiniFareRule.fromJson(x))))),
        validatingAirline: json["ValidatingAirline"],
        fareClassification: json["FareClassification"] == null
            ? null
            : ResultsFareClassification.fromJson(json["FareClassification"]),
      );

  Map<String, dynamic> toJson() => {
        "IsHoldAllowedWithSSR": isHoldAllowedWithSsr,
        "ResultIndex": resultIndex,
        "Source": source,
        "IsLCC": isLcc,
        "IsRefundable": isRefundable,
        "IsPanRequiredAtBook": isPanRequiredAtBook,
        "IsPanRequiredAtTicket": isPanRequiredAtTicket,
        "IsPassportRequiredAtBook": isPassportRequiredAtBook,
        "IsPassportRequiredAtTicket": isPassportRequiredAtTicket,
        "GSTAllowed": gstAllowed,
        "IsCouponAppilcable": isCouponAppilcable,
        "IsGSTMandatory": isGstMandatory,
        "IsHoldAllowed": isHoldAllowed,
        "AirlineRemark": airlineRemark,
        "ResultFareType": resultFareType,
        "Fare": fare?.toJson(),
        "FareBreakdown": fareBreakdown == null
            ? []
            : List<dynamic>.from(fareBreakdown!.map((x) => x.toJson())),
        "Segments": segments == null
            ? []
            : List<dynamic>.from(segments!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "LastTicketDate": lastTicketDate,
        "TicketAdvisory": ticketAdvisory,
        "FareRules": fareRules == null
            ? []
            : List<dynamic>.from(fareRules!.map((x) => x.toJson())),
        "PenaltyCharges": penaltyCharges?.toJson(),
        "AirlineCode": airlineCode,
        "MiniFareRules": miniFareRules == null
            ? []
            : List<dynamic>.from(miniFareRules!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "ValidatingAirline": validatingAirline,
        "FareClassification": fareClassification?.toJson(),
      };
}

class Fare {
  String? currency;
  dynamic baseFare;
  dynamic tax;
  List<ChargeBu>? taxBreakup;
  dynamic yqTax;
  dynamic additionalTxnFeeOfrd;
  dynamic additionalTxnFeePub;
  dynamic pgCharge;
  dynamic otherCharges;
  List<ChargeBu>? chargeBu;
  dynamic discount;
  dynamic publishedFare;
  dynamic commissionEarned;
  dynamic plbEarned;
  dynamic incentiveEarned;
  dynamic offeredFare;
  dynamic tdsOnCommission;
  dynamic tdsOnPlb;
  dynamic tdsOnIncentive;
  dynamic serviceFee;
  dynamic totalBaggageCharges;
  dynamic totalMealCharges;
  dynamic totalSeatCharges;
  dynamic totalSpecialServiceCharges;

  Fare({
    this.currency,
    this.baseFare,
    this.tax,
    this.taxBreakup,
    this.yqTax,
    this.additionalTxnFeeOfrd,
    this.additionalTxnFeePub,
    this.pgCharge,
    this.otherCharges,
    this.chargeBu,
    this.discount,
    this.publishedFare,
    this.commissionEarned,
    this.plbEarned,
    this.incentiveEarned,
    this.offeredFare,
    this.tdsOnCommission,
    this.tdsOnPlb,
    this.tdsOnIncentive,
    this.serviceFee,
    this.totalBaggageCharges,
    this.totalMealCharges,
    this.totalSeatCharges,
    this.totalSpecialServiceCharges,
  });

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        currency: json["Currency"],
        baseFare: json["BaseFare"],
        tax: json["Tax"],
        taxBreakup: json["TaxBreakup"] == null
            ? []
            : List<ChargeBu>.from(
                json["TaxBreakup"]!.map((x) => ChargeBu.fromJson(x))),
        yqTax: json["YQTax"],
        additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
        additionalTxnFeePub: json["AdditionalTxnFeePub"],
        pgCharge: json["PGCharge"],
        otherCharges: json["OtherCharges"],
        chargeBu: json["ChargeBU"] == null
            ? []
            : List<ChargeBu>.from(
                json["ChargeBU"]!.map((x) => ChargeBu.fromJson(x))),
        discount: json["Discount"],
        publishedFare: json["PublishedFare"],
        commissionEarned: json["CommissionEarned"],
        plbEarned: json["PLBEarned"]?.toDouble(),
        incentiveEarned: json["IncentiveEarned"]?.toDouble(),
        offeredFare: json["OfferedFare"]?.toDouble(),
        tdsOnCommission: json["TdsOnCommission"],
        tdsOnPlb: json["TdsOnPLB"]?.toDouble(),
        tdsOnIncentive: json["TdsOnIncentive"]?.toDouble(),
        serviceFee: json["ServiceFee"],
        totalBaggageCharges: json["TotalBaggageCharges"],
        totalMealCharges: json["TotalMealCharges"],
        totalSeatCharges: json["TotalSeatCharges"],
        totalSpecialServiceCharges: json["TotalSpecialServiceCharges"],
      );

  Map<String, dynamic> toJson() => {
        "Currency": currency,
        "BaseFare": baseFare,
        "Tax": tax,
        "TaxBreakup": taxBreakup == null
            ? []
            : List<dynamic>.from(taxBreakup!.map((x) => x.toJson())),
        "YQTax": yqTax,
        "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
        "AdditionalTxnFeePub": additionalTxnFeePub,
        "PGCharge": pgCharge,
        "OtherCharges": otherCharges,
        "ChargeBU": chargeBu == null
            ? []
            : List<dynamic>.from(chargeBu!.map((x) => x.toJson())),
        "Discount": discount,
        "PublishedFare": publishedFare,
        "CommissionEarned": commissionEarned,
        "PLBEarned": plbEarned,
        "IncentiveEarned": incentiveEarned,
        "OfferedFare": offeredFare,
        "TdsOnCommission": tdsOnCommission,
        "TdsOnPLB": tdsOnPlb,
        "TdsOnIncentive": tdsOnIncentive,
        "ServiceFee": serviceFee,
        "TotalBaggageCharges": totalBaggageCharges,
        "TotalMealCharges": totalMealCharges,
        "TotalSeatCharges": totalSeatCharges,
        "TotalSpecialServiceCharges": totalSpecialServiceCharges,
      };
}

class ChargeBu {
  String? key;
  dynamic value;

  ChargeBu({
    this.key,
    this.value,
  });

  factory ChargeBu.fromJson(Map<String, dynamic> json) => ChargeBu(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class FareBreakdown {
  String? currency;
  dynamic passengerType;
  dynamic passengerCount;
  dynamic baseFare;
  dynamic tax;
  List<ChargeBu>? taxBreakUp;
  dynamic yqTax;
  dynamic additionalTxnFeeOfrd;
  dynamic additionalTxnFeePub;
  dynamic pgCharge;
  dynamic supplierReissueCharges;

  FareBreakdown({
    this.currency,
    this.passengerType,
    this.passengerCount,
    this.baseFare,
    this.tax,
    this.taxBreakUp,
    this.yqTax,
    this.additionalTxnFeeOfrd,
    this.additionalTxnFeePub,
    this.pgCharge,
    this.supplierReissueCharges,
  });

  factory FareBreakdown.fromJson(Map<String, dynamic> json) => FareBreakdown(
        currency: json["Currency"],
        passengerType: json["PassengerType"],
        passengerCount: json["PassengerCount"],
        baseFare: json["BaseFare"],
        tax: json["Tax"],
        taxBreakUp: json["TaxBreakUp"] == null
            ? []
            : List<ChargeBu>.from(
                json["TaxBreakUp"]!.map((x) => ChargeBu.fromJson(x))),
        yqTax: json["YQTax"],
        additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
        additionalTxnFeePub: json["AdditionalTxnFeePub"],
        pgCharge: json["PGCharge"],
        supplierReissueCharges: json["SupplierReissueCharges"],
      );

  Map<String, dynamic> toJson() => {
        "Currency": currency,
        "PassengerType": passengerType,
        "PassengerCount": passengerCount,
        "BaseFare": baseFare,
        "Tax": tax,
        "TaxBreakUp": taxBreakUp == null
            ? []
            : List<dynamic>.from(taxBreakUp!.map((x) => x.toJson())),
        "YQTax": yqTax,
        "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
        "AdditionalTxnFeePub": additionalTxnFeePub,
        "PGCharge": pgCharge,
        "SupplierReissueCharges": supplierReissueCharges,
      };
}

class ResultsFareClassification {
  String? color;
  String? type;

  ResultsFareClassification({
    this.color,
    this.type,
  });

  factory ResultsFareClassification.fromJson(Map<String, dynamic> json) =>
      ResultsFareClassification(
        color: json["Color"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Color": color,
        "Type": type,
      };
}

class FareRule {
  String? origin;
  String? destination;
  String? airline;
  String? fareBasisCode;
  String? fareRuleDetail;
  String? fareRestriction;
  String? fareFamilyCode;
  String? fareRuleIndex;

  FareRule({
    this.origin,
    this.destination,
    this.airline,
    this.fareBasisCode,
    this.fareRuleDetail,
    this.fareRestriction,
    this.fareFamilyCode,
    this.fareRuleIndex,
  });

  factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
        origin: json["Origin"],
        destination: json["Destination"],
        airline: json["Airline"],
        fareBasisCode: json["FareBasisCode"],
        fareRuleDetail: json["FareRuleDetail"],
        fareRestriction: json["FareRestriction"],
        fareFamilyCode: json["FareFamilyCode"],
        fareRuleIndex: json["FareRuleIndex"],
      );

  Map<String, dynamic> toJson() => {
        "Origin": origin,
        "Destination": destination,
        "Airline": airline,
        "FareBasisCode": fareBasisCode,
        "FareRuleDetail": fareRuleDetail,
        "FareRestriction": fareRestriction,
        "FareFamilyCode": fareFamilyCode,
        "FareRuleIndex": fareRuleIndex,
      };
}

class MiniFareRule {
  String? journeyPoints;
  String? type;
  dynamic from;
  dynamic to;
  dynamic unit;
  String? details;

  MiniFareRule({
    this.journeyPoints,
    this.type,
    this.from,
    this.to,
    this.unit,
    this.details,
  });

  factory MiniFareRule.fromJson(Map<String, dynamic> json) => MiniFareRule(
        journeyPoints: json["JourneyPoints"],
        type: json["Type"],
        from: json["From"],
        to: json["To"],
        unit: json["Unit"],
        details: json["Details"],
      );

  Map<String, dynamic> toJson() => {
        "JourneyPoints": journeyPoints,
        "Type": type,
        "From": from,
        "To": to,
        "Unit": unit,
        "Details": details,
      };
}

class PenaltyCharges {
  String? reissueCharge;

  PenaltyCharges({
    this.reissueCharge,
  });

  factory PenaltyCharges.fromJson(Map<String, dynamic> json) => PenaltyCharges(
        reissueCharge: json["ReissueCharge"],
      );

  Map<String, dynamic> toJson() => {
        "ReissueCharge": reissueCharge,
      };
}

class Segment {
  String? baggage;
  dynamic cabinBaggage;
  dynamic cabinClass;
  dynamic tripIndicator;
  dynamic segmentIndicator;
  Airline? airline;
  Origin? origin;
  Destination? destination;
  dynamic duration;
  dynamic groundTime;
  dynamic mile;
  bool? stopOver;
  String? flightInfoIndex;
  String? stopPoint;
  DateTime? stopPointArrivalTime;
  DateTime? stopPointDepartureTime;
  String? craft;
  dynamic remark;
  bool? isETicketEligible;
  String? flightStatus;
  String? status;
  SegmentFareClassification? fareClassification;
  dynamic accumulatedDuration;

  Segment({
    this.baggage,
    this.cabinBaggage,
    this.cabinClass,
    this.tripIndicator,
    this.segmentIndicator,
    this.airline,
    this.origin,
    this.destination,
    this.duration,
    this.groundTime,
    this.mile,
    this.stopOver,
    this.flightInfoIndex,
    this.stopPoint,
    this.stopPointArrivalTime,
    this.stopPointDepartureTime,
    this.craft,
    this.remark,
    this.isETicketEligible,
    this.flightStatus,
    this.status,
    this.fareClassification,
    this.accumulatedDuration,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        baggage: json["Baggage"],
        cabinBaggage: json["CabinBaggage"],
        cabinClass: json["CabinClass"],
        tripIndicator: json["TripIndicator"],
        segmentIndicator: json["SegmentIndicator"],
        airline:
            json["Airline"] == null ? null : Airline.fromJson(json["Airline"]),
        origin: json["Origin"] == null ? null : Origin.fromJson(json["Origin"]),
        destination: json["Destination"] == null
            ? null
            : Destination.fromJson(json["Destination"]),
        duration: json["Duration"],
        groundTime: json["GroundTime"],
        mile: json["Mile"],
        stopOver: json["StopOver"],
        flightInfoIndex: json["FlightInfoIndex"],
        stopPoint: json["StopPoint"],
        stopPointArrivalTime: json["StopPointArrivalTime"] == null
            ? null
            : DateTime.parse(json["StopPointArrivalTime"]),
        stopPointDepartureTime: json["StopPointDepartureTime"] == null
            ? null
            : DateTime.parse(json["StopPointDepartureTime"]),
        craft: json["Craft"],
        remark: json["Remark"],
        isETicketEligible: json["IsETicketEligible"],
        flightStatus: json["FlightStatus"],
        status: json["Status"],
        fareClassification: json["FareClassification"] == null
            ? null
            : SegmentFareClassification.fromJson(json["FareClassification"]),
        accumulatedDuration: json["AccumulatedDuration"],
      );

  Map<String, dynamic> toJson() => {
        "Baggage": baggage,
        "CabinBaggage": cabinBaggage,
        "CabinClass": cabinClass,
        "TripIndicator": tripIndicator,
        "SegmentIndicator": segmentIndicator,
        "Airline": airline?.toJson(),
        "Origin": origin?.toJson(),
        "Destination": destination?.toJson(),
        "Duration": duration,
        "GroundTime": groundTime,
        "Mile": mile,
        "StopOver": stopOver,
        "FlightInfoIndex": flightInfoIndex,
        "StopPoint": stopPoint,
        "StopPointArrivalTime": stopPointArrivalTime?.toIso8601String(),
        "StopPointDepartureTime": stopPointDepartureTime?.toIso8601String(),
        "Craft": craft,
        "Remark": remark,
        "IsETicketEligible": isETicketEligible,
        "FlightStatus": flightStatus,
        "Status": status,
        "FareClassification": fareClassification?.toJson(),
        "AccumulatedDuration": accumulatedDuration,
      };
}

class Airline {
  String? airlineCode;
  String? airlineName;
  String? flightNumber;
  String? fareClass;
  String? operatingCarrier;

  Airline({
    this.airlineCode,
    this.airlineName,
    this.flightNumber,
    this.fareClass,
    this.operatingCarrier,
  });

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        airlineCode: json["AirlineCode"],
        airlineName: json["AirlineName"],
        flightNumber: json["FlightNumber"],
        fareClass: json["FareClass"],
        operatingCarrier: json["OperatingCarrier"],
      );

  Map<String, dynamic> toJson() => {
        "AirlineCode": airlineCode,
        "AirlineName": airlineName,
        "FlightNumber": flightNumber,
        "FareClass": fareClass,
        "OperatingCarrier": operatingCarrier,
      };
}

class Destination {
  Airport? airport;
  DateTime? arrTime;

  Destination({
    this.airport,
    this.arrTime,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        airport:
            json["Airport"] == null ? null : Airport.fromJson(json["Airport"]),
        arrTime:
            json["ArrTime"] == null ? null : DateTime.parse(json["ArrTime"]),
      );

  Map<String, dynamic> toJson() => {
        "Airport": airport?.toJson(),
        "ArrTime": arrTime?.toIso8601String(),
      };
}

class Airport {
  String? airportCode;
  String? airportName;
  String? terminal;
  String? cityCode;
  String? cityName;
  String? countryCode;
  String? countryName;

  Airport({
    this.airportCode,
    this.airportName,
    this.terminal,
    this.cityCode,
    this.cityName,
    this.countryCode,
    this.countryName,
  });

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
        airportCode: json["AirportCode"],
        airportName: json["AirportName"],
        terminal: json["Terminal"],
        cityCode: json["CityCode"],
        cityName: json["CityName"],
        countryCode: json["CountryCode"],
        countryName: json["CountryName"],
      );

  Map<String, dynamic> toJson() => {
        "AirportCode": airportCode,
        "AirportName": airportName,
        "Terminal": terminal,
        "CityCode": cityCode,
        "CityName": cityName,
        "CountryCode": countryCode,
        "CountryName": countryName,
      };
}

class SegmentFareClassification {
  String? type;

  SegmentFareClassification({
    this.type,
  });

  factory SegmentFareClassification.fromJson(Map<String, dynamic> json) =>
      SegmentFareClassification(
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
      };
}

class Origin {
  Airport? airport;
  DateTime? depTime;

  Origin({
    this.airport,
    this.depTime,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => Origin(
        airport:
            json["Airport"] == null ? null : Airport.fromJson(json["Airport"]),
        depTime:
            json["DepTime"] == null ? null : DateTime.parse(json["DepTime"]),
      );

  Map<String, dynamic> toJson() => {
        "Airport": airport?.toJson(),
        "DepTime": depTime?.toIso8601String(),
      };
}
