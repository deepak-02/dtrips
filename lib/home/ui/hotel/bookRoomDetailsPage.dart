import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../db/Hotel/bookRoomModel.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../dashboard.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'BookedHotelPage.dart';
import 'models/bookRoomModel.dart';

class RoomBookPage extends StatefulWidget {
  const RoomBookPage(
      {Key? key,
      this.loginMethod,
      this.hotelCode,
      this.resultIndex,
      this.traceId,
      this.tokenId,
      this.hotelName,
      this.noOfRooms,
      this.hotelRoomDetails,
      this.night,
      this.checkin,
      this.checkout,
      this.categoryId,
      this.price,
      this.offeredPrice,
      this.Datein,
      this.Dateout,
      this.cancellationCharge,
      this.passport,
      this.IsPackageFare,
      this.IsPackagePakageDetails,
      this.pan})
      : super(key: key);

  final loginMethod;
  final hotelCode;
  final resultIndex;
  final traceId;
  final tokenId;
  final hotelName;
  final noOfRooms;
  final hotelRoomDetails;
  final night;
  final checkin;
  final checkout;
  final categoryId;
  final price;
  final offeredPrice;
  final Datein;
  final Dateout;
  final cancellationCharge;
  final passport;
  final pan;
  final IsPackageFare;
  final IsPackagePakageDetails;
  @override
  State<RoomBookPage> createState() => _RoomBookPageState();
}

class _RoomBookPageState extends State<RoomBookPage> {
  late BookRoomModel bookRoomModel = BookRoomModel(
      "Mr", "", "", "", "", null, 1, true, 0, null, null, null, "");

  List RoomPassenger = [];
  List passengersDetails = [];
  List Pass = [];

  String CorporateBooking = "Business";
  bool BusinessBooking = true;

  late Razorpay _razorpay;
  bool isLoading = false;

  int arrivalType = 1;
  int departureType = 1;

  final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm');

  final DateFormat displayFormatter = DateFormat('MMM dd, HH:mm');

  dynamic arrivalTime;
  dynamic departureTime;

  TextEditingController arrivalController = TextEditingController();
  TextEditingController departureController = TextEditingController();

