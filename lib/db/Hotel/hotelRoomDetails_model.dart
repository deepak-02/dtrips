// To parse this JSON data, do
//
//     final hotelRooms = hotelRoomsFromJson(jsonString);

import 'dart:convert';

HotelRooms hotelRoomsFromJson(String str) =>
    HotelRooms.fromJson(json.decode(str));

String hotelRoomsToJson(HotelRooms data) => json.encode(data.toJson());

class HotelRooms {
  HotelRooms({
    required this.getHotelRoomResult,
  });

  GetHotelRoomResult getHotelRoomResult;

  factory HotelRooms.fromJson(Map<String, dynamic> json) => HotelRooms(
        getHotelRoomResult:
            GetHotelRoomResult.fromJson(json["GetHotelRoomResult"]),
      );

  Map<String, dynamic> toJson() => {
        "GetHotelRoomResult": getHotelRoomResult.toJson(),
      };
}

class GetHotelRoomResult {
  GetHotelRoomResult({
    this.roomCombinationsArray,
    this.responseStatus,
    this.error,
    this.traceId,
    this.isUnderCancellationAllowed,
    this.isPolicyPerStay,
    this.hotelRoomsDetails,
  });

  List<RoomCombinationsArray>? roomCombinationsArray;
  dynamic responseStatus;
  Error? error;
  String? traceId;
  bool? isUnderCancellationAllowed;
  bool? isPolicyPerStay;
  List<HotelRoomsDetail>? hotelRoomsDetails;

