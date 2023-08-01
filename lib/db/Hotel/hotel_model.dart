// To parse this JSON data, do
//
//     final hotelSearch = hotelSearchFromJson(jsonString);

import 'dart:convert';

HotelSearch hotelSearchFromJson(String str) =>
    HotelSearch.fromJson(json.decode(str));

String hotelSearchToJson(HotelSearch data) => json.encode(data.toJson());

class HotelSearch {
  HotelSearch({
    this.hotelSearchResult,
    this.token,
  });

  HotelSearchResult? hotelSearchResult;
  dynamic token;

  factory HotelSearch.fromJson(Map<String, dynamic> json) => HotelSearch(
        hotelSearchResult:
            HotelSearchResult.fromJson(json["HotelSearchResult"]),
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "HotelSearchResult": hotelSearchResult!.toJson(),
        "Token": token,
      };
}

class HotelSearchResult {
  HotelSearchResult({
    this.responseStatus,
    this.error,
    this.traceId,
    this.cityId,
    this.remarks,
    this.checkInDate,
    this.checkOutDate,
    this.preferredCurrency,
    this.noOfRooms,
    required this.roomGuests,
    required this.hotelResults,
  });

  int? responseStatus;
  Error? error;
  String? traceId;
  String? cityId;
  String? remarks;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  String? preferredCurrency;
  int? noOfRooms;
  List<RoomGuest> roomGuests;
  List<HotelResult> hotelResults;

