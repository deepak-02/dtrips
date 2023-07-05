// // To parse this JSON data, do
// //
// //     final flightSearchModel = flightSearchModelFromJson(jsonString);
//
// import 'dart:convert';
//
// FlightSearchModel flightSearchModelFromJson(String str) => FlightSearchModel.fromJson(json.decode(str));
//
// String flightSearchModelToJson(FlightSearchModel data) => json.encode(data.toJson());
//
// class FlightSearchModel {
//   Response ? response;
//   String ? token;
//
//   FlightSearchModel({
//     this.response,
//     this.token,
//   });
//
//   factory FlightSearchModel.fromJson(Map<String, dynamic> json) => FlightSearchModel(
//     response: Response.fromJson(json["Response"]),
//     token: json["Token"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Response": response!.toJson(),
//     "Token": token,
//   };
// }
//
// class Response {
//   dynamic responseStatus;
//   Error ? error;
//   dynamic traceId;
//   DestinationEnum ? origin;
//   DestinationEnum ? destination;
//   List<List<Result>> ? results;
//
//   Response({
//     this.responseStatus,
//     this.error,
//     this.traceId,
//     this.origin,
//     this.destination,
//     this.results,
//   });
//
//   factory Response.fromJson(Map<String, dynamic> json) {
//     return Response(
//       responseStatus: json["ResponseStatus"],
//       error: Error.fromJson(json["Error"]),
//       traceId: json["TraceId"],
//       origin: json["Origin"] != null ? destinationEnumValues.map[json["Origin"]] : null,
//       destination: json["Destination"] != null ? destinationEnumValues.map[json["Destination"]] : null,
//       results: json["Results"] != null
//           ? List<List<Result>>.from(json["Results"].map(
//               (x) => x != null ? List<Result>.from(x.map((y) => y != null ? Result.fromJson(y) : null)) : null))
//           : [[]], // Assign an empty list to results if it's null or missing
//     );
//   }
//
//
//   Map<String, dynamic> toJson() => {
//     "ResponseStatus": responseStatus,
//     "Error": error!.toJson(),
//     "TraceId": traceId,
//     "Origin": destinationEnumValues.reverse[origin],
//     "Destination": destinationEnumValues.reverse[destination],
//     "Results": List<dynamic>.from(results!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
//   };
// }
//
// enum DestinationEnum { BOM, BLR, GOI, AMD, HYD, DEL }
//
// final destinationEnumValues = EnumValues({
//   "AMD": DestinationEnum.AMD,
//   "BLR": DestinationEnum.BLR,
//   "BOM": DestinationEnum.BOM,
//   "DEL": DestinationEnum.DEL,
//   "GOI": DestinationEnum.GOI,
//   "HYD": DestinationEnum.HYD
// });
//
// class Error {
//   dynamic errorCode;
//   dynamic errorMessage;
//
//   Error({
//     this.errorCode,
//     this.errorMessage,
//   });
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
// class Result {
//   bool ? isHoldAllowedWithSsr;
//   dynamic resultIndex;
//   dynamic source;
//   bool ? isLcc;
//   bool ? isRefundable;
//   bool ? isPanRequiredAtBook;
//   bool ? isPanRequiredAtTicket;
//   bool ? isPassportRequiredAtBook;
//   bool ? isPassportRequiredAtTicket;
//   bool ? gstAllowed;
//   bool ? isCouponAppilcable;
//   bool ? isGstMandatory;
//   dynamic airlineRemark;
//   ResultFareType ? resultFareType;
//   Fare ? fare;
//   List<FareBreakdown> ? fareBreakdown;
//   List<List<Segment>> ? segments;
//   LastTicketDate ? lastTicketDate;
//   dynamic ticketAdvisory;
//   List<FareRule> ? fareRules;
//   AirlineCode ? airlineCode;
//   List<List<MiniFareRule>> ? miniFareRules;
//   AirlineCode ? validatingAirline;
//   ResultFareClassification ? fareClassification;
//   bool ? isUpsellAllowed;
//   PenaltyCharges ? penaltyCharges;
//
//   Result({
//     this.isHoldAllowedWithSsr,
//     this.resultIndex,
//     this.source,
//     this.isLcc,
//     this.isRefundable,
//     this.isPanRequiredAtBook,
//     this.isPanRequiredAtTicket,
//     this.isPassportRequiredAtBook,
//     this.isPassportRequiredAtTicket,
//     this.gstAllowed,
//     this.isCouponAppilcable,
//     this.isGstMandatory,
//     this.airlineRemark,
//     this.resultFareType,
//     this.fare,
//     this.fareBreakdown,
//     this.segments,
//     this.lastTicketDate,
//     this.ticketAdvisory,
//     this.fareRules,
//     this.airlineCode,
//     this.miniFareRules,
//     this.validatingAirline,
//     this.fareClassification,
//     this.isUpsellAllowed,
//     this.penaltyCharges,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     isHoldAllowedWithSsr: json["IsHoldAllowedWithSSR"],
//     resultIndex: json["ResultIndex"],
//     source: json["Source"],
//     isLcc: json["IsLCC"],
//     isRefundable: json["IsRefundable"],
//     isPanRequiredAtBook: json["IsPanRequiredAtBook"],
//     isPanRequiredAtTicket: json["IsPanRequiredAtTicket"],
//     isPassportRequiredAtBook: json["IsPassportRequiredAtBook"],
//     isPassportRequiredAtTicket: json["IsPassportRequiredAtTicket"],
//     gstAllowed: json["GSTAllowed"],
//     isCouponAppilcable: json["IsCouponAppilcable"],
//     isGstMandatory: json["IsGSTMandatory"],
//     airlineRemark: json["AirlineRemark"],
//     resultFareType: json["ResultFareType"] != null ? resultFareTypeValues.map[json["ResultFareType"]] : null,
//     fare: json["Fare"] != null ? Fare.fromJson(json["Fare"]) : null,
//     fareBreakdown: json["FareBreakdown"] != null ? List<FareBreakdown>.from(json["FareBreakdown"].map((x) => FareBreakdown.fromJson(x))) : null,
//     segments: json["Segments"] != null ? List<List<Segment>>.from(json["Segments"].map((x) => List<Segment>.from(x.map((x) => Segment.fromJson(x))))) : null,
//     lastTicketDate: json["LastTicketDate"] != null ? lastTicketDateValues.map[json["LastTicketDate"]] : null,
//     ticketAdvisory: json["TicketAdvisory"],
//     fareRules: json["FareRules"] != null ? List<FareRule>.from(json["FareRules"].map((x) => FareRule.fromJson(x))) : null,
//     airlineCode: json["AirlineCode"] != null ? airlineCodeValues.map[json["AirlineCode"]] : null,
//     miniFareRules: json["MiniFareRules"] != null ? List<List<MiniFareRule>>.from(json["MiniFareRules"].map((x) => List<MiniFareRule>.from(x.map((x) => MiniFareRule.fromJson(x))))) : null,
//     validatingAirline: json["ValidatingAirline"] != null ? airlineCodeValues.map[json["ValidatingAirline"]] : null,
//     fareClassification: json["FareClassification"] != null ? ResultFareClassification.fromJson(json["FareClassification"]) : null,
//     isUpsellAllowed: json["IsUpsellAllowed"],
//     penaltyCharges: json["PenaltyCharges"] != null ? PenaltyCharges.fromJson(json["PenaltyCharges"]) : null,
//   );
//
//
//   Map<String, dynamic> toJson() => {
//     "IsHoldAllowedWithSSR": isHoldAllowedWithSsr,
//     "ResultIndex": resultIndex,
//     "Source": source,
//     "IsLCC": isLcc,
//     "IsRefundable": isRefundable,
//     "IsPanRequiredAtBook": isPanRequiredAtBook,
//     "IsPanRequiredAtTicket": isPanRequiredAtTicket,
//     "IsPassportRequiredAtBook": isPassportRequiredAtBook,
//     "IsPassportRequiredAtTicket": isPassportRequiredAtTicket,
//     "GSTAllowed": gstAllowed,
//     "IsCouponAppilcable": isCouponAppilcable,
//     "IsGSTMandatory": isGstMandatory,
//     "AirlineRemark": airlineRemark,
//     "ResultFareType": resultFareTypeValues.reverse[resultFareType],
//     "Fare": fare!.toJson(),
//     "FareBreakdown": List<dynamic>.from(fareBreakdown!.map((x) => x.toJson())),
//     "Segments": List<dynamic>.from(segments!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
//     "LastTicketDate": lastTicketDateValues.reverse[lastTicketDate],
//     "TicketAdvisory": ticketAdvisory,
//     "FareRules": List<dynamic>.from(fareRules!.map((x) => x.toJson())),
//     "AirlineCode": airlineCodeValues.reverse[airlineCode],
//     "MiniFareRules": List<dynamic>.from(miniFareRules!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
//     "ValidatingAirline": airlineCodeValues.reverse[validatingAirline],
//     "FareClassification": fareClassification!.toJson(),
//     "IsUpsellAllowed": isUpsellAllowed,
//     "PenaltyCharges": penaltyCharges!.toJson(),
//   };
// }
//
// enum AirlineCode { SG, I5, THE_6_E, UK, G8 }
//
// final airlineCodeValues = EnumValues({
//   "G8": AirlineCode.G8,
//   "I5": AirlineCode.I5,
//   "SG": AirlineCode.SG,
//   "6E": AirlineCode.THE_6_E,
//   "UK": AirlineCode.UK
// });
//
// class Fare {
//   Currency ? currency;
//   dynamic baseFare;
//   dynamic tax;
//   List<ChargeBu> ? taxBreakup;
//   dynamic yqTax;
//   dynamic additionalTxnFeeOfrd;
//   dynamic additionalTxnFeePub;
//   dynamic pgCharge;
//   dynamic otherCharges;
//   List<ChargeBu> ? chargeBu;
//   dynamic discount;
//   dynamic publishedFare;
//   dynamic commissionEarned;
//   dynamic plbEarned;
//   dynamic incentiveEarned;
//   dynamic offeredFare;
//   dynamic tdsOnCommission;
//   dynamic tdsOnPlb;
//   dynamic tdsOnIncentive;
//   dynamic serviceFee;
//   dynamic totalBaggageCharges;
//   dynamic totalMealCharges;
//   dynamic totalSeatCharges;
//   dynamic totalSpecialServiceCharges;
//   dynamic transactionFee;
//
//   Fare({
//     this.currency,
//     this.baseFare,
//     this.tax,
//     this.taxBreakup,
//     this.yqTax,
//     this.additionalTxnFeeOfrd,
//     this.additionalTxnFeePub,
//     this.pgCharge,
//     this.otherCharges,
//     this.chargeBu,
//     this.discount,
//     this.publishedFare,
//     this.commissionEarned,
//     this.plbEarned,
//     this.incentiveEarned,
//     this.offeredFare,
//     this.tdsOnCommission,
//     this.tdsOnPlb,
//     this.tdsOnIncentive,
//     this.serviceFee,
//     this.totalBaggageCharges,
//     this.totalMealCharges,
//     this.totalSeatCharges,
//     this.totalSpecialServiceCharges,
//     this.transactionFee,
//   });
//
//   factory Fare.fromJson(Map<String, dynamic> json) => Fare(
//     currency: currencyValues.map[json["Currency"]],
//     baseFare: json["BaseFare"],
//     tax: json["Tax"],
//     taxBreakup: List<ChargeBu>.from(json["TaxBreakup"].map((x) => ChargeBu.fromJson(x))),
//     yqTax: json["YQTax"],
//     additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
//     additionalTxnFeePub: json["AdditionalTxnFeePub"],
//     pgCharge: json["PGCharge"],
//     otherCharges: json["OtherCharges"] != null ? json["OtherCharges"].toDouble() : null,
//     chargeBu: List<ChargeBu>.from(json["ChargeBU"].map((x) => ChargeBu.fromJson(x))),
//     discount: json["Discount"],
//     publishedFare: json["PublishedFare"] != null ? json["PublishedFare"].toDouble() : null,
//     commissionEarned: json["CommissionEarned"] != null ? json["CommissionEarned"].toDouble() : null,
//     plbEarned: json["PLBEarned"] != null ? json["PLBEarned"].toDouble() : null,
//     incentiveEarned: json["IncentiveEarned"] != null ? json["IncentiveEarned"].toDouble() : null,
//     offeredFare: json["OfferedFare"] != null ? json["OfferedFare"].toDouble() : null,
//     tdsOnCommission: json["TdsOnCommission"] != null ? json["TdsOnCommission"].toDouble() : null,
//     tdsOnPlb: json["TdsOnPLB"] != null ? json["TdsOnPLB"].toDouble() : null,
//     tdsOnIncentive: json["TdsOnIncentive"] != null ? json["TdsOnIncentive"].toDouble() : null,
//     serviceFee: json["ServiceFee"],
//     totalBaggageCharges: json["TotalBaggageCharges"],
//     totalMealCharges: json["TotalMealCharges"],
//     totalSeatCharges: json["TotalSeatCharges"],
//     totalSpecialServiceCharges: json["TotalSpecialServiceCharges"],
//     transactionFee: json["TransactionFee"] != null ? json["TransactionFee"].toDouble() : null,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Currency": currencyValues.reverse[currency],
//     "BaseFare": baseFare,
//     "Tax": tax,
//     "TaxBreakup": List<dynamic>.from(taxBreakup!.map((x) => x.toJson())),
//     "YQTax": yqTax,
//     "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
//     "AdditionalTxnFeePub": additionalTxnFeePub,
//     "PGCharge": pgCharge,
//     "OtherCharges": otherCharges,
//     "ChargeBU": List<dynamic>.from(chargeBu!.map((x) => x.toJson())),
//     "Discount": discount,
//     "PublishedFare": publishedFare,
//     "CommissionEarned": commissionEarned,
//     "PLBEarned": plbEarned,
//     "IncentiveEarned": incentiveEarned,
//     "OfferedFare": offeredFare,
//     "TdsOnCommission": tdsOnCommission,
//     "TdsOnPLB": tdsOnPlb,
//     "TdsOnIncentive": tdsOnIncentive,
//     "ServiceFee": serviceFee,
//     "TotalBaggageCharges": totalBaggageCharges,
//     "TotalMealCharges": totalMealCharges,
//     "TotalSeatCharges": totalSeatCharges,
//     "TotalSpecialServiceCharges": totalSpecialServiceCharges,
//     "TransactionFee": transactionFee,
//   };
// }
//
// class ChargeBu {
//   Key ? key;
//   dynamic value;
//
//   ChargeBu({
//     this.key,
//     this.value,
//   });
//
//   factory ChargeBu.fromJson(Map<String, dynamic> json) => ChargeBu(
//     key: keyValues.map[json["key"]],
//     value: json["value"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "key": keyValues.reverse[key],
//     "value": value,
//   };
// }
//
// enum Key { TBOMARKUP, GLOBALPROCUREMENTCHARGE, CONVENIENCECHARGE, OTHERCHARGE, K3, YQ_TAX, YR, PSF, UDF, IN_TAX, TRANSACTION_FEE, OTHER_TAXES }
//
// final keyValues = EnumValues({
//   "CONVENIENCECHARGE": Key.CONVENIENCECHARGE,
//   "GLOBALPROCUREMENTCHARGE": Key.GLOBALPROCUREMENTCHARGE,
//   "INTax": Key.IN_TAX,
//   "K3": Key.K3,
//   "OTHERCHARGE": Key.OTHERCHARGE,
//   "OtherTaxes": Key.OTHER_TAXES,
//   "PSF": Key.PSF,
//   "TBOMARKUP": Key.TBOMARKUP,
//   "TransactionFee": Key.TRANSACTION_FEE,
//   "UDF": Key.UDF,
//   "YQTax": Key.YQ_TAX,
//   "YR": Key.YR
// });
//
// enum Currency { INR }
//
// final currencyValues = EnumValues({
//   "INR": Currency.INR
// });
//
// class FareBreakdown {
//   Currency ? currency;
//   dynamic passengerType;
//   dynamic passengerCount;
//   dynamic baseFare;
//   dynamic tax;
//   List<ChargeBu> ? taxBreakUp;
//   dynamic yqTax;
//   dynamic additionalTxnFeeOfrd;
//   dynamic additionalTxnFeePub;
//   dynamic pgCharge;
//   dynamic supplierReissueCharges;
//
//   FareBreakdown({
//     this.currency,
//     this.passengerType,
//     this.passengerCount,
//     this.baseFare,
//     this.tax,
//     this.taxBreakUp,
//     this.yqTax,
//     this.additionalTxnFeeOfrd,
//     this.additionalTxnFeePub,
//     this.pgCharge,
//     this.supplierReissueCharges,
//   });
//
//   factory FareBreakdown.fromJson(Map<String, dynamic> json) => FareBreakdown(
//     currency: currencyValues.map[json["Currency"]],
//     passengerType: json["PassengerType"],
//     passengerCount: json["PassengerCount"],
//     baseFare: json["BaseFare"],
//     tax: json["Tax"],
//     taxBreakUp: json["TaxBreakUp"] != null ? List<ChargeBu>.from(json["TaxBreakUp"].map((x) => ChargeBu.fromJson(x))) : null,
//     yqTax: json["YQTax"],
//     additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
//     additionalTxnFeePub: json["AdditionalTxnFeePub"],
//     pgCharge: json["PGCharge"],
//     supplierReissueCharges: json["SupplierReissueCharges"],
//   );
//
//
//   Map<String, dynamic> toJson() => {
//     "Currency": currencyValues.reverse[currency],
//     "PassengerType": passengerType,
//     "PassengerCount": passengerCount,
//     "BaseFare": baseFare,
//     "Tax": tax,
//     "TaxBreakUp": List<dynamic>.from(taxBreakUp!.map((x) => x.toJson())),
//     "YQTax": yqTax,
//     "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
//     "AdditionalTxnFeePub": additionalTxnFeePub,
//     "PGCharge": pgCharge,
//     "SupplierReissueCharges": supplierReissueCharges,
//   };
// }
//
// class ResultFareClassification {
//   Color ? color;
//   PurpleType ? type;
//
//   ResultFareClassification({
//     this.color,
//     this.type,
//   });
//
//   factory ResultFareClassification.fromJson(Map<String, dynamic> json) => ResultFareClassification(
//     color: colorValues.map[json["Color"]],
//     type: purpleTypeValues.map[json["Type"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Color": colorValues.reverse[color],
//     "Type": purpleTypeValues.reverse[type],
//   };
// }
//
// enum Color { YELLOW, LIGHT_BLUE, ORANGE, BROWN }
//
// final colorValues = EnumValues({
//   "Brown": Color.BROWN,
//   "lightBlue": Color.LIGHT_BLUE,
//   "Orange": Color.ORANGE,
//   "Yellow": Color.YELLOW
// });
//
// enum PurpleType { TACTICAL, PUBLISH, SME, INSTANT_PUR }
//
// final purpleTypeValues = EnumValues({
//   "InstantPur": PurpleType.INSTANT_PUR,
//   "Publish": PurpleType.PUBLISH,
//   "SME": PurpleType.SME,
//   "Tactical": PurpleType.TACTICAL
// });
//
// class FareRule {
//   DestinationEnum ? origin;
//   DestinationEnum ? destination;
//   AirlineCode ? airline;
//   dynamic fareBasisCode;
//   dynamic fareRuleDetail;
//   FareRestriction ? fareRestriction;
//   dynamic fareFamilyCode;
//   dynamic fareRuleIndex;
//
//   FareRule({
//     this.origin,
//     this.destination,
//     this.airline,
//     this.fareBasisCode,
//     this.fareRuleDetail,
//     this.fareRestriction,
//     this.fareFamilyCode,
//     this.fareRuleIndex,
//   });
//
//   factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
//     origin: destinationEnumValues.map[json["Origin"]],
//     destination: destinationEnumValues.map[json["Destination"]],
//     airline: airlineCodeValues.map[json["Airline"]],
//     fareBasisCode: json["FareBasisCode"],
//     fareRuleDetail: json["FareRuleDetail"],
//     fareRestriction: fareRestrictionValues.map[json["FareRestriction"]],
//     fareFamilyCode: json["FareFamilyCode"],
//     fareRuleIndex: json["FareRuleIndex"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Origin": destinationEnumValues.reverse[origin],
//     "Destination": destinationEnumValues.reverse[destination],
//     "Airline": airlineCodeValues.reverse[airline],
//     "FareBasisCode": fareBasisCode,
//     "FareRuleDetail": fareRuleDetail,
//     "FareRestriction": fareRestrictionValues.reverse[fareRestriction],
//     "FareFamilyCode": fareFamilyCode,
//     "FareRuleIndex": fareRuleIndex,
//   };
// }
//
// enum FareRestriction { EMPTY, Y }
//
// final fareRestrictionValues = EnumValues({
//   "": FareRestriction.EMPTY,
//   "Y": FareRestriction.Y
// });
//
// enum LastTicketDate { THE_23_MAY23 }
//
// final lastTicketDateValues = EnumValues({
//   "23MAY23": LastTicketDate.THE_23_MAY23
// });
//
// class MiniFareRule {
//   JourneyPoints ? journeyPoints;
//   MiniFareRuleType ? type;
//   dynamic from;
//   dynamic to;
//   Unit ? unit;
//   ReissueCharge ? details;
//
//   MiniFareRule({
//     this.journeyPoints,
//     this.type,
//     this.from,
//     this.to,
//     this.unit,
//     this.details,
//   });
//
//   factory MiniFareRule.fromJson(Map<String, dynamic> json) => MiniFareRule(
//     journeyPoints: journeyPointsValues.map[json["JourneyPoints"]],
//     type: miniFareRuleTypeValues.map[json["Type"]],
//     from: json["From"],
//     to: json["To"],
//     unit: unitValues.map[json["Unit"]],
//     details: reissueChargeValues.map[json["Details"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "JourneyPoints": journeyPointsValues.reverse[journeyPoints],
//     "Type": miniFareRuleTypeValues.reverse[type],
//     "From": from,
//     "To": to,
//     "Unit": unitValues.reverse[unit],
//     "Details": reissueChargeValues.reverse[details],
//   };
// }
//
// enum ReissueCharge { INR_3350, INR_2850, INR_3600, INR_3100, NIL, INR_99, THE_100, INR_3250, INR_2750, INR_3500, INR_3000, INR_500, INR_9000, NOT_AVAILABLE, INR_12250, INR_6500, INR_2500 }
//
// final reissueChargeValues = EnumValues({
//   "INR 12250": ReissueCharge.INR_12250,
//   "INR 2500": ReissueCharge.INR_2500,
//   "INR 2750": ReissueCharge.INR_2750,
//   "INR 2850": ReissueCharge.INR_2850,
//   "INR 3000": ReissueCharge.INR_3000,
//   "INR 3100": ReissueCharge.INR_3100,
//   "INR 3250": ReissueCharge.INR_3250,
//   "INR 3350": ReissueCharge.INR_3350,
//   "INR 3500": ReissueCharge.INR_3500,
//   "INR 3600": ReissueCharge.INR_3600,
//   "INR 500": ReissueCharge.INR_500,
//   "INR 6500": ReissueCharge.INR_6500,
//   "INR 9000": ReissueCharge.INR_9000,
//   "INR 99": ReissueCharge.INR_99,
//   "Nil": ReissueCharge.NIL,
//   "NOT AVAILABLE": ReissueCharge.NOT_AVAILABLE,
//   "100%": ReissueCharge.THE_100
// });
//
// enum JourneyPoints { DEL_BOM, DEL_BLR_BOM, DEL_GOI_BOM, DEL_AMD_BOM, DEL_HYD_BOM }
//
// final journeyPointsValues = EnumValues({
//   "DEL-AMD-BOM": JourneyPoints.DEL_AMD_BOM,
//   "DEL-BLR-BOM": JourneyPoints.DEL_BLR_BOM,
//   "DEL-BOM": JourneyPoints.DEL_BOM,
//   "DEL-GOI-BOM": JourneyPoints.DEL_GOI_BOM,
//   "DEL-HYD-BOM": JourneyPoints.DEL_HYD_BOM
// });
//
// enum MiniFareRuleType { REISSUE, CANCELLATION }
//
// final miniFareRuleTypeValues = EnumValues({
//   "Cancellation": MiniFareRuleType.CANCELLATION,
//   "Reissue": MiniFareRuleType.REISSUE
// });
//
// enum Unit { DAYS, EMPTY, HOURS }
//
// final unitValues = EnumValues({
//   "Days": Unit.DAYS,
//   "": Unit.EMPTY,
//   "Hours": Unit.HOURS
// });
//
// class PenaltyCharges {
//   ReissueCharge ? reissueCharge;
//
//   PenaltyCharges({
//     this.reissueCharge,
//   });
//
//   factory PenaltyCharges.fromJson(Map<String, dynamic> json) => PenaltyCharges(
//     reissueCharge: reissueChargeValues.map[json["ReissueCharge"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ReissueCharge": reissueChargeValues.reverse[reissueCharge],
//   };
// }
//
// enum ResultFareType { REGULAR_FARE }
//
// final resultFareTypeValues = EnumValues({
//   "RegularFare": ResultFareType.REGULAR_FARE
// });
//
// class Segment {
//   Baggage ? baggage;
//   CabinBaggage ? cabinBaggage;
//   dynamic cabinClass;
//   dynamic tripIndicator;
//   dynamic segmentIndicator;
//   Airline ? airline;
//   dynamic noOfSeatAvailable;
//   Origin ? origin;
//   Destination ? destination;
//   dynamic duration;
//   dynamic groundTime;
//   dynamic mile;
//   bool ? stopOver;
//   dynamic flightInfoIndex;
//   dynamic stopPoint;
//   dynamic stopPointArrivalTime;
//   dynamic stopPointDepartureTime;
//   dynamic craft;
//   dynamic remark;
//   bool ? isETicketEligible;
//   FlightStatus ? flightStatus;
//   dynamic status;
//   SegmentFareClassification ? fareClassification;
//   dynamic accumulatedDuration;
//
//   Segment({
//     this.baggage,
//     this.cabinBaggage,
//     this.cabinClass,
//     this.tripIndicator,
//     this.segmentIndicator,
//     this.airline,
//     this.noOfSeatAvailable,
//     this.origin,
//     this.destination,
//     this.duration,
//     this.groundTime,
//     this.mile,
//     this.stopOver,
//     this.flightInfoIndex,
//     this.stopPoint,
//     this.stopPointArrivalTime,
//     this.stopPointDepartureTime,
//     this.craft,
//     this.remark,
//     this.isETicketEligible,
//     this.flightStatus,
//     this.status,
//     this.fareClassification,
//     this.accumulatedDuration,
//   });
//
//   factory Segment.fromJson(Map<String, dynamic> json) {
//     return Segment(
//       baggage: json["Baggage"] != null ? baggageValues.map[json["Baggage"]] : null,
//       cabinBaggage: json["CabinBaggage"] != null ? cabinBaggageValues.map[json["CabinBaggage"]] : null,
//       cabinClass: json["CabinClass"],
//       tripIndicator: json["TripIndicator"],
//       segmentIndicator: json["SegmentIndicator"],
//       airline: json["Airline"] != null ? Airline.fromJson(json["Airline"]) : null,
//       noOfSeatAvailable: json["NoOfSeatAvailable"],
//       origin: json["Origin"] != null ? Origin.fromJson(json["Origin"]) : null,
//       destination: json["Destination"] != null ? Destination.fromJson(json["Destination"]) : null,
//       duration: json["Duration"],
//       groundTime: json["GroundTime"],
//       mile: json["Mile"],
//       stopOver: json["StopOver"],
//       flightInfoIndex: json["FlightInfoIndex"],
//       stopPoint: json["StopPoint"],
//       stopPointArrivalTime: json["StopPointArrivalTime"] != null ? DateTime.parse(json["StopPointArrivalTime"]) : null,
//       stopPointDepartureTime: json["StopPointDepartureTime"] != null ? DateTime.parse(json["StopPointDepartureTime"]) : null,
//       craft: json["Craft"],
//       remark: json["Remark"],
//       isETicketEligible: json["IsETicketEligible"],
//       flightStatus: json["FlightStatus"] != null ? flightStatusValues.map[json["FlightStatus"]] : null,
//       status: json["Status"],
//       fareClassification: json["FareClassification"] != null ? SegmentFareClassification.fromJson(json["FareClassification"]) : null,
//       accumulatedDuration: json["AccumulatedDuration"],
//     );
//   }
//
//
//   Map<String, dynamic> toJson() => {
//     "Baggage": baggageValues.reverse[baggage],
//     "CabinBaggage": cabinBaggageValues.reverse[cabinBaggage],
//     "CabinClass": cabinClass,
//     "TripIndicator": tripIndicator,
//     "SegmentIndicator": segmentIndicator,
//     "Airline": airline!.toJson(),
//     "NoOfSeatAvailable": noOfSeatAvailable,
//     "Origin": origin!.toJson(),
//     "Destination": destination!.toJson(),
//     "Duration": duration,
//     "GroundTime": groundTime,
//     "Mile": mile,
//     "StopOver": stopOver,
//     "FlightInfoIndex": flightInfoIndex,
//     "StopPoint": stopPoint,
//     "StopPointArrivalTime": stopPointArrivalTime?.toIso8601String(),
//     "StopPointDepartureTime": stopPointDepartureTime?.toIso8601String(),
//     "Craft": craft,
//     "Remark": remark,
//     "IsETicketEligible": isETicketEligible,
//     "FlightStatus": flightStatusValues.reverse[flightStatus],
//     "Status": status,
//     "FareClassification": fareClassification!.toJson(),
//     "AccumulatedDuration": accumulatedDuration,
//   };
// }
//
// class Airline {
//   AirlineCode ? airlineCode;
//   AirlineName ? airlineName;
//   String ? flightNumber;
//   String ? fareClass;
//   OperatingCarrier ? operatingCarrier;
//
//   Airline({
//     this.airlineCode,
//     this.airlineName,
//     this.flightNumber,
//     this.fareClass,
//     this.operatingCarrier,
//   });
//
//   factory Airline.fromJson(Map<String, dynamic> json) => Airline(
//     airlineCode: airlineCodeValues.map[json["AirlineCode"]],
//     airlineName: airlineNameValues.map[json["AirlineName"]],
//     flightNumber: json["FlightNumber"],
//     fareClass: json["FareClass"],
//     operatingCarrier: operatingCarrierValues.map[json["OperatingCarrier"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "AirlineCode": airlineCodeValues.reverse[airlineCode],
//     "AirlineName": airlineNameValues.reverse[airlineName],
//     "FlightNumber": flightNumber,
//     "FareClass": fareClass,
//     "OperatingCarrier": operatingCarrierValues.reverse[operatingCarrier],
//   };
// }
//
// enum AirlineName { SPICE_JET, AIR_ASIA, INDIGO, VISTARA, GO_FIRST }
//
// final airlineNameValues = EnumValues({
//   "Air Asia": AirlineName.AIR_ASIA,
//   "GO FIRST": AirlineName.GO_FIRST,
//   "Indigo": AirlineName.INDIGO,
//   "SpiceJet": AirlineName.SPICE_JET,
//   "Vistara": AirlineName.VISTARA
// });
//
// enum OperatingCarrier { EMPTY, UK }
//
// final operatingCarrierValues = EnumValues({
//   "": OperatingCarrier.EMPTY,
//   "UK": OperatingCarrier.UK
// });
//
// enum Baggage { THE_15_KG, BAGGAGE_15_KG, THE_25_KG, THE_20_KG, THE_55_KG }
//
// final baggageValues = EnumValues({
//   "15 Kg": Baggage.BAGGAGE_15_KG,
//   "15 KG": Baggage.THE_15_KG,
//   "20 KG": Baggage.THE_20_KG,
//   "25 KG": Baggage.THE_25_KG,
//   "55 KG": Baggage.THE_55_KG
// });
//
// enum CabinBaggage { THE_7_KG, CABIN_BAGGAGE_7_KG, PURPLE_7_KG, THE_15_KG }
//
// final cabinBaggageValues = EnumValues({
//   "7 Kg": CabinBaggage.CABIN_BAGGAGE_7_KG,
//   " 7 KG": CabinBaggage.PURPLE_7_KG,
//   "15 KG": CabinBaggage.THE_15_KG,
//   "7 KG": CabinBaggage.THE_7_KG
// });
//
// class Destination {
//   Airport ? airport;
//   DateTime ? arrTime;
//
//   Destination({
//     this.airport,
//     this.arrTime,
//   });
//
//   factory Destination.fromJson(Map<String, dynamic> json) => Destination(
//     airport: Airport.fromJson(json["Airport"]),
//     arrTime: DateTime.parse(json["ArrTime"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Airport": airport!.toJson(),
//     "ArrTime": arrTime!.toIso8601String(),
//   };
// }
//
// class Airport {
//   DestinationEnum ? airportCode;
//   AirportName ? airportName;
//   String ? terminal;
//   DestinationEnum ? cityCode;
//   CityName ? cityName;
//   CountryCode ? countryCode;
//   CountryName ? countryName;
//
//   Airport({
//     this.airportCode,
//     this.airportName,
//     this.terminal,
//     this.cityCode,
//     this.cityName,
//     this.countryCode,
//     this.countryName,
//   });
//
//   factory Airport.fromJson(Map<String, dynamic> json) => Airport(
//     airportCode: destinationEnumValues.map[json["AirportCode"]],
//     airportName: airportNameValues.map[json["AirportName"]],
//     terminal: json["Terminal"],
//     cityCode: destinationEnumValues.map[json["CityCode"]],
//     cityName: cityNameValues.map[json["CityName"]],
//     countryCode: countryCodeValues.map[json["CountryCode"]],
//     countryName: countryNameValues.map[json["CountryName"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "AirportCode": destinationEnumValues.reverse[airportCode],
//     "AirportName": airportNameValues.reverse[airportName],
//     "Terminal": terminal,
//     "CityCode": destinationEnumValues.reverse[cityCode],
//     "CityName": cityNameValues.reverse[cityName],
//     "CountryCode": countryCodeValues.reverse[countryCode],
//     "CountryName": countryNameValues.reverse[countryName],
//   };
// }
//
// enum AirportName { MUMBAI, BENGALURU_INTL, DABOLIM, AHMEDABAD, SHAMSABAD_INTERNATIONAL_AIRPORT, INDIRA_GANDHI_AIRPORT }
//
// final airportNameValues = EnumValues({
//   "Ahmedabad": AirportName.AHMEDABAD,
//   "Bengaluru Intl": AirportName.BENGALURU_INTL,
//   "Dabolim": AirportName.DABOLIM,
//   "Indira Gandhi Airport": AirportName.INDIRA_GANDHI_AIRPORT,
//   "Mumbai": AirportName.MUMBAI,
//   "Shamsabad International Airport": AirportName.SHAMSABAD_INTERNATIONAL_AIRPORT
// });
//
// enum CityName { MUMBAI, BANGALORE, GOA, AHMEDABAD, HYDERABAD, DELHI }
//
// final cityNameValues = EnumValues({
//   "Ahmedabad": CityName.AHMEDABAD,
//   "Bangalore": CityName.BANGALORE,
//   "Delhi": CityName.DELHI,
//   "Goa": CityName.GOA,
//   "Hyderabad": CityName.HYDERABAD,
//   "Mumbai": CityName.MUMBAI
// });
//
// enum CountryCode { IN }
//
// final countryCodeValues = EnumValues({
//   "IN": CountryCode.IN
// });
//
// enum CountryName { INDIA }
//
// final countryNameValues = EnumValues({
//   "India": CountryName.INDIA
// });
//
// class SegmentFareClassification {
//   FluffyType ? type;
//
//   SegmentFareClassification({
//     this.type,
//   });
//
//   factory SegmentFareClassification.fromJson(Map<String, dynamic> json) => SegmentFareClassification(
//     type: fluffyTypeValues.map[json["Type"]]!,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Type": fluffyTypeValues.reverse[type],
//   };
// }
//
// enum FluffyType { TACTICAL, EMPTY, SME }
//
// final fluffyTypeValues = EnumValues({
//   "": FluffyType.EMPTY,
//   "SME": FluffyType.SME,
//   "Tactical": FluffyType.TACTICAL
// });
//
// enum FlightStatus { CONFIRMED }
//
// final flightStatusValues = EnumValues({
//   "Confirmed": FlightStatus.CONFIRMED
// });
//
// class Origin {
//   Airport airport;
//   DateTime depTime;
//
//   Origin({
//     required this.airport,
//     required this.depTime,
//   });
//
//   factory Origin.fromJson(Map<String, dynamic> json) => Origin(
//     airport: Airport.fromJson(json["Airport"]),
//     depTime: DateTime.parse(json["DepTime"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Airport": airport.toJson(),
//     "DepTime": depTime.toIso8601String(),
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