  factory GetHotelRoomResult.fromJson(Map<String, dynamic> json) =>
      GetHotelRoomResult(
        roomCombinationsArray: List<RoomCombinationsArray>.from(
            json["RoomCombinationsArray"]
                .map((x) => RoomCombinationsArray.fromJson(x))),
        responseStatus: json["ResponseStatus"],
        error: Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        isUnderCancellationAllowed: json["IsUnderCancellationAllowed"],
        isPolicyPerStay: json["IsPolicyPerStay"],
        hotelRoomsDetails: List<HotelRoomsDetail>.from(
            json["HotelRoomsDetails"].map((x) => HotelRoomsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "RoomCombinationsArray":
            List<dynamic>.from(roomCombinationsArray!.map((x) => x.toJson())),
        "ResponseStatus": responseStatus,
        "Error": error!.toJson(),
        "TraceId": traceId,
        "IsUnderCancellationAllowed": isUnderCancellationAllowed,
        "IsPolicyPerStay": isPolicyPerStay,
        "HotelRoomsDetails":
            List<dynamic>.from(hotelRoomsDetails!.map((x) => x.toJson())),
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

class HotelRoomsDetail {
  HotelRoomsDetail({
    this.availabilityType,
    this.categoryId,
    this.childCount,
    this.requireAllPaxDetails,
    this.roomId,
    this.roomStatus,
    this.roomIndex,
    this.roomTypeCode,
    this.roomDescription,
    this.roomTypeName,
    this.ratePlanCode,
    this.ratePlan,
    this.ratePlanName,
    this.infoSource,
    this.sequenceNo,
    this.dayRates,
    this.isPerStay,
    this.supplierPrice,
    this.price,
    this.roomPromotion,
    this.amenities,
    this.amenity,
    this.smokingPreference,
    this.bedTypes,
    this.hotelSupplements,
    this.lastCancellationDate,
    this.cancellationPolicies,
    this.lastVoucherDate,
    this.cancellationPolicy,
    this.inclusion,
    this.isPassportMandatory,
    this.isPanMandatory,
  });

  String? availabilityType;
  String? categoryId;
  dynamic childCount;
  bool? requireAllPaxDetails;
  dynamic roomId;
  dynamic roomStatus;
  dynamic roomIndex;
  String? roomTypeCode;
  String? roomDescription;
  String? roomTypeName;
  String? ratePlanCode;
  dynamic ratePlan;
  String? ratePlanName;
  String? infoSource;
  String? sequenceNo;
  List<DayRate>? dayRates;
  bool? isPerStay;
  dynamic supplierPrice;
  Price? price;
  String? roomPromotion;
  List<String>? amenities;
  List<String>? amenity;
  String? smokingPreference;
  List<dynamic>? bedTypes;
  List<dynamic>? hotelSupplements;
  DateTime? lastCancellationDate;
  List<CancellationPolicy>? cancellationPolicies;
  DateTime? lastVoucherDate;
  String? cancellationPolicy;
  List<String>? inclusion;
  bool? isPassportMandatory;
  bool? isPanMandatory;

  factory HotelRoomsDetail.fromJson(Map<String, dynamic> json) =>
      HotelRoomsDetail(
        availabilityType: json["AvailabilityType"],
        categoryId: json["CategoryId"],
        childCount: json["ChildCount"],
        requireAllPaxDetails: json["RequireAllPaxDetails"],
        roomId: json["RoomId"],
        roomStatus: json["RoomStatus"],
        roomIndex: json["RoomIndex"],
        roomTypeCode: json["RoomTypeCode"],
        roomDescription: json["RoomDescription"],
        roomTypeName: json["RoomTypeName"],
        ratePlanCode: json["RatePlanCode"],
        ratePlan: json["RatePlan"],
        ratePlanName: json["RatePlanName"],
        infoSource: json["InfoSource"],
        sequenceNo: json["SequenceNo"],
        dayRates: List<DayRate>.from(
            json["DayRates"].map((x) => DayRate.fromJson(x))),
        isPerStay: json["IsPerStay"],
        supplierPrice: json["SupplierPrice"],
        price: Price.fromJson(json["Price"]),
        roomPromotion: json["RoomPromotion"],
        amenities: List<String>.from(json["Amenities"].map((x) => x)),
        amenity: List<String>.from(json["Amenity"].map((x) => x)),
        smokingPreference: json["SmokingPreference"],
        bedTypes: List<dynamic>.from(json["BedTypes"].map((x) => x)),
        hotelSupplements:
            List<dynamic>.from(json["HotelSupplements"].map((x) => x)),
        lastCancellationDate: DateTime.parse(json["LastCancellationDate"]),
        cancellationPolicies: List<CancellationPolicy>.from(
            json["CancellationPolicies"]
                .map((x) => CancellationPolicy.fromJson(x))),
        lastVoucherDate: DateTime.parse(json["LastVoucherDate"]),
        cancellationPolicy: json["CancellationPolicy"],
        inclusion: List<String>.from(json["Inclusion"].map((x) => x)),
        isPassportMandatory: json["IsPassportMandatory"],
        isPanMandatory: json["IsPANMandatory"],
      );

  Map<String, dynamic> toJson() => {
        "AvailabilityType": availabilityType,
        "CategoryId": categoryId,
        "ChildCount": childCount,
        "RequireAllPaxDetails": requireAllPaxDetails,
        "RoomId": roomId,
        "RoomStatus": roomStatus,
        "RoomIndex": roomIndex,
        "RoomTypeCode": roomTypeCode,
        "RoomDescription": roomDescription,
        "RoomTypeName": roomTypeName,
        "RatePlanCode": ratePlanCode,
        "RatePlan": ratePlan,
        "RatePlanName": ratePlanName,
        "InfoSource": infoSource,
        "SequenceNo": sequenceNo,
        "DayRates": List<dynamic>.from(dayRates!.map((x) => x.toJson())),
        "IsPerStay": isPerStay,
        "SupplierPrice": supplierPrice,
        "Price": price!.toJson(),
        "RoomPromotion": roomPromotion,
        "Amenities": List<dynamic>.from(amenities!.map((x) => x)),
        "Amenity": List<dynamic>.from(amenity!.map((x) => x)),
        "SmokingPreference": smokingPreference,
        "BedTypes": List<dynamic>.from(bedTypes!.map((x) => x)),
        "HotelSupplements": List<dynamic>.from(hotelSupplements!.map((x) => x)),
        "LastCancellationDate": lastCancellationDate!.toIso8601String(),
        "CancellationPolicies":
            List<dynamic>.from(cancellationPolicies!.map((x) => x.toJson())),
        "LastVoucherDate": lastVoucherDate!.toIso8601String(),
        "CancellationPolicy": cancellationPolicy,
        "Inclusion": List<dynamic>.from(inclusion!.map((x) => x)),
        "IsPassportMandatory": isPassportMandatory,
        "IsPANMandatory": isPanMandatory,
      };
}

class CancellationPolicy {
  CancellationPolicy({
    this.charge,
    this.chargeType,
    this.currency,
    this.fromDate,
    this.toDate,
  });

  dynamic charge;
  dynamic chargeType;
  String? currency;
  DateTime? fromDate;
  DateTime? toDate;

  factory CancellationPolicy.fromJson(Map<String, dynamic> json) =>
      CancellationPolicy(
        charge: json["Charge"],
        chargeType: json["ChargeType"],
        currency: json["Currency"],
        fromDate: DateTime.parse(json["FromDate"]),
        toDate: DateTime.parse(json["ToDate"]),
      );

  Map<String, dynamic> toJson() => {
        "Charge": charge,
        "ChargeType": chargeType,
        "Currency": currency,
        "FromDate": fromDate!.toIso8601String(),
        "ToDate": toDate!.toIso8601String(),
      };
}

class DayRate {
  DayRate({
    this.amount,
    this.date,
  });

  dynamic amount;
  DateTime? date;

  factory DayRate.fromJson(Map<String, dynamic> json) => DayRate(
        amount: json["Amount"].toDouble(),
        date: DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "Date": date!.toIso8601String(),
      };
}

class Price {
  Price({
    this.currencyCode,
    this.roomPrice,
    this.tax,
    this.extraGuestCharge,
    this.childCharge,
    this.otherCharges,
    this.discount,
    this.publishedPrice,
    this.publishedPriceRoundedOff,
    this.offeredPrice,
    this.offeredPriceRoundedOff,
    this.agentCommission,
    this.agentMarkUp,
    this.serviceTax,
    this.tcs,
    this.tds,
    this.serviceCharge,
    this.totalGstAmount,
    this.gst,
  });

  String? currencyCode;
  dynamic roomPrice;
  dynamic tax;
  dynamic extraGuestCharge;
  dynamic childCharge;
  dynamic otherCharges;
  dynamic discount;
  dynamic publishedPrice;
  dynamic publishedPriceRoundedOff;
  dynamic offeredPrice;
  dynamic offeredPriceRoundedOff;
  dynamic agentCommission;
  dynamic agentMarkUp;
  dynamic serviceTax;
  dynamic tcs;
  dynamic tds;
  dynamic serviceCharge;
  dynamic totalGstAmount;
  Gst? gst;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        currencyCode: json["CurrencyCode"],
        roomPrice: json["RoomPrice"].toDouble(),
        tax: json["Tax"].toDouble(),
        extraGuestCharge: json["ExtraGuestCharge"],
        childCharge: json["ChildCharge"],
        otherCharges: json["OtherCharges"].toDouble(),
        discount: json["Discount"],
        publishedPrice: json["PublishedPrice"].toDouble(),
        publishedPriceRoundedOff: json["PublishedPriceRoundedOff"],
        offeredPrice: json["OfferedPrice"].toDouble(),
        offeredPriceRoundedOff: json["OfferedPriceRoundedOff"],
        agentCommission: json["AgentCommission"],
        agentMarkUp: json["AgentMarkUp"],
        serviceTax: json["ServiceTax"].toDouble(),
        tcs: json["TCS"],
        tds: json["TDS"],
        serviceCharge: json["ServiceCharge"],
        totalGstAmount: json["TotalGSTAmount"].toDouble(),
        gst: Gst.fromJson(json["GST"]),
      );

  Map<String, dynamic> toJson() => {
        "CurrencyCode": currencyCode,
        "RoomPrice": roomPrice,
        "Tax": tax,
        "ExtraGuestCharge": extraGuestCharge,
        "ChildCharge": childCharge,
        "OtherCharges": otherCharges,
        "Discount": discount,
        "PublishedPrice": publishedPrice,
        "PublishedPriceRoundedOff": publishedPriceRoundedOff,
        "OfferedPrice": offeredPrice,
        "OfferedPriceRoundedOff": offeredPriceRoundedOff,
        "AgentCommission": agentCommission,
        "AgentMarkUp": agentMarkUp,
        "ServiceTax": serviceTax,
        "TCS": tcs,
        "TDS": tds,
        "ServiceCharge": serviceCharge,
        "TotalGSTAmount": totalGstAmount,
        "GST": gst!.toJson(),
      };
}

class Gst {
  Gst({
    this.cgstAmount,
    this.cgstRate,
    this.cessAmount,
    this.cessRate,
    this.igstAmount,
    this.igstRate,
    this.sgstAmount,
    this.sgstRate,
    this.taxableAmount,
  });

  dynamic cgstAmount;
  dynamic cgstRate;
  dynamic cessAmount;
  dynamic cessRate;
  dynamic igstAmount;
  dynamic igstRate;
  dynamic sgstAmount;
  dynamic sgstRate;
  dynamic taxableAmount;

  factory Gst.fromJson(Map<String, dynamic> json) => Gst(
        cgstAmount: json["CGSTAmount"],
        cgstRate: json["CGSTRate"],
        cessAmount: json["CessAmount"].toDouble(),
        cessRate: json["CessRate"],
        igstAmount: json["IGSTAmount"].toDouble(),
        igstRate: json["IGSTRate"],
        sgstAmount: json["SGSTAmount"],
        sgstRate: json["SGSTRate"],
        taxableAmount: json["TaxableAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "CGSTAmount": cgstAmount,
        "CGSTRate": cgstRate,
        "CessAmount": cessAmount,
        "CessRate": cessRate,
        "IGSTAmount": igstAmount,
        "IGSTRate": igstRate,
        "SGSTAmount": sgstAmount,
        "SGSTRate": sgstRate,
        "TaxableAmount": taxableAmount,
      };
}

class RoomCombinationsArray {
  RoomCombinationsArray({
    this.categoryId,
    this.infoSource,
    this.isPolicyPerStay,
    this.roomCombination,
  });

  String? categoryId;
  String? infoSource;
  bool? isPolicyPerStay;
  List<RoomCombination>? roomCombination;

  factory RoomCombinationsArray.fromJson(Map<String, dynamic> json) =>
      RoomCombinationsArray(
        categoryId: json["CategoryId"],
        infoSource: json["InfoSource"],
        isPolicyPerStay: json["IsPolicyPerStay"],
        roomCombination: List<RoomCombination>.from(
            json["RoomCombination"].map((x) => RoomCombination.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "InfoSource": infoSource,
        "IsPolicyPerStay": isPolicyPerStay,
        "RoomCombination":
            List<dynamic>.from(roomCombination!.map((x) => x.toJson())),
      };
}

class RoomCombination {
  RoomCombination({
    this.roomIndex,
  });

  List<int>? roomIndex;

  factory RoomCombination.fromJson(Map<String, dynamic> json) =>
      RoomCombination(
        roomIndex: List<int>.from(json["RoomIndex"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "RoomIndex": List<dynamic>.from(roomIndex!.map((x) => x)),
      };
}
