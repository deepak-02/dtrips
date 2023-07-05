// To parse this JSON data, do
//
//     final bookedHotelDetails = bookedHotelDetailsFromJson(jsonString);

import 'dart:convert';

BookedHotelDetails bookedHotelDetailsFromJson(String str) =>
    BookedHotelDetails.fromJson(json.decode(str));

String bookedHotelDetailsToJson(BookedHotelDetails data) =>
    json.encode(data.toJson());

class BookedHotelDetails {
  BookedHotelDetails({
    required this.getBookingDetailResult,
  });

  GetBookingDetailResult getBookingDetailResult;

  factory BookedHotelDetails.fromJson(Map<String, dynamic> json) =>
      BookedHotelDetails(
        getBookingDetailResult:
            GetBookingDetailResult.fromJson(json["GetBookingDetailResult"]),
      );

  Map<String, dynamic> toJson() => {
        "GetBookingDetailResult": getBookingDetailResult.toJson(),
      };
}

class GetBookingDetailResult {
  GetBookingDetailResult({
    this.voucherStatus,
    this.responseStatus,
    this.error,
    this.traceId,
    this.status,
    this.hotelBookingStatus,
    this.confirmationNo,
    this.bookingRefNo,
    this.bookingId,
    this.isPriceChanged,
    this.isCancellationPolicyChanged,
    required this.hotelRoomsDetails,
    this.agentRemarks,
    this.bookingSource,
    this.creditNoteGstin,
    this.gstin,
    this.guestNationality,
    this.hotelPolicyDetail,
    this.intHotelPassportDetails,
    this.invoiceAmount,
    this.invoiceCreatedOn,
    this.invoiceNo,
    this.isCorporate,
    this.isTcsApplicableOnVoucher,
    this.hotelConfirmationNo,
    this.hotelCode,
    this.hotelId,
    this.hotelName,
    this.tboHotelCode,
    this.starRating,
    this.addressLine1,
    this.addressLine2,
    this.countryCode,
    this.latitude,
    this.longitude,
    this.city,
    this.cityId,
    this.checkInDate,
    this.initialCheckInDate,
    this.checkOutDate,
    this.initialCheckOutDate,
    this.lastCancellationDate,
    this.lastVoucherDate,
    this.noOfRooms,
    this.bookingDate,
    this.specialRequest,
    this.isDomestic,
    this.bookingAllowedForRoamer,
  });

  bool? voucherStatus;
  int? responseStatus;
  Error? error;
  String? traceId;
  int? status;
  String? hotelBookingStatus;
  String? confirmationNo;
  String? bookingRefNo;
  int? bookingId;
  bool? isPriceChanged;
  bool? isCancellationPolicyChanged;
  List<HotelRoomsDetail> hotelRoomsDetails;
  String? agentRemarks;
  String? bookingSource;
  dynamic creditNoteGstin;
  dynamic gstin;
  String? guestNationality;
  String? hotelPolicyDetail;
  dynamic intHotelPassportDetails;
  int? invoiceAmount;
  DateTime? invoiceCreatedOn;
  String? invoiceNo;
  bool? isCorporate;
  bool? isTcsApplicableOnVoucher;
  dynamic hotelConfirmationNo;
  String? hotelCode;
  int? hotelId;
  String? hotelName;
  String? tboHotelCode;
  int? starRating;
  String? addressLine1;
  String? addressLine2;
  String? countryCode;
  String? latitude;
  String? longitude;
  String? city;
  int? cityId;
  DateTime? checkInDate;
  DateTime? initialCheckInDate;
  DateTime? checkOutDate;
  DateTime? initialCheckOutDate;
  DateTime? lastCancellationDate;
  DateTime? lastVoucherDate;
  int? noOfRooms;
  DateTime? bookingDate;
  String? specialRequest;
  bool? isDomestic;
  bool? bookingAllowedForRoamer;

