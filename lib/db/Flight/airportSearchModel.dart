// To parse this JSON data, do
//
//     final airportListModel = airportListModelFromJson(jsonString);

import 'dart:convert';

List<AirportListModel> airportListModelFromJson(String str) => List<AirportListModel>.from(json.decode(str).map((x) => AirportListModel.fromJson(x)));

String airportListModelToJson(List<AirportListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AirportListModel {
  String? destinationcode;
  String? airportname;
  String? airportcode;
  String? cityname;
  String? citycode;
  String? countrycode;

  AirportListModel({
    this.destinationcode,
    this.airportname,
    this.airportcode,
    this.cityname,
    this.citycode,
    this.countrycode,
  });

  factory AirportListModel.fromJson(Map<String, dynamic> json) => AirportListModel(
    destinationcode: json["destinationcode"],
    airportname: json["airportname"],
    airportcode: json["airportcode"],
    cityname: json["cityname"],
    citycode: json["citycode"],
    countrycode: json["countrycode"],
  );

  Map<String, dynamic> toJson() => {
    "destinationcode": destinationcode,
    "airportname": airportname,
    "airportcode": airportcode,
    "cityname": cityname,
    "citycode": citycode,
    "countrycode": countrycode,
  };
}
