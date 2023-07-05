// // To parse this JSON data, do
// //
// //     final blockRoom = blockRoomFromJson(jsonString);
//
// import 'dart:convert';
//
// BlockRoom blockRoomFromJson(String str) =>
//     BlockRoom.fromJson(json.decode(str));
//
// String blockRoomToJson(BlockRoom? data) => json.encode(data!.toJson());
//
// class BlockRoom {
//   BlockRoom({
//     this.blockRoomResult,
//   });
//
//   BlockRoomResult? blockRoomResult;
//
//   factory BlockRoom.fromJson(Map<String, dynamic> json) => BlockRoom(
//         blockRoomResult: BlockRoomResult.fromJson(json["BlockRoomResult"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "BlockRoomResult": blockRoomResult!.toJson(),
//       };
// }
//
// class BlockRoomResult {
//   BlockRoomResult({
//     this.traceId,
//     this.responseStatus,
//     this.error,
//     this.isCancellationPolicyChanged,
//     this.isHotelPolicyChanged,
//     this.isPriceChanged,
//     this.isPackageFare,
//     this.isDepartureDetailsMandatory,
//     this.isPackageDetailsMandatory,
//     this.gstAllowed,
//     this.hotelName,
//     this.addressLine1,
//     this.addressLine2,
//     this.starRating,
//     this.hotelPolicyDetail,
//     this.latitude,
//     this.longitude,
//     this.bookingAllowedForRoamer,
//     this.ancillaryServices,
//     this.validationInfo,
//   });
//
//   String? traceId;
//   int? responseStatus;
//   Error? error;
//   bool? isCancellationPolicyChanged;
//   bool? isHotelPolicyChanged;
//   bool? isPriceChanged;
//   bool? isPackageFare;
//   bool? isDepartureDetailsMandatory;
//   bool? isPackageDetailsMandatory;
//   bool? gstAllowed;
//   dynamic hotelName;
//   dynamic addressLine1;
//   dynamic addressLine2;
//   int? starRating;
//   dynamic hotelPolicyDetail;
//   dynamic latitude;
//   dynamic longitude;
//   bool? bookingAllowedForRoamer;
//   dynamic ancillaryServices;
//   dynamic validationInfo;
//
//   factory BlockRoomResult.fromJson(Map<String, dynamic> json) =>
//       BlockRoomResult(
//         traceId: json["TraceId"],
//         responseStatus: json["ResponseStatus"],
//         error: Error.fromJson(json["Error"]),
//         isCancellationPolicyChanged: json["IsCancellationPolicyChanged"],
//         isHotelPolicyChanged: json["IsHotelPolicyChanged"],
//         isPriceChanged: json["IsPriceChanged"],
//         isPackageFare: json["IsPackageFare"],
//         isDepartureDetailsMandatory: json["IsDepartureDetailsMandatory"],
//         isPackageDetailsMandatory: json["IsPackageDetailsMandatory"],
//         gstAllowed: json["GSTAllowed"],
//         hotelName: json["HotelName"],
//         addressLine1: json["AddressLine1"],
//         addressLine2: json["AddressLine2"],
//         starRating: json["StarRating"],
//         hotelPolicyDetail: json["HotelPolicyDetail"],
//         latitude: json["Latitude"],
//         longitude: json["Longitude"],
//         bookingAllowedForRoamer: json["BookingAllowedForRoamer"],
//         ancillaryServices: json["AncillaryServices"],
//         validationInfo: json["ValidationInfo"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "TraceId": traceId,
//         "ResponseStatus": responseStatus,
//         "Error": error!.toJson(),
//         "IsCancellationPolicyChanged": isCancellationPolicyChanged,
//         "IsHotelPolicyChanged": isHotelPolicyChanged,
//         "IsPriceChanged": isPriceChanged,
//         "IsPackageFare": isPackageFare,
//         "IsDepartureDetailsMandatory": isDepartureDetailsMandatory,
//         "IsPackageDetailsMandatory": isPackageDetailsMandatory,
//         "GSTAllowed": gstAllowed,
//         "HotelName": hotelName,
//         "AddressLine1": addressLine1,
//         "AddressLine2": addressLine2,
//         "StarRating": starRating,
//         "HotelPolicyDetail": hotelPolicyDetail,
//         "Latitude": latitude,
//         "Longitude": longitude,
//         "BookingAllowedForRoamer": bookingAllowedForRoamer,
//         "AncillaryServices": ancillaryServices,
//         "ValidationInfo": validationInfo,
//       };
// }
//
// class Error {
//   Error({
//     this.errorCode,
//     this.errorMessage,
//   });
//
//   int? errorCode;
//   String? errorMessage;
//
//   factory Error.fromJson(Map<String, dynamic> json) => Error(
//         errorCode: json["ErrorCode"],
//         errorMessage: json["ErrorMessage"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "ErrorCode": errorCode,
//         "ErrorMessage": errorMessage,
//       };
// }

