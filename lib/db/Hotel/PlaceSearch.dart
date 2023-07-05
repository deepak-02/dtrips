// To parse this JSON data, do
//
//     final hotelPlaceSearch = hotelPlaceSearchFromJson(jsonString);

import 'dart:convert';

List<HotelPlaceSearch> hotelPlaceSearchFromJson(String str) =>
    List<HotelPlaceSearch>.from(
        json.decode(str).map((x) => HotelPlaceSearch.fromJson(x)));

String hotelPlaceSearchToJson(List<HotelPlaceSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelPlaceSearch {
  HotelPlaceSearch({
    this.countrycode,
    this.country,
    this.stateprovincecode,
    this.stateprovince,
    this.destination,
    this.cityid,
  });

  String? countrycode;
  String? country;
  String? stateprovincecode;
  String? stateprovince;
  String? destination;
  String? cityid;

  factory HotelPlaceSearch.fromJson(Map<String, dynamic> json) =>
      HotelPlaceSearch(
        countrycode: json["countrycode"],
        country: json["country"],
        stateprovincecode: json["stateprovincecode"],
        stateprovince: json["stateprovince"],
        destination: json["destination"],
        cityid: json["cityid"],
      );

  Map<String, dynamic> toJson() => {
        "countrycode": countrycode,
        "country": country,
        "stateprovincecode": stateprovincecode,
        "stateprovince": stateprovince,
        "destination": destination,
        "cityid": cityid,
      };
}
