// To parse this JSON data, do
//
//     final hotelStaticData = hotelStaticDataFromJson(jsonString);

import 'dart:convert';

HotelStaticData hotelStaticDataFromJson(String str) =>
    HotelStaticData.fromJson(json.decode(str));

String hotelStaticDataToJson(HotelStaticData data) =>
    json.encode(data.toJson());

class HotelStaticData {
  HotelStaticData({
    this.basicPropertyInfo,
  });

  BasicPropertyInfo? basicPropertyInfo;

  factory HotelStaticData.fromJson(Map<String, dynamic> json) =>
      HotelStaticData(
        basicPropertyInfo:
            BasicPropertyInfo.fromJson(json["BasicPropertyInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "BasicPropertyInfo": basicPropertyInfo!.toJson(),
      };
}

class BasicPropertyInfo {
  BasicPropertyInfo({
    this.brandId,
    this.chainId,
    this.brandCode,
    this.tboHotelCode,
    this.hotelCityCode,
    this.hotelName,
    this.hotelCategoryId,
    this.hotelCategoryName,
    this.isHalal,
    this.vendorMessages,
    this.position,
    this.address,
    this.award,
    this.policy,
    this.attributes,
    this.amenityIds,
  });

  String? brandId;
  String? chainId;
  String? brandCode;
  String? tboHotelCode;
  String? hotelCityCode;
  String? hotelName;
  String? hotelCategoryId;
  String? hotelCategoryName;
  String? isHalal;
  VendorMessages? vendorMessages;
  Position? position;
  Address? address;
  Award? award;
  Policy? policy;
  Attributes? attributes;
  String? amenityIds;

  factory BasicPropertyInfo.fromJson(Map<String, dynamic> json) =>
      BasicPropertyInfo(
        brandId: json["BrandId"],
        chainId: json["ChainId"],
        brandCode: json["BrandCode"],
        tboHotelCode: json["TBOHotelCode"],
        hotelCityCode: json["HotelCityCode"],
        hotelName: json["HotelName"],
        hotelCategoryId: json["HotelCategoryId"],
        hotelCategoryName: json["HotelCategoryName"],
        isHalal: json["IsHalal"],
        vendorMessages: VendorMessages.fromJson(json["VendorMessages"]),
        position: Position.fromJson(json["Position"]),
        address: Address.fromJson(json["Address"]),
        award: Award.fromJson(json["Award"]),
        policy: Policy.fromJson(json["Policy"]),
        attributes: Attributes.fromJson(json["Attributes"]),
        amenityIds: json["AmenityIds"],
      );

  Map<String, dynamic> toJson() => {
        "BrandId": brandId,
        "ChainId": chainId,
        "BrandCode": brandCode,
        "TBOHotelCode": tboHotelCode,
        "HotelCityCode": hotelCityCode,
        "HotelName": hotelName,
        "HotelCategoryId": hotelCategoryId,
        "HotelCategoryName": hotelCategoryName,
        "IsHalal": isHalal,
        "VendorMessages": vendorMessages!.toJson(),
        "Position": position!.toJson(),
        "Address": address!.toJson(),
        "Award": award!.toJson(),
        "Policy": policy!.toJson(),
        "Attributes": attributes!.toJson(),
        "AmenityIds": amenityIds,
      };
}

class Address {
  Address({
    this.addressLine,
    this.cityName,
    this.postalCode,
    this.stateProv,
    this.countryName,
  });

  String? addressLine;
  String? cityName;
  String? postalCode;
  dynamic stateProv;
  CountryName? countryName;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine: json["AddressLine"],
        cityName: json["CityName"],
        postalCode: json["PostalCode"],
        stateProv: json["StateProv"],
        countryName: CountryName.fromJson(json["CountryName"]),
      );

  Map<String, dynamic> toJson() => {
        "AddressLine": addressLine,
        "CityName": cityName,
        "PostalCode": postalCode,
        "StateProv": stateProv,
        "CountryName": countryName!.toJson(),
      };
}

class CountryName {
  CountryName({
    this.code,
    this.empty,
  });