import 'dart:convert';

BlockRoom blockRoomFromJson(String str) => BlockRoom.fromJson(json.decode(str));

String blockRoomToJson(BlockRoom data) => json.encode(data.toJson());

class BlockRoom {
  BlockRoom({
    this.blockRoomResult,
  });

  BlockRoomResult? blockRoomResult;

  factory BlockRoom.fromJson(Map<String, dynamic> json) => BlockRoom(
        blockRoomResult: BlockRoomResult.fromJson(json["BlockRoomResult"]),
      );

  Map<String, dynamic> toJson() => {
        "BlockRoomResult": blockRoomResult!.toJson(),
      };
}

class BlockRoomResult {
  BlockRoomResult({
    this.traceId,
    this.responseStatus,
    this.error,
    this.isCancellationPolicyChanged,
    this.isHotelPolicyChanged,
    this.isPriceChanged,
    this.isPackageFare,
    this.isDepartureDetailsMandatory,
    this.isPackageDetailsMandatory,
    this.availabilityType,
    this.gstAllowed,
    this.hotelNorms,
    this.hotelName,
    this.addressLine1,
    this.addressLine2,
    this.starRating,
    this.hotelPolicyDetail,
    this.latitude,
    this.longitude,
    this.bookingAllowedForRoamer,
    this.ancillaryServices,
    this.hotelRoomsDetails,
    this.validationInfo,
  });

  String? traceId;
  int? responseStatus;
  Error? error;
  bool? isCancellationPolicyChanged;
  bool? isHotelPolicyChanged;
  bool? isPriceChanged;
  bool? isPackageFare;
  bool? isDepartureDetailsMandatory;
  bool? isPackageDetailsMandatory;
  dynamic availabilityType;
  bool? gstAllowed;
  dynamic hotelNorms;
  dynamic hotelName;
  dynamic addressLine1;
  dynamic addressLine2;
  int? starRating;
  dynamic hotelPolicyDetail;
  dynamic latitude;
  dynamic longitude;
  bool? bookingAllowedForRoamer;
  List<dynamic>? ancillaryServices;
  List<HotelRoomsDetails>? hotelRoomsDetails;
  dynamic validationInfo;