  Future<void> _selectArrivalTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: arrivalTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF92278F),
            // accentColor: const Color(0xFF879AE9),
            colorScheme: const ColorScheme.light(primary: Color(0xFF92278F)),
            dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)))),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: arrivalTime != null
            ? TimeOfDay.fromDateTime(arrivalTime)
            : TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF92278F),
              // accentColor: const Color(0xFF879AE9),
              colorScheme: const ColorScheme.light(primary: Color(0xFF92278F)),
              dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          arrivalTime = pickedDateTime;
          arrivalController.text =
              displayFormatter.format(arrivalTime).toString();
        });
      }
    }
  }

  Future<void> _selectDepartureTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF92278F),
            // accentColor: const Color(0xFF879AE9),
            colorScheme: const ColorScheme.light(primary: Color(0xFF92278F)),
            dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)))),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: departureTime != null
            ? TimeOfDay.fromDateTime(departureTime)
            : TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF92278F),
              // accentColor: const Color(0xFF879AE9),
              colorScheme: const ColorScheme.light(primary: Color(0xFF92278F)),
              dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          departureTime = pickedDateTime;
          departureController.text =
              displayFormatter.format(departureTime).toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < StoredGuest.length; i++) {
      List _hotelPassengers = [];

      // passengersDetails.isEmpty ? null : passengersDetails.clear();

      for (var j = 1; j <= StoredGuest[i]['NoOfAdults']; j++) {
        _hotelPassengers.add(BookRoomModel(
                "Mr", "", "", "", "", null, 1, true, 0, null, null, null, "")
            .toJson());
        passengersDetails = _hotelPassengers;
        // print("Adult no: ${StoredGuest[i]['NoOfAdults']}");
        // print("i : $i" );
        // print("j : $j , Adult : ${StoredGuest[i]['NoOfAdults']}" );
        // print("$_hotelPassengers");

        List temp = hotelRoomDetail1;
        temp[i]['HotelPassenger'] = _hotelPassengers;
        RoomPassenger.add(temp[i]);
        print("Room:  $RoomPassenger");
        Pass = RoomPassenger;
      }

      if (StoredGuest[i]['NoOfChild'] != 0) {
        for (var j = 0; j < StoredGuest[i]['NoOfChild']; j++) {
          print("age =${StoredGuest[i]['ChildAge'][j]}");

          _hotelPassengers.add(BookRoomModel("Mr", "", "", "", "", null, 2,
                  true, StoredGuest[i]['ChildAge'][j], null, null, null, "")
              .toJson());
          passengersDetails = _hotelPassengers;
          // print("Adult no: ${StoredGuest[i]['NoOfAdults']}");  ChildAge
          // print("i : $i" );
          // print("j : $j , Adult : ${StoredGuest[i]['NoOfAdults']}" );
          // print("$_hotelPassengers");

          List temp = hotelRoomDetail1;
          temp[i]['HotelPassenger'] = _hotelPassengers;
          RoomPassenger.add(temp[i]);
          print("Room:  $RoomPassenger");
          Pass = RoomPassenger;
        }
      }

      // List temp = hotelRoomDetail1;
      // temp[i]['HotelPassenger'] = passengersDetails;
      // RoomPassenger.add(temp[i]);
      // Pass = RoomPassenger;

      // _hotelPassengers.add(BookRoomModel("Mr", "", "", "", "", null, 1, true, 0,
      //         null, null, null, "")
      //     .toJson());
    }
    // for (var i = 0; i < StoredGuest.length; i++) {
    //   for (var j = 0; j < StoredGuest[i]['NoOfAdults']; j++) {
    //     _hotelPassengers.add(BookRoomModel("Mr", "", "", "", "", null, 1, true, 0,
    //         null, null, null, "")
    //         .toJson());
    //     passengersDetails = _hotelPassengers;
    //   }
    //
    //   List passenger = [_hotelPassengers[i]];
    //   hotelRoomDetail[i]['HotelPassenger'] = passenger;
    //   RoomPassenger.add(hotelRoomDetail[i]);
    //
    //   // _hotelPassengers.add(BookRoomModel("Mr", "", "", "", "", null, 1, true, 0,
    //   //         null, null, null, "")
    //   //     .toJson());
    // }

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return isLoading
        ? Scaffold(
            body: Center(
              child: Container(
                  child: Lottie.asset('assets/lottie/loading.json',
                      fit: BoxFit.contain)),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 10),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              toolbarHeight: 80,
              leadingWidth: 45,
              title: Text(
                "${widget.hotelName}",
                style: TextStyle(
                    fontSize: screenSize.width / 18, color: Colors.black),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                              fontFamily: "Metropolis",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        Text(
                          "₹${widget.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontFamily: "Metropolis",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff92278f)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0xFFE9D4E9),
                          offset: Offset(2, 3),
                          blurRadius: 5.0,
                          spreadRadius: 2,
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Color(0xff92278f),
                          Color(0xff92278f),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        getOrderId();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width / 23,
                          fontFamily: 'Metropolis',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xAD9B9B9B),
                              offset: Offset(2, 3),
                              blurRadius: 5.0,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "CHECK-IN",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${widget.Datein}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${widget.night} night",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "CHECK-OUT",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${widget.Dateout}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${widget.noOfRooms} Rooms, ${GuestCount} Guest",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.purple),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // SelectableText("$hotelRoomDetail1"),

                      ListView.separated(
                        shrinkWrap: true,
                        reverse: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.noOfRooms,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xAD9B9B9B),
                                  offset: Offset(2, 3),
                                  blurRadius: 5.0,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xff92278f),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Room ${index + 1} : ",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${StoredGuest[index]['NoOfAdults']} Adult, ${StoredGuest[index]['NoOfChild']} Child",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text(
                                        "For child,please provide the details of the guardian.",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              " * ",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "Required fields.",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    reverse: false,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: StoredGuest[index]
                                            ['NoOfAdults'] +
                                        StoredGuest[index]['NoOfChild'],
                                    itemBuilder: (context, ind) {
                                      return hotelRoomDetail1[index]
                                                      ['HotelPassenger'][ind]
                                                  ['PaxType'] ==
                                              1
                                          ? Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xAD9B9B9B),
                                                    offset: Offset(2, 3),
                                                    blurRadius: 5.0,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 10,
                                                            top: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .black,
                                                                size: 18,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Passenger ${ind + 1} Adult",
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        FittedBox(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Radio(
                                                                    value: "Mr",
                                                                    groupValue: hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'Title'],
                                                                    onChanged:
                                                                        (value) {
                                                                      // print(value);
                                                                      setState(
                                                                          () {
                                                                        // selectedValue = value.toString();
                                                                        bookRoomModel.Title =
                                                                            value.toString();
                                                                        hotelRoomDetail1[index]['HotelPassenger'][ind]['Title'] =
                                                                            value.toString();
                                                                      });
                                                                    },
                                                                  ),
                                                                  const Text(
                                                                      "Mr.")
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Radio(
                                                                    value: "Ms",
                                                                    groupValue: hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'Title'],
                                                                    onChanged:
                                                                        (value) {
                                                                      // print(value);
                                                                      setState(
                                                                          () {
                                                                        //selectedValue = value.toString();
                                                                        bookRoomModel.Title =
                                                                            value.toString();
                                                                        hotelRoomDetail1[index]['HotelPassenger'][ind]['Title'] =
                                                                            value.toString();
                                                                      });
                                                                    },
                                                                  ),
                                                                  const Text(
                                                                      "Ms.")
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Radio(
                                                                    value:
                                                                        "Mrs",
                                                                    groupValue: hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'Title'],
                                                                    onChanged:
                                                                        (value) {
                                                                      // print(value);
                                                                      setState(
                                                                          () {
                                                                        // selectedValue = value.toString();
                                                                        bookRoomModel.Title =
                                                                            value.toString();
                                                                        hotelRoomDetail1[index]['HotelPassenger'][ind]['Title'] =
                                                                            value.toString();
                                                                      });
                                                                    },
                                                                  ),
                                                                  const Text(
                                                                      "Mrs.")
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Radio(
                                                                    value:
                                                                        "Miss",
                                                                    groupValue: hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'Title'],
                                                                    onChanged:
                                                                        (value) {
                                                                      // print(value);
                                                                      setState(
                                                                          () {
                                                                        // selectedValue = value.toString();
                                                                        bookRoomModel.Title =
                                                                            value.toString();
                                                                        hotelRoomDetail1[index]['HotelPassenger'][ind]['Title'] =
                                                                            value.toString();
                                                                      });
                                                                    },
                                                                  ),
                                                                  const Text(
                                                                      "Miss.")
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    // labelText: 'First Name',
                                                                    label:
                                                                        FittedBox(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "* ",
                                                                            style:
                                                                                TextStyle(color: Colors.red, fontSize: 18),
                                                                          ),
                                                                          Text(
                                                                            "First Name",
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontSize: 14),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    labelStyle:
                                                                        TextStyle(
                                                                            color:
                                                                                Colors.black)),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {}
                                                              return null;
                                                            },
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .FirstName =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'FirstName'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Middle Name',
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .MiddleName =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'MiddleName'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              // labelText: 'Last Name',
                                                              label: FittedBox(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "* ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    Text(
                                                                      "Last Name",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .LastName =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'LastName'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              // labelText: 'Email',
                                                              label: FittedBox(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "* ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    Text(
                                                                      "Email",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .Email =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'Email'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),

                                                        // widget.pan == true ?
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              // labelText: 'PAN',
                                                              label: FittedBox(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "* ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    Text(
                                                                      "PAN",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .PAN =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'PAN'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        // : Container(),
                                                        // widget.pan == true ?
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        // : Container(),

                                                        // widget.passport == true
                                                        //     ?
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              // labelText: 'Passport',
                                                              label: FittedBox(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "* ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    Text(
                                                                      "Passport",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .PassportNo =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'PassportNo'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        // : Container(),
                                                        // widget.passport == true ?
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        // : Container(),

                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              // labelText: 'Phone Number',
                                                              label: FittedBox(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "* ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    Text(
                                                                      "Phone Number",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .Phoneno =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'Phoneno'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xAD9B9B9B),
                                                    offset: Offset(2, 3),
                                                    blurRadius: 5.0,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 10,
                                                            top: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .black,
                                                                size: 18,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Passenger ${ind + 1} Child",
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                        // SizedBox(
                                                        // height: 10,
                                                        // ),
                                                        // FittedBox(
                                                        // child: Row(
                                                        // crossAxisAlignment:
                                                        // CrossAxisAlignment.start,
                                                        // mainAxisAlignment:
                                                        // MainAxisAlignment.start,
                                                        // children: [
                                                        // Row(
                                                        // children: [
                                                        // Radio(
                                                        // value: "Mr",
                                                        // groupValue:
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]['Title'],
                                                        // onChanged: (value) {
                                                        // // print(value);
                                                        // setState(() {
                                                        // // selectedValue = value.toString();
                                                        // bookRoomModel.Title =
                                                        // value.toString();
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]['Title'] =
                                                        // value.toString();
                                                        // });
                                                        // },
                                                        // ),
                                                        // Text("Mr.")
                                                        // ],
                                                        // ),
                                                        // Row(
                                                        // children: [
                                                        // Radio(
                                                        // value: "Ms",
                                                        // groupValue:
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]
                                                        // ['Title'],
                                                        // onChanged: (value) {
                                                        // // print(value);
                                                        // setState(() {
                                                        // //selectedValue = value.toString();
                                                        // bookRoomModel.Title =
                                                        // value.toString();
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]
                                                        // ['Title'] =
                                                        // value.toString();
                                                        // });
                                                        // },
                                                        // ),
                                                        // Text("Ms.")
                                                        // ],
                                                        // ),
                                                        // Row(
                                                        // children: [
                                                        // Radio(
                                                        // value: "Mrs",
                                                        // groupValue:
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]
                                                        // ['Title'],
                                                        // onChanged: (value) {
                                                        // // print(value);
                                                        // setState(() {
                                                        // // selectedValue = value.toString();
                                                        // bookRoomModel.Title =
                                                        // value.toString();
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]
                                                        // ['Title'] =
                                                        // value.toString();
                                                        // });
                                                        // },
                                                        // ),
                                                        // Text("Mrs.")
                                                        // ],
                                                        // ),
                                                        // Row(
                                                        // children: [
                                                        // Radio(
                                                        // value: "Miss",
                                                        // groupValue:
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]
                                                        // ['Title'],
                                                        // onChanged: (value) {
                                                        // // print(value);
                                                        // setState(() {
                                                        // // selectedValue = value.toString();
                                                        // bookRoomModel.Title =
                                                        // value.toString();
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]
                                                        // ['Title'] =
                                                        // value.toString();
                                                        // });
                                                        // },
                                                        // ),
                                                        // Text("Miss.")
                                                        // ],
                                                        // ),
                                                        // ],
                                                        // ),
                                                        // ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              // labelText: 'First Name',
                                                              label: FittedBox(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "* ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    Text(
                                                                      "First Name",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .FirstName =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'FirstName'] =
                                                                    value
                                                                        .toString();

                                                                hotelRoomDetail1[
                                                                            index]
                                                                        [
                                                                        'HotelPassenger'][ind]
                                                                    [
                                                                    'Title'] = hotelRoomDetail1[
                                                                            index]
                                                                        [
                                                                        'HotelPassenger']
                                                                    [
                                                                    0]['Title'];

                                                                hotelRoomDetail1[
                                                                            index]
                                                                        [
                                                                        'HotelPassenger'][ind]
                                                                    [
                                                                    'PAN'] = hotelRoomDetail1[
                                                                            index]
                                                                        [
                                                                        'HotelPassenger']
                                                                    [0]['PAN'];
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        // Container(
                                                        // height: 50,
                                                        // color: Color(0x1292278f),
                                                        // child: TextFormField(
                                                        // decoration: InputDecoration(
                                                        // border: OutlineInputBorder(),
                                                        // labelText: 'Middle Name',
                                                        // ),
                                                        // onChanged: (value) {
                                                        // setState(() {
                                                        // bookRoomModel.MiddleName =
                                                        // value.toString();
                                                        // hotelRoomDetail1[index]['HotelPassenger'][ind]
                                                        // ['MiddleName'] =
                                                        // value.toString();
                                                        // });
                                                        // },
                                                        // ),
                                                        // ),
                                                        // SizedBox(
                                                        // height: 10,
                                                        // ),
                                                        Container(
                                                          height: 50,
                                                          color: const Color(
                                                              0x1292278f),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              // labelText: 'Last Name',
                                                              label: FittedBox(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "* ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    Text(
                                                                      "Last Name",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                bookRoomModel
                                                                        .LastName =
                                                                    value
                                                                        .toString();
                                                                hotelRoomDetail1[index]['HotelPassenger']
                                                                            [
                                                                            ind]
                                                                        [
                                                                        'LastName'] =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xAD9B9B9B),
                              offset: Offset(2, 3),
                              blurRadius: 5.0,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff92278f),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              child: const Row(
                                children: [
                                  Text(
                                    "Package Details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Arrival Details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: arrivalType,
                                              onChanged: (value) {
                                                print(value);
                                                setState(() {
                                                  arrivalType = value!;
                                                });
                                              },
                                            ),
                                            const Text("By Flight.")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: 2,
                                              groupValue: arrivalType,
                                              onChanged: (value) {
                                                print(value);
                                                setState(() {
                                                  arrivalType = value!;
                                                });
                                              },
                                            ),
                                            const Text("By Surface")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 50,
                                          color: const Color(0x1292278f),
                                          child: arrivalType == 1
                                              ? TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    label: FittedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "* ",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            "Flight No",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle flight no. value change
                                                  },
                                                )
                                              : TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    label: FittedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "* ",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            "Transport Type/No",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle flight no. value change
                                                  },
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Add spacing between the two text form fields
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 50,
                                          color: const Color(0x1292278f),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () =>
                                                _selectArrivalTime(context),
                                            controller: arrivalController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Date&Time",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              // Handle first name value change
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Departure Details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: departureType,
                                              onChanged: (value) {
                                                print(value);
                                                setState(() {
                                                  departureType = value!;
                                                });
                                              },
                                            ),
                                            const Text("By Flight.")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: 2,
                                              groupValue: departureType,
                                              onChanged: (value) {
                                                print(value);
                                                setState(() {
                                                  departureType = value!;
                                                });
                                              },
                                            ),
                                            const Text("By Surface")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 50,
                                          color: const Color(0x1292278f),
                                          child: departureType == 1
                                              ? TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    label: FittedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "* ",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            "Flight No",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle flight no. value change
                                                  },
                                                )
                                              : TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    label: FittedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "* ",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            "Transport Type/No",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle flight no. value change
                                                  },
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Add spacing between the two text form fields
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 50,
                                          color: const Color(0x1292278f),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () =>
                                                _selectDepartureTime(context),
                                            controller: departureController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Date&Time",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "What is the purpose of your trip?",
                        style: TextStyle(fontSize: screenSize.width / 22),
                      ),
                      FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: "Business",
                                  groupValue: CorporateBooking,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      CorporateBooking = value.toString();
                                      BusinessBooking = true;
                                      print(
                                          "Corporite booking : $CorporateBooking");
                                      print(
                                          "Business booking : $BusinessBooking");
                                    });
                                  },
                                ),
                                const Text("Business.")
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: "Leisure",
                                  groupValue: CorporateBooking,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      CorporateBooking = value.toString();
                                      BusinessBooking = false;
                                      print(
                                          "Corporite booking : $CorporateBooking");
                                      print(
                                          "Business booking : $BusinessBooking");
                                    });
                                  },
                                ),
                                const Text("Leisure.")
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void bookNow(String paymentId) async {
    try {
      RoomPassenger.length >= widget.noOfRooms ? RoomPassenger.clear() : null;

      print("package fare");
      print(widget.IsPackageFare);

      setState(() {
        isLoading = true;
        // for (var i = 0; i < widget.noOfRooms; i++) {
        //   // hotelRoomDetail[i].add(_hotelPassengers[i]);
        //   List passenger = [_hotelPassengers[i]];
        //   hotelRoomDetail[i]['HotelPassenger'] = passenger;
        //   RoomPassenger.add(hotelRoomDetail[i]);
        // }
      });
      // print(RoomPassenger);
      // print(RoomPassenger.length);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var ips = prefs.getString('ip');
      final response = await http.post(
        Uri.parse(api + 'api/hotels/book'),
        body: jsonEncode({
          "EndUserIp": "$ips",
          "TokenId": "${widget.tokenId}",
          "TraceId": "${widget.traceId}",
          "AgencyId": 57222, //80992,
          "ResultIndex": "${widget.resultIndex}",
          "HotelCode": "${widget.hotelCode}",
          "CategoryId": "${widget.categoryId}",
          "HotelName": "${widget.hotelName}",
          "GuestNationality": "IN",
          "NoOfRooms": widget.noOfRooms,
          "IsVoucherBooking": true,
          "RoomDetails": hotelRoomDetail1,
          "IsCorporate": BusinessBooking,
          "IsPackageFare": widget.IsPackageFare,
          "IsPackageDetailsMandatory": widget.IsPackagePakageDetails,
          "DepartureTransport": {
            "TransportInfoId": departureController.text,
            "Time": "${formatter.format(departureTime)}"
          },
          "ArrivalTransportType": arrivalType,
          "TransportInfoId": arrivalController.text,
          "Time": "${formatter.format(arrivalTime)}"
        }),
        headers: {"content-type": "application/json"},
      );
      print("Bookkkkkkk");
      log(response.body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 500) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            icon: Container(
              height: 100,
              child:
                  Lottie.asset('assets/lottie/500.json', fit: BoxFit.contain),
            ),
            title: Text(
              "OOPS! There is an internal server error occoured",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Try again or feel free to contact us if the problem persists.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 24,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.off(() => Dashboard()),
                    child: const Text(
                      'Go Home',
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xff92278f),
                          width: 1.0,
                        ),
                      ),
                      backgroundColor: const Color(0xff92278f),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }

      if (response.statusCode == 200) {
        final result = hotelBookFromJson(response.body);
        if (result.bookResult!.error!.errorCode == 0) {
          saveEmail(result.email);

          setState(() {
            isLoading = false;
          });

          saveBooking(result.bookResult!.bookingId, paymentId);
          showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              icon: Container(
                height: 100,
                child: Lottie.asset('assets/lottie/success1.json',
                    fit: BoxFit.contain),
              ),
              title: Text(
                "Success",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Your booking is done successfully.\nYou will be re directed to voucher page.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 24,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Get.offAll(BookedHotelDetailsPage(
                        Bookedprice: widget.price.toStringAsFixed(2),
                        BookingId: result.bookResult!.bookingId,
                        cancellationCharge:
                            widget.cancellationCharge.toString(),
                        payId: paymentId,
                      )),
                      child: const Text(
                        'View Booking',
                        style: TextStyle(
                            color: Color(0xff92278f),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xff92278f),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.offAll(Dashboard()),
                      child: const Text(
                        'Ok',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xff92278f),
                            width: 1.0,
                          ),
                        ),
                        backgroundColor: const Color(0xff92278f),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );

          Timer(const Duration(seconds: 2), () {
            Get.offAll(BookedHotelDetailsPage(
              Bookedprice: widget.price.toStringAsFixed(2),
              BookingId: result.bookResult!.bookingId,
              cancellationCharge: widget.cancellationCharge.toString(),
              payId: paymentId,
              img: SaveImg,
              status: 1,
              city: "$city",
            ));
            // hotelRoomDetail.clear();
            // hotelRoomDetail1.clear();
          });
          Timer(const Duration(seconds: 4), () {
            hotelRoomDetail.clear();
            hotelRoomDetail1.clear();
          });
        } else {
          setState(() {
            isLoading = false;
          });
          //booking failed $ payment done
          //show alert and refund payment
          refundPayment(paymentId);

          //...
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              icon: Container(
                height: 100,
                child: Lottie.asset('assets/lottie/error-x.json',
                    fit: BoxFit.contain),
              ),
              title: Text(
                "OOPS...! ${result.bookResult!.error!.errorCode}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                //"Sorry, something went wrong\nIf some amount is deducted from your account, it will be refunded within 48 hours.",
                "${result.bookResult!.error!.errorMessage}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 24,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xff92278f),
                            width: 1.0,
                          ),
                        ),
                        backgroundColor: const Color(0xff92278f),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
          //...
        }
      } else {
        refundPayment(paymentId);
        setState(() {
          isLoading = false;
        });
        //booking failed $ payment done
        //show alert and refund payment

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            icon: Container(
              height: 100,
              child: Lottie.asset('assets/lottie/error-x.json',
                  fit: BoxFit.contain),
            ),
            title: Text(
              "${response.statusCode} OOPS...!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              "${response.body}\nIf some amount is deducted from your account, it will be refunded within 48 hours.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 24,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xff92278f),
                          width: 1.0,
                        ),
                      ),
                      backgroundColor: const Color(0xff92278f),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  refundPayment(String paymentId) async {
    final response = await http.post(
      Uri.parse('${api}api/payments/refund'),
      body: jsonEncode({
        'amount': ((widget.price * 100).round()).toString(),
        'payId': paymentId
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);
    print('refund api');

    Timer(const Duration(seconds: 3), () {
      Get.offAll(Dashboard());
    });
  }

  saveBooking(var bookingId, String paymentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginMethod = prefs.get('login');
    var email = prefs.get('email');
    var bookdate = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

    print("..................................");
    print("city: $city");
    print("hotelname: ${widget.hotelName}");
    print("status: 1");
    print("bookingdate: $bookdate");
    print("checkoutdate: ${widget.checkout}");
    print("checkindate: ${widget.checkin}");
    print("bookingid: ${int.parse(bookingId.toString())}");
    print("identity: $email");
    print("payid: $paymentId");
    print("price: ${widget.price.toStringAsFixed(2)}");
    print("offerprice: ${widget.offeredPrice.toStringAsFixed(2)}");
    print("cancelcharge: ${widget.cancellationCharge.toString()}");
    print("image: $SaveImg");
    print("..................................");

    final response = await http.post(
      Uri.parse('${api}api/hotel-book/save'),
      body: jsonEncode({
        "city": "$city",
        "hotelname": "${widget.hotelName}",
        "status": 1,
        "bookingdate": "$bookdate",
        "checkoutdate": "${widget.checkout}",
        "checkindate": "${widget.checkin}",
        "bookingid": bookingId,
        "identity": "$email",
        "price": widget.price.toStringAsFixed(2),
        "offerprice": widget.offeredPrice.toStringAsFixed(2),
        "payid": "$paymentId",
        "cancelcharge": widget.cancellationCharge.toString(),
        "image": "$SaveImg"
      }
          //     {
          //   "city": "$city",
          //   "hotelname": "${widget.hotelName}",
          //   "status": 1,
          //   "bookingdate": "$bookdate",
          //   "checkoutdate": "${widget.checkout}",
          //   "checkindate": "${widget.checkin}",
          //   "bookingid": int.parse(bookingId.toString()),
          //   "identity": "$email",
          //   "payid": "$paymentId",
          //   "price": "${widget.price.toStringAsFixed(2)}",
          //   "offerprice": "${widget.offeredPrice.toStringAsFixed(2)}",
          //   "cancelcharge": "${widget.cancellationCharge.toString()}",
          //   "image": "$SaveImg",
          // }
          ),
      headers: {"content-type": "application/json"},
    );

    print(response.request!.method);
    print(response.statusCode);
    print(response.body);

    setState(() {
      isLoading = false;
    });

    // var a = '2022-05-15';
    // var b = DateTime.parse(a);
    // var c = DateFormat('dd MMM').format(b).toString();
    // var d = DateTime.now();
    // var e = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    // print(e);
  }

  getOrderId() async {
    final response = await http.post(
      Uri.parse('${api}api/payments/order'),
      body: jsonEncode({
        'amount': ((widget.price * 100).round()).toString(),
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    var orderId = response.body.replaceAll('"', '');
    //if get order id then call start payment method
    if (response.statusCode == 200) {
      startPayment(orderId);
    }
  }

  startPayment(var orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var phone = prefs.getString('phone');
    var options = {
      'key': "rzp_test_ehCpwEfxvPgoqK",
      // amount will be multiple of 100
      'amount': ((widget.price * 100).round())
          .toString(), //(widget.price * 100).toString(),
      'order_id': orderId,
      //'image': "assets/images/app_icon.png", //`Your business logo`,
      'name': 'dtrips',
      'description': 'Dtrips',
      'timeout': 120, // in seconds
      'prefill': {'contact': '$phone', 'email': '$email'},
      'method': {
        'netbanking': true,
        'card': true,
        'wallet': false,
        'upi': true,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("error = $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("RazorPay Success");
    print("order id : ${response.orderId}");
    print("payment id : ${response.paymentId}");
    print("Signature : ${response.signature}");
    bookNow(response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("RazorPay failure");
    print("Error code: ${response.code}");
    print("Error message : ${response.message}");
    print("Error : ${response.error}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("RazorPay Wallet");
    print("Wallet Name : ${response.walletName}");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void saveEmail(String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var loginMethod = prefs.get('login');

      loginMethod == null ||
              loginMethod == 'guest' && email != null ||
              email != ''
          ? prefs.setString('email', email.toString())
          : null;
      var mail = prefs.get('email');
      print(email);
      print(mail);
    });
  }
}