  String? code;
  String? empty;

  factory CountryName.fromJson(Map<String, dynamic> json) => CountryName(
        code: json["Code"],
        empty: json[""],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "": empty,
      };
}

class Attributes {
  Attributes({
    this.attribute,
  });

  Attribute? attribute;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        attribute: Attribute.fromJson(json["Attribute"]),
      );

  Map<String, dynamic> toJson() => {
        "Attribute": attribute!.toJson(),
      };
}

class Attribute {
  Attribute({
    this.attributeName,
    this.attributeType,
  });

  String? attributeName;
  String? attributeType;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        attributeName: json["AttributeName"],
        attributeType: json["AttributeType"],
      );

  Map<String, dynamic> toJson() => {
        "AttributeName": attributeName,
        "AttributeType": attributeType,
      };
}

class Award {
  Award({
    this.provider,
    this.rating,
    this.reviewUrl,
  });

  String? provider;
  String? rating;
  String? reviewUrl;

  factory Award.fromJson(Map<String, dynamic> json) => Award(
        provider: json["Provider"],
        rating: json["Rating"],
        reviewUrl: json["ReviewURL"],
      );

  Map<String, dynamic> toJson() => {
        "Provider": provider,
        "Rating": rating,
        "ReviewURL": reviewUrl,
      };
}

class Policy {
  Policy({
    this.checkInTime,
    this.checkOutTime,
  });

  String? checkInTime;
  String? checkOutTime;

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
        checkInTime: json["CheckInTime"],
        checkOutTime: json["CheckOutTime"],
      );

  Map<String, dynamic> toJson() => {
        "CheckInTime": checkInTime,
        "CheckOutTime": checkOutTime,
      };
}

class Position {
  Position({
    this.latitude,
    this.longitude,
  });

  String? latitude;
  String? longitude;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        latitude: json["Latitude"],
        longitude: json["Longitude"],
      );

  Map<String, dynamic> toJson() => {
        "Latitude": latitude,
        "Longitude": longitude,
      };
}

class VendorMessages {
  VendorMessages({
    this.vendorMessage,
  });

  VendorMessage? vendorMessage;

  factory VendorMessages.fromJson(Map<String, dynamic> json) => VendorMessages(
        vendorMessage: VendorMessage.fromJson(json["VendorMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "VendorMessage": vendorMessage!.toJson(),
      };
}

class VendorMessage {
  VendorMessage({
    this.title,
    this.infoType,
    this.subSection,
  });

  String? title;
  String? infoType;
  SubSection? subSection;

  factory VendorMessage.fromJson(Map<String, dynamic> json) => VendorMessage(
        title: json["Title"],
        infoType: json["InfoType"],
        subSection: SubSection.fromJson(json["SubSection"]),
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "InfoType": infoType,
        "SubSection": subSection!.toJson(),
      };
}

class SubSection {
  SubSection({
    this.subTitle,
    this.category,
    this.categoryCode,
    this.paragraph,
  });

  String? subTitle;
  String? category;
  String? categoryCode;
  Paragraph? paragraph;

  factory SubSection.fromJson(Map<String, dynamic> json) => SubSection(
        subTitle: json["SubTitle"],
        category: json["Category"],
        categoryCode: json["CategoryCode"],
        paragraph: Paragraph.fromJson(json["Paragraph"]),
      );

  Map<String, dynamic> toJson() => {
        "SubTitle": subTitle,
        "Category": category,
        "CategoryCode": categoryCode,
        "Paragraph": paragraph!.toJson(),
      };
}

class Paragraph {
  Paragraph({
    this.creatorId,
    this.type,
    this.url,
  });

  String? creatorId;
  String? type;
  String? url;

  factory Paragraph.fromJson(Map<String, dynamic> json) => Paragraph(
        creatorId: json["CreatorID"],
        type: json["Type"],
        url: json["URL"],
      );

  Map<String, dynamic> toJson() => {
        "CreatorID": creatorId,
        "Type": type,
        "URL": url,
      };
}