  factory BlockRoomResult.fromJson(Map<String, dynamic> json) =>
      BlockRoomResult(
        traceId: json["TraceId"],
        responseStatus: json["ResponseStatus"],
        error: Error.fromJson(json["Error"]),
        isCancellationPolicyChanged: json["IsCancellationPolicyChanged"],
        isHotelPolicyChanged: json["IsHotelPolicyChanged"],
        isPriceChanged: json["IsPriceChanged"],
        isPackageFare: json["IsPackageFare"],
        isDepartureDetailsMandatory: json["IsDepartureDetailsMandatory"],
        isPackageDetailsMandatory: json["IsPackageDetailsMandatory"],
        availabilityType: json["AvailabilityType"],
        gstAllowed: json["GSTAllowed"],
        hotelNorms: json["HotelNorms"],
        hotelName: json["HotelName"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        starRating: json["StarRating"],
        hotelPolicyDetail: json["HotelPolicyDetail"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        bookingAllowedForRoamer: json["BookingAllowedForRoamer"],
        ancillaryServices: json["AncillaryServices"] == null
            ? null
            : List<dynamic>.from(json["AncillaryServices"].map((x) => x)),
        hotelRoomsDetails: json["HotelRoomsDetails"] == null
            ? null
            : List<HotelRoomsDetails>.from(json["HotelRoomsDetails"]
                .map((x) => HotelRoomsDetails.fromJson(x))),
        validationInfo: json["ValidationInfo"] == null
            ? null
            : ValidationInfo.fromJson(json["ValidationInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "TraceId": traceId,
        "ResponseStatus": responseStatus,
        "Error": error!.toJson(),
        "IsCancellationPolicyChanged": isCancellationPolicyChanged,
        "IsHotelPolicyChanged": isHotelPolicyChanged,
        "IsPriceChanged": isPriceChanged,
        "IsPackageFare": isPackageFare,
        "IsDepartureDetailsMandatory": isDepartureDetailsMandatory,
        "IsPackageDetailsMandatory": isPackageDetailsMandatory,
        "AvailabilityType": availabilityType,
        "GSTAllowed": gstAllowed,
        "HotelNorms": hotelNorms,
        "HotelName": hotelName,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "StarRating": starRating,
        "HotelPolicyDetail": hotelPolicyDetail,
        "Latitude": latitude,
        "Longitude": longitude,
        "BookingAllowedForRoamer": bookingAllowedForRoamer,
        "AncillaryServices":
            List<dynamic>.from(ancillaryServices!.map((x) => x)),
        "HotelRoomsDetails":
            List<dynamic>.from(hotelRoomsDetails!.map((x) => x.toJson())),
        "ValidationInfo": validationInfo.toJson(),
      };
}

class Error {
  Error({
    this.errorCode,
    this.errorMessage,
  });

  int? errorCode;
  dynamic errorMessage;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json["ErrorCode"],
        errorMessage: json["ErrorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "ErrorMessage": errorMessage,
      };
}

class HotelRoomsDetails {
  HotelRoomsDetails({
    this.availabilityType,
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
    this.supplierSpecificData,
    this.cancellationPolicies,
    this.lastVoucherDate,
    this.cancellationPolicy,
    this.inclusion,
    this.isPassportMandatory,
    this.isPanMandatory,
  });

  dynamic availabilityType;
  int? childCount;
  bool? requireAllPaxDetails;
  int? roomId;
  int? roomStatus;
  int? roomIndex;
  dynamic roomTypeCode;
  dynamic roomDescription;
  dynamic roomTypeName;
  dynamic ratePlanCode;
  dynamic ratePlan;
  dynamic ratePlanName;
  dynamic infoSource;
  dynamic sequenceNo;
  List<DayRate>? dayRates;
  bool? isPerStay;
  dynamic supplierPrice;
  Price? price;
  dynamic roomPromotion;
  List<String>? amenities;
  List<String>? amenity;
  dynamic smokingPreference;
  List<dynamic>? bedTypes;
  List<dynamic>? hotelSupplements;
  dynamic lastCancellationDate;
  dynamic supplierSpecificData;
  List<CancellationPolicy>? cancellationPolicies;
  dynamic lastVoucherDate;
  dynamic cancellationPolicy;
  List<String>? inclusion;
  bool? isPassportMandatory;
  bool? isPanMandatory;

  factory HotelRoomsDetails.fromJson(Map<String, dynamic> json) =>
      HotelRoomsDetails(
        availabilityType: json["AvailabilityType"],
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
        dayRates: json["DayRates"] == null
            ? null
            : List<DayRate>.from(
                json["DayRates"].map((x) => DayRate.fromJson(x))),
        isPerStay: json["IsPerStay"],
        supplierPrice: json["SupplierPrice"],
        price: json["Price"] == null ? null : Price.fromJson(json["Price"]),
        roomPromotion: json["RoomPromotion"],
        amenities: json["Amenities"] == null
            ? null
            : List<String>.from(json["Amenities"].map((x) => x)),
        amenity: json["Amenity"] == null
            ? null
            : List<String>.from(json["Amenity"].map((x) => x)),
        smokingPreference: json["SmokingPreference"],
        bedTypes: json["BedTypes"] == null
            ? null
            : List<dynamic>.from(json["BedTypes"].map((x) => x)),
        hotelSupplements: json["HotelSupplements"] == null
            ? null
            : List<dynamic>.from(json["HotelSupplements"].map((x) => x)),
        lastCancellationDate: DateTime.parse(json["LastCancellationDate"]),
        supplierSpecificData: json["SupplierSpecificData"],
        cancellationPolicies: json["CancellationPolicies"] == null
            ? null
            : List<CancellationPolicy>.from(json["CancellationPolicies"]
                .map((x) => CancellationPolicy.fromJson(x))),
        lastVoucherDate: DateTime.parse(json["LastVoucherDate"]),
        cancellationPolicy: json["CancellationPolicy"],
        inclusion: json["Inclusion"] == null
            ? null
            : List<String>.from(json["Inclusion"].map((x) => x)),
        isPassportMandatory: json["IsPassportMandatory"],
        isPanMandatory: json["IsPANMandatory"],
      );

  Map<String, dynamic> toJson() => {
        "AvailabilityType": availabilityType,
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
        "LastCancellationDate": lastCancellationDate.toIso8601String(),
        "SupplierSpecificData": supplierSpecificData,
        "CancellationPolicies":
            List<dynamic>.from(cancellationPolicies!.map((x) => x.toJson())),
        "LastVoucherDate": lastVoucherDate.toIso8601String(),
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
  dynamic currency;
  dynamic fromDate;
  dynamic toDate;

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
        "FromDate": fromDate.toIso8601String(),
        "ToDate": toDate.toIso8601String(),
      };
}

class DayRate {
  DayRate({
    this.amount,
    this.date,
  });

  dynamic amount;
  dynamic date;

  factory DayRate.fromJson(Map<String, dynamic> json) => DayRate(
        amount: json["Amount"].toDouble(),
        date: DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "Date": date.toIso8601String(),
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

  dynamic currencyCode;
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
  dynamic gst;

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
        agentCommission: json["AgentCommission"].toDouble(),
        agentMarkUp: json["AgentMarkUp"],
        serviceTax: json["ServiceTax"].toDouble(),
        tcs: json["TCS"],
        tds: json["TDS"].toDouble(),
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
        "GST": gst.toJson(),
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

class ValidationInfo {
  ValidationInfo({
    this.validationAtConfirm,
    this.validationAtVoucher,
  });

  ValidationAt? validationAtConfirm;
  ValidationAt? validationAtVoucher;

  factory ValidationInfo.fromJson(Map<String, dynamic> json) => ValidationInfo(
        validationAtConfirm: ValidationAt.fromJson(json["ValidationAtConfirm"]),
        validationAtVoucher: ValidationAt.fromJson(json["ValidationAtVoucher"]),
      );

  Map<String, dynamic> toJson() => {
        "ValidationAtConfirm": validationAtConfirm!.toJson(),
        "ValidationAtVoucher": validationAtVoucher!.toJson(),
      };
}

class ValidationAt {
  ValidationAt({
    this.isAgencyOwnPanAllowed,
    this.isCorporateBookingAllowed,
    this.isCrpPanMandatory,
    this.isCrpPassportCopyMandatory,
    this.isCrpPassportMandatory,
    this.isCrpSamePanForAllAllowed,
    this.isEmailMandatory,
    this.isPanCopyPanMandatory,
    this.isPanMandatory,
    this.isPassportCopyMandatory,
    this.isPassportMandatory,
    this.isSamePanForAllAllowed,
    this.noOfPanRequired,
  });

  bool? isAgencyOwnPanAllowed;
  bool? isCorporateBookingAllowed;
  bool? isCrpPanMandatory;
  bool? isCrpPassportCopyMandatory;
  bool? isCrpPassportMandatory;
  bool? isCrpSamePanForAllAllowed;
  bool? isEmailMandatory;
  bool? isPanCopyPanMandatory;
  bool? isPanMandatory;
  bool? isPassportCopyMandatory;
  bool? isPassportMandatory;
  bool? isSamePanForAllAllowed;
  int? noOfPanRequired;

  factory ValidationAt.fromJson(Map<String, dynamic> json) => ValidationAt(
        isAgencyOwnPanAllowed: json["IsAgencyOwnPANAllowed"],
        isCorporateBookingAllowed: json["IsCorporateBookingAllowed"],
        isCrpPanMandatory: json["IsCrpPANMandatory"],
        isCrpPassportCopyMandatory: json["IsCrpPassportCopyMandatory"],
        isCrpPassportMandatory: json["IsCrpPassportMandatory"],
        isCrpSamePanForAllAllowed: json["IsCrpSamePANForAllAllowed"],
        isEmailMandatory: json["IsEmailMandatory"],
        isPanCopyPanMandatory: json["IsPANCopyPANMandatory"],
        isPanMandatory: json["IsPANMandatory"],
        isPassportCopyMandatory: json["IsPassportCopyMandatory"],
        isPassportMandatory: json["IsPassportMandatory"],
        isSamePanForAllAllowed: json["IsSamePANForAllAllowed"],
        noOfPanRequired: json["NoOfPANRequired"],
      );

  Map<String, dynamic> toJson() => {
        "IsAgencyOwnPANAllowed": isAgencyOwnPanAllowed,
        "IsCorporateBookingAllowed": isCorporateBookingAllowed,
        "IsCrpPANMandatory": isCrpPanMandatory,
        "IsCrpPassportCopyMandatory": isCrpPassportCopyMandatory,
        "IsCrpPassportMandatory": isCrpPassportMandatory,
        "IsCrpSamePANForAllAllowed": isCrpSamePanForAllAllowed,
        "IsEmailMandatory": isEmailMandatory,
        "IsPANCopyPANMandatory": isPanCopyPanMandatory,
        "IsPANMandatory": isPanMandatory,
        "IsPassportCopyMandatory": isPassportCopyMandatory,
        "IsPassportMandatory": isPassportMandatory,
        "IsSamePANForAllAllowed": isSamePanForAllAllowed,
        "NoOfPANRequired": noOfPanRequired,
      };
}