  factory GetBookingDetailResult.fromJson(Map<String, dynamic> json) =>
      GetBookingDetailResult(
        voucherStatus: json["VoucherStatus"],
        responseStatus: json["ResponseStatus"],
        error: Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        status: json["Status"],
        hotelBookingStatus: json["HotelBookingStatus"],
        confirmationNo: json["ConfirmationNo"],
        bookingRefNo: json["BookingRefNo"],
        bookingId: json["BookingId"],
        isPriceChanged: json["IsPriceChanged"],
        isCancellationPolicyChanged: json["IsCancellationPolicyChanged"],
        hotelRoomsDetails: List<HotelRoomsDetail>.from(
            json["HotelRoomsDetails"].map((x) => HotelRoomsDetail.fromJson(x))),
        agentRemarks: json["AgentRemarks"],
        bookingSource: json["BookingSource"],
        creditNoteGstin: json["CreditNoteGSTIN"],
        gstin: json["GSTIN"],
        guestNationality: json["GuestNationality"],
        hotelPolicyDetail: json["HotelPolicyDetail"],
        intHotelPassportDetails: json["IntHotelPassportDetails"],
        invoiceAmount: json["InvoiceAmount"],
        invoiceCreatedOn: DateTime.parse(json["InvoiceCreatedOn"]),
        invoiceNo: json["InvoiceNo"],
        isCorporate: json["IsCorporate"],
        isTcsApplicableOnVoucher: json["IsTcsApplicableOnVoucher"],
        hotelConfirmationNo: json["HotelConfirmationNo"],
        hotelCode: json["HotelCode"],
        hotelId: json["HotelId"],
        hotelName: json["HotelName"],
        tboHotelCode: json["TBOHotelCode"],
        starRating: json["StarRating"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        countryCode: json["CountryCode"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        city: json["City"],
        cityId: json["CityId"],
        checkInDate: DateTime.parse(json["CheckInDate"]),
        initialCheckInDate: DateTime.parse(json["InitialCheckInDate"]),
        checkOutDate: DateTime.parse(json["CheckOutDate"]),
        initialCheckOutDate: DateTime.parse(json["InitialCheckOutDate"]),
        lastCancellationDate: DateTime.parse(json["LastCancellationDate"]),
        lastVoucherDate: DateTime.parse(json["LastVoucherDate"]),
        noOfRooms: json["NoOfRooms"],
        bookingDate: DateTime.parse(json["BookingDate"]),
        specialRequest: json["SpecialRequest"],
        isDomestic: json["IsDomestic"],
        bookingAllowedForRoamer: json["BookingAllowedForRoamer"],
      );

  Map<String, dynamic> toJson() => {
        "VoucherStatus": voucherStatus,
        "ResponseStatus": responseStatus,
        "Error": error!.toJson(),
        "TraceId": traceId,
        "Status": status,
        "HotelBookingStatus": hotelBookingStatus,
        "ConfirmationNo": confirmationNo,
        "BookingRefNo": bookingRefNo,
        "BookingId": bookingId,
        "IsPriceChanged": isPriceChanged,
        "IsCancellationPolicyChanged": isCancellationPolicyChanged,
        "HotelRoomsDetails":
            List<dynamic>.from(hotelRoomsDetails!.map((x) => x.toJson())),
        "AgentRemarks": agentRemarks,
        "BookingSource": bookingSource,
        "CreditNoteGSTIN": creditNoteGstin,
        "GSTIN": gstin,
        "GuestNationality": guestNationality,
        "HotelPolicyDetail": hotelPolicyDetail,
        "IntHotelPassportDetails": intHotelPassportDetails,
        "InvoiceAmount": invoiceAmount,
        "InvoiceCreatedOn": invoiceCreatedOn!.toIso8601String(),
        "InvoiceNo": invoiceNo,
        "IsCorporate": isCorporate,
        "IsTcsApplicableOnVoucher": isTcsApplicableOnVoucher,
        "HotelConfirmationNo": hotelConfirmationNo,
        "HotelCode": hotelCode,
        "HotelId": hotelId,
        "HotelName": hotelName,
        "TBOHotelCode": tboHotelCode,
        "StarRating": starRating,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "CountryCode": countryCode,
        "Latitude": latitude,
        "Longitude": longitude,
        "City": city,
        "CityId": cityId,
        "CheckInDate": checkInDate!.toIso8601String(),
        "InitialCheckInDate": initialCheckInDate!.toIso8601String(),
        "CheckOutDate": checkOutDate!.toIso8601String(),
        "InitialCheckOutDate": initialCheckOutDate!.toIso8601String(),
        "LastCancellationDate": lastCancellationDate!.toIso8601String(),
        "LastVoucherDate": lastVoucherDate!.toIso8601String(),
        "NoOfRooms": noOfRooms,
        "BookingDate": bookingDate!.toIso8601String(),
        "SpecialRequest": specialRequest,
        "IsDomestic": isDomestic,
        "BookingAllowedForRoamer": bookingAllowedForRoamer,
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

class HotelRoomsDetail {
  HotelRoomsDetail({
    this.adultCount,
    this.availabilityType,
    this.childCount,
    this.hotelPassenger,
    this.requireAllPaxDetails,
    this.roomId,
    this.roomStatus,
    this.roomIndex,
    this.roomTypeCode,
    this.roomDescription,
    this.roomTypeName,
    this.ratePlanCode,
    this.ratePlan,
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
  });

  int? adultCount;
  String? availabilityType;
  int? childCount;
  List<HotelPassenger>? hotelPassenger;
  bool? requireAllPaxDetails;
  int? roomId;
  int? roomStatus;
  int? roomIndex;
  String? roomTypeCode;
  String? roomDescription;
  String? roomTypeName;
  String? ratePlanCode;
  dynamic ratePlan;
  List<DayRate>? dayRates;
  bool? isPerStay;
  dynamic supplierPrice;
  Price? price;
  String? roomPromotion;
  List<String>? amenities;
  List<String>? amenity;
  String? smokingPreference;
  List<dynamic>? bedTypes;
  dynamic hotelSupplements;
  DateTime? lastCancellationDate;
  List<CancellationPolicy>? cancellationPolicies;
  DateTime? lastVoucherDate;
  String? cancellationPolicy;
  List<String>? inclusion;

  factory HotelRoomsDetail.fromJson(Map<String, dynamic> json) =>
      HotelRoomsDetail(
        adultCount: json["AdultCount"],
        availabilityType: json["AvailabilityType"],
        childCount: json["ChildCount"],
        hotelPassenger: List<HotelPassenger>.from(
            json["HotelPassenger"].map((x) => HotelPassenger.fromJson(x))),
        requireAllPaxDetails: json["RequireAllPaxDetails"],
        roomId: json["RoomId"],
        roomStatus: json["RoomStatus"],
        roomIndex: json["RoomIndex"],
        roomTypeCode: json["RoomTypeCode"],
        roomDescription: json["RoomDescription"],
        roomTypeName: json["RoomTypeName"],
        ratePlanCode: json["RatePlanCode"],
        ratePlan: json["RatePlan"],
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
        hotelSupplements: json["HotelSupplements"],
        lastCancellationDate: DateTime.parse(json["LastCancellationDate"]),
        cancellationPolicies: List<CancellationPolicy>.from(
            json["CancellationPolicies"]
                .map((x) => CancellationPolicy.fromJson(x))),
        lastVoucherDate: DateTime.parse(json["LastVoucherDate"]),
        cancellationPolicy: json["CancellationPolicy"],
        inclusion: List<String>.from(json["Inclusion"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "AdultCount": adultCount,
        "AvailabilityType": availabilityType,
        "ChildCount": childCount,
        "HotelPassenger":
            List<dynamic>.from(hotelPassenger!.map((x) => x.toJson())),
        "RequireAllPaxDetails": requireAllPaxDetails,
        "RoomId": roomId,
        "RoomStatus": roomStatus,
        "RoomIndex": roomIndex,
        "RoomTypeCode": roomTypeCode,
        "RoomDescription": roomDescription,
        "RoomTypeName": roomTypeName,
        "RatePlanCode": ratePlanCode,
        "RatePlan": ratePlan,
        "DayRates": List<dynamic>.from(dayRates!.map((x) => x.toJson())),
        "IsPerStay": isPerStay,
        "SupplierPrice": supplierPrice,
        "Price": price!.toJson(),
        "RoomPromotion": roomPromotion,
        "Amenities": List<dynamic>.from(amenities!.map((x) => x)),
        "Amenity": List<dynamic>.from(amenity!.map((x) => x)),
        "SmokingPreference": smokingPreference,
        "BedTypes": List<dynamic>.from(bedTypes!.map((x) => x)),
        "HotelSupplements": hotelSupplements,
        "LastCancellationDate": lastCancellationDate!.toIso8601String(),
        "CancellationPolicies":
            List<dynamic>.from(cancellationPolicies!.map((x) => x.toJson())),
        "LastVoucherDate": lastVoucherDate!.toIso8601String(),
        "CancellationPolicy": cancellationPolicy,
        "Inclusion": List<dynamic>.from(inclusion!.map((x) => x)),
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

  double? amount;
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

class HotelPassenger {
  HotelPassenger({
    this.age,
    this.email,
    this.fileDocument,
    this.firstName,
    this.gstCompanyAddress,
    this.gstCompanyContactNumber,
    this.gstCompanyEmail,
    this.gstCompanyName,
    this.gstNumber,
    this.guardianDetail,
    this.lastName,
    this.leadPassenger,
    this.middleName,
    this.pan,
    this.passportExpDate,
    this.passportIssueDate,
    this.passportNo,
    this.paxId,
    this.paxType,
    this.phoneno,
    this.title,
  });

  int? age;
  String? email;
  dynamic fileDocument;
  String? firstName;
  dynamic gstCompanyAddress;
  dynamic gstCompanyContactNumber;
  dynamic gstCompanyEmail;
  dynamic gstCompanyName;
  dynamic gstNumber;
  dynamic guardianDetail;
  String? lastName;
  bool? leadPassenger;
  dynamic middleName;
  String? pan;
  dynamic passportExpDate;
  dynamic passportIssueDate;
  dynamic passportNo;
  int? paxId;
  int? paxType;
  String? phoneno;
  String? title;

  factory HotelPassenger.fromJson(Map<String, dynamic> json) => HotelPassenger(
        age: json["Age"],
        email: json["Email"],
        fileDocument: json["FileDocument"],
        firstName: json["FirstName"],
        gstCompanyAddress: json["GSTCompanyAddress"],
        gstCompanyContactNumber: json["GSTCompanyContactNumber"],
        gstCompanyEmail: json["GSTCompanyEmail"],
        gstCompanyName: json["GSTCompanyName"],
        gstNumber: json["GSTNumber"],
        guardianDetail: json["GuardianDetail"],
        lastName: json["LastName"],
        leadPassenger: json["LeadPassenger"],
        middleName: json["MiddleName"],
        pan: json["PAN"],
        passportExpDate: json["PassportExpDate"],
        passportIssueDate: json["PassportIssueDate"],
        passportNo: json["PassportNo"],
        paxId: json["PaxId"],
        paxType: json["PaxType"],
        phoneno: json["Phoneno"],
        title: json["Title"],
      );

  Map<String, dynamic> toJson() => {
        "Age": age,
        "Email": email,
        "FileDocument": fileDocument,
        "FirstName": firstName,
        "GSTCompanyAddress": gstCompanyAddress,
        "GSTCompanyContactNumber": gstCompanyContactNumber,
        "GSTCompanyEmail": gstCompanyEmail,
        "GSTCompanyName": gstCompanyName,
        "GSTNumber": gstNumber,
        "GuardianDetail": guardianDetail,
        "LastName": lastName,
        "LeadPassenger": leadPassenger,
        "MiddleName": middleName,
        "PAN": pan,
        "PassportExpDate": passportExpDate,
        "PassportIssueDate": passportIssueDate,
        "PassportNo": passportNo,
        "PaxId": paxId,
        "PaxType": paxType,
        "Phoneno": phoneno,
        "Title": title,
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
        tax: json["Tax"],
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
