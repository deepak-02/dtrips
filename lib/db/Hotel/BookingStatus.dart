// // To parse this JSON data, do
// //
// //     final bookingStatus = bookingStatusFromJson(jsonString);
//
// import 'dart:convert';
//
// List<BookingStatus> bookingStatusFromJson(String str) => List<BookingStatus>.from(json.decode(str).map((x) => BookingStatus.fromJson(x)));
//
// String bookingStatusToJson(List<BookingStatus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class BookingStatus {
//   BookingStatus({
//     this.sl,
//     this.identity,
//     this.bookingid,
//     this.checkindate,
//     this.checkoutdate,
//     this.bookingdate,
//     this.status,
//     this.hotelname,
//     this.city,
//   });
//
//   int ? sl;
//   String ? identity;
//   String ? bookingid;
//   dynamic checkindate;
//   dynamic checkoutdate;
//   dynamic bookingdate;
//   int ? status;
//   String ? hotelname;
//   String ? city;
//
//   factory BookingStatus.fromJson(Map<String, dynamic> json) => BookingStatus(
//     sl: json["sl"],
//     identity: json["identity"],
//     bookingid: json["bookingid"],
//     checkindate: DateTime.parse(json["checkindate"]),
//     checkoutdate: DateTime.parse(json["checkoutdate"]),
//     bookingdate: DateTime.parse(json["bookingdate"]),
//     status: json["status"],
//     hotelname: json["hotelname"],
//     city: json["city"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sl": sl,
//     "identity": identity,
//     "bookingid": bookingid,
//     "checkindate": "${checkindate.year.toString().padLeft(4, '0')}-${checkindate.month.toString().padLeft(2, '0')}-${checkindate.day.toString().padLeft(2, '0')}",
//     "checkoutdate": "${checkoutdate.year.toString().padLeft(4, '0')}-${checkoutdate.month.toString().padLeft(2, '0')}-${checkoutdate.day.toString().padLeft(2, '0')}",
//     "bookingdate": "${bookingdate.year.toString().padLeft(4, '0')}-${bookingdate.month.toString().padLeft(2, '0')}-${bookingdate.day.toString().padLeft(2, '0')}",
//     "status": status,
//     "hotelname": hotelname,
//     "city": city,
//   };
// }

// To parse this JSON data, do
//
//     final bookingStatus = bookingStatusFromJson(jsonString);

import 'dart:convert';

List<BookingStatus?>? bookingStatusFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<BookingStatus?>.from(
            json.decode(str)!.map((x) => BookingStatus.fromJson(x)));

String bookingStatusToJson(List<BookingStatus?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class BookingStatus {
  BookingStatus({
    this.sl,
    this.identity,
    this.bookingid,
    this.checkindate,
    this.checkoutdate,
    this.bookingdate,
    this.price,
    this.status,
    this.hotelname,
    this.city,
    this.payid,
    this.cancelcharge,
    this.image,
    this.changerequestid,
    this.refund,
  });

  int? sl;
  String? identity;
  String? bookingid;
  dynamic checkindate;
  dynamic checkoutdate;
  dynamic bookingdate;
  dynamic price;
  int? status;
  String? hotelname;
  String? city;
  String? payid;
  dynamic cancelcharge;
  dynamic image;
  dynamic changerequestid;
  dynamic refund;

  factory BookingStatus.fromJson(Map<String, dynamic> json) => BookingStatus(
        sl: json["sl"],
        identity: json["identity"],
        bookingid: json["bookingid"],
        checkindate: DateTime.parse(json["checkindate"]),
        checkoutdate: DateTime.parse(json["checkoutdate"]),
        bookingdate: DateTime.parse(json["bookingdate"]),
        price: json["price"],
        status: json["status"],
        hotelname: json["hotelname"],
        city: json["city"],
        payid: json["payid"],
        cancelcharge: json["cancelcharge"],
        image: json["image"],
        changerequestid: json["changerequestid"],
        refund: json["refund"],
      );

  Map<String, dynamic> toJson() => {
        "sl": sl,
        "identity": identity,
        "bookingid": bookingid,
        "checkindate":
            "${checkindate!.year.toString().padLeft(4, '0')}-${checkindate!.month.toString().padLeft(2, '0')}-${checkindate!.day.toString().padLeft(2, '0')}",
        "checkoutdate":
            "${checkoutdate!.year.toString().padLeft(4, '0')}-${checkoutdate!.month.toString().padLeft(2, '0')}-${checkoutdate!.day.toString().padLeft(2, '0')}",
        "bookingdate":
            "${bookingdate!.year.toString().padLeft(4, '0')}-${bookingdate!.month.toString().padLeft(2, '0')}-${bookingdate!.day.toString().padLeft(2, '0')}",
        "price": price,
        "status": status,
        "hotelname": hotelname,
        "city": city,
        "payid": payid,
        "cancelcharge": cancelcharge,
        "image": image,
        "changerequestid": changerequestid,
        "refund": refund,
      };
}