  factory HotelSearchResult.fromJson(Map<String, dynamic> json) =>
      HotelSearchResult(
        responseStatus: json["ResponseStatus"],
        error: Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        cityId: json["CityId"],
        remarks: json["Remarks"],
        checkInDate: DateTime.parse(json["CheckInDate"]),
        checkOutDate: DateTime.parse(json["CheckOutDate"]),
        preferredCurrency: json["PreferredCurrency"],
        noOfRooms: json["NoOfRooms"],
        roomGuests: List<RoomGuest>.from(
            json["RoomGuests"].map((x) => RoomGuest.fromJson(x))),
        hotelResults: List<HotelResult>.from(
            json["HotelResults"].map((x) => HotelResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseStatus": responseStatus,
        "Error": error!.toJson(),
        "TraceId": traceId,
        "CityId": cityId,
        "Remarks": remarks,
        "CheckInDate":
            "${checkInDate!.year.toString().padLeft(4, '0')}-${checkInDate!.month.toString().padLeft(2, '0')}-${checkInDate!.day.toString().padLeft(2, '0')}",
        "CheckOutDate":
            "${checkOutDate!.year.toString().padLeft(4, '0')}-${checkOutDate!.month.toString().padLeft(2, '0')}-${checkOutDate!.day.toString().padLeft(2, '0')}",
        "PreferredCurrency": preferredCurrency,
        "NoOfRooms": noOfRooms,
        "RoomGuests": List<dynamic>.from(roomGuests.map((x) => x.toJson())),
        "HotelResults": List<dynamic>.from(hotelResults.map((x) => x.toJson())),
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

class HotelResult {
  HotelResult({
    this.isHotDeal,
    this.resultIndex,
    this.hotelCode,
    this.hotelName,
    this.hotelCategory,
    this.starRating,
    this.hotelDescription,
    this.hotelPromotion,
    this.hotelPolicy,
    this.isTboMapped,
    this.price,
    this.supplierHotelCodes,
    this.hotelPicture,
    this.hotelAddress,
    this.hotelContactNo,
    this.hotelMap,
    this.latitude,
    this.longitude,
    this.hotelLocation,
    this.supplierPrice,
    this.roomDetails,
    this.hotelInfo,
  });

  bool? isHotDeal;
  int? resultIndex;
  String? hotelCode;
  String? hotelName;
  String? hotelCategory;
  int? starRating;
  String? hotelDescription;
  String? hotelPromotion;
  String? hotelPolicy;
  bool? isTboMapped;
  Price? price;
  List<SupplierHotelCode>? supplierHotelCodes;
  String? hotelPicture;
  String? hotelAddress;
  String? hotelContactNo;
  dynamic hotelMap;
  String? latitude;
  String? longitude;
  dynamic hotelLocation;
  dynamic supplierPrice;
  List<dynamic>? roomDetails;
  dynamic hotelInfo;

  factory HotelResult.fromJson(Map<String, dynamic> json) => HotelResult(
        isHotDeal: json["IsHotDeal"],
        resultIndex: json["ResultIndex"],
        hotelCode: json["HotelCode"],
        hotelName: json["HotelName"],
        hotelCategory: json["HotelCategory"],
        starRating: json["StarRating"],
        hotelDescription: json["HotelDescription"],
        hotelPromotion: json["HotelPromotion"],
        hotelPolicy: json["HotelPolicy"],
        isTboMapped: json["IsTBOMapped"],
        price: Price.fromJson(json["Price"]),
        supplierHotelCodes: json["SupplierHotelCodes"] != null
            ? List<SupplierHotelCode>.from(json["SupplierHotelCodes"]
                .map((x) => SupplierHotelCode.fromJson(x)))
            : <SupplierHotelCode>[],
        hotelPicture: json["HotelPicture"],
        hotelAddress: json["HotelAddress"],
        hotelContactNo: json["HotelContactNo"],
        hotelMap: json["HotelMap"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        hotelLocation: json["HotelLocation"],
        supplierPrice: json["SupplierPrice"],
        roomDetails: List<dynamic>.from(json["RoomDetails"]!.map((x) => x)),
        hotelInfo: json["HotelInfo"],
      );

  Map<String, dynamic> toJson() => {
        "IsHotDeal": isHotDeal,
        "ResultIndex": resultIndex,
        "HotelCode": hotelCode,
        "HotelName": hotelName,
        "HotelCategory": hotelCategory,
        "StarRating": starRating,
        "HotelDescription": hotelDescription,
        "HotelPromotion": hotelPromotion,
        "HotelPolicy": hotelPolicy,
        "IsTBOMapped": isTboMapped,
        "Price": price!.toJson(),
        "SupplierHotelCodes":
            List<dynamic>.from(supplierHotelCodes!.map((x) => x.toJson())),
        "HotelPicture": hotelPicture,
        "HotelAddress": hotelAddress,
        "HotelContactNo": hotelContactNo,
        "HotelMap": hotelMap,
        "Latitude": latitude,
        "Longitude": longitude,
        "HotelLocation": hotelLocation,
        "SupplierPrice": supplierPrice,
        "RoomDetails": List<dynamic>.from(roomDetails!.map((x) => x)),
        "HotelInfo": hotelInfo,
      };
}

class HotelInfoClass {
  String? cityid;
  dynamic starRating;
  List<String>? images;
  dynamic hotelAddress;
  String? hotelCode;
  String? hotelName;
  dynamic longitude;
  dynamic latitude;

  HotelInfoClass({
    this.cityid,
    this.starRating,
    this.images,
    this.hotelAddress,
    this.hotelCode,
    this.hotelName,
    this.longitude,
    this.latitude,
  });

  factory HotelInfoClass.fromJson(Map<String, dynamic> json) => HotelInfoClass(
        cityid: json["cityid"],
        starRating: json["starRating"],
        images: List<String>.from(json["images"].map((x) => x)),
        hotelAddress: json["hotelAddress"],
        hotelCode: json["hotelCode"],
        hotelName: json["hotelName"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cityid": cityid,
        "starRating": starRating,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "hotelAddress": hotelAddress,
        "hotelCode": hotelCode,
        "hotelName": hotelName,
        "longitude": longitude,
        "latitude": latitude,
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
  Gst? gst;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        currencyCode: json["CurrencyCode"],
        roomPrice: json["RoomPrice"].toDouble(),
        tax: json["Tax"],
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

class SupplierHotelCode {
  SupplierHotelCode({
    this.categoryId,
    this.categoryIndex,
  });

  String? categoryId;
  int? categoryIndex;

  factory SupplierHotelCode.fromJson(Map<String, dynamic> json) =>
      SupplierHotelCode(
        categoryId: json["CategoryId"],
        categoryIndex: json["CategoryIndex"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryIndex": categoryIndex,
      };
}

class RoomGuest {
  RoomGuest({
    this.noOfAdults,
    this.noOfChild,
    this.childAge,
  });

  int? noOfAdults;
  int? noOfChild;
  List<int>? childAge;

  factory RoomGuest.fromJson(Map<String, dynamic> json) => RoomGuest(
        noOfAdults: json["NoOfAdults"],
        noOfChild: json["NoOfChild"],
        childAge: List<int>.from(json["ChildAge"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "NoOfAdults": noOfAdults,
        "NoOfChild": noOfChild,
        "ChildAge": List<dynamic>.from(childAge!.map((x) => x)),
      };
}
