import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../global.dart';
import '../../widgets/widgets.dart';
import '../flight/flightSearch.dart';
import '../flight/airport_list_page.dart';
import '../flight/passengers_page.dart';
import '../hotel/SearchResult.dart';
import '../hotel/hotel_places_page.dart';
import '../hotel/rooms_page.dart';

var isSelected = "hotel";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.restorationId});
  final String? restorationId;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RestorationMixin {
  int currentIndex = 0;
  bool isLoading = true;

  // final List<String> imageList = [
  //   'assets/images/9.jpg',
  //   'assets/images/2.jpg',
  //   'assets/images/3.jpg',
  //   'assets/images/4.jpg',
  //   'assets/images/5.jpg',
  //   'assets/images/6.jpg',
  //   'assets/images/7.jpg',
  // ];

  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _endDate =
      RestorableDateTimeN(DateTime.now().add(const Duration(days: 1)));
  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      setState(() {});
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;

        isSelected == "hotel"
            ? inDate = DateFormat('dd MMM').format(_startDate.value as DateTime)
            : depDate =
                DateFormat('dd MMM').format(_startDate.value as DateTime);
        isSelected == "hotel"
            ? outDate = DateFormat('dd MMM').format(_endDate.value as DateTime)
            : retDate = DateFormat('dd MMM').format(_endDate.value as DateTime);
        isSelected == "hotel"
            ? chechinDate = DateFormat('yyyy-MM-dd')
                .format(_startDate.value as DateTime)
                .toString()
            : departureDate = DateFormat('yyyy-MM-ddT00:00:00')
                .format(_startDate.value as DateTime)
                .toString();
        isSelected == "hotel"
            ? checkOutDate = DateFormat('yyyy-MM-dd')
                .format(_endDate.value as DateTime)
                .toString()
            : returnDate = DateFormat('yyyy-MM-ddT00:00:00')
                .format(_endDate.value as DateTime)
                .toString();
        isSelected == "hotel"
            ? passDate1 = DateFormat('dd MMM')
                .format(_startDate.value as DateTime)
                .toString()
            : depDate = DateFormat('dd MMM')
                .format(_startDate.value as DateTime)
                .toString();
        isSelected == "hotel"
            ? passDate2 = DateFormat('dd MMM')
                .format(_endDate.value as DateTime)
                .toString()
            : retDate = DateFormat('dd MMM')
                .format(_endDate.value as DateTime)
                .toString();
        var day1 = _startDate.value as DateTime;
        var day2 = _endDate.value as DateTime;
        isSelected == "hotel"
            ? night = day2.difference(day1).inDays
            : nightF = day2.difference(day1).inDays;
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime.now(),
          currentDate: DateTime.now(),
          lastDate: DateTime(2099),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }
    return null;
  }

  var initialDate = DateTime.now();
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1.0),
            Color.fromRGBO(255, 255, 255, 1.0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = "hotel";
                              });
                            },
                            child: Container(
                              height: 94,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                border: Border.all(
                                  color: isSelected == "hotel"
                                      ? const Color(0xff92278f)
                                      : const Color(0xffffffff),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected == "hotel"
                                        ? const Color(0x4092278e)
                                        : const Color(0xFFE9D4E9),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: const Offset(
                                      1,
                                      3,
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/hotel2.png'),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Hotel",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Metropolis',
                                          color: isSelected == "hotel"
                                              ? Colors.purple
                                              : Colors.black,
                                          fontWeight: isSelected == "hotel"
                                              ? FontWeight.bold
                                              : FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = "flight";
                              });
                            },
                            child: Container(
                              height: 94,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                border: Border.all(
                                  color: isSelected == "flight"
                                      ? const Color(0xff92278f)
                                      : const Color(0xffffffff),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected == "flight"
                                        ? const Color(0x4092278e)
                                        : const Color(0xFFE9D4E9),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: const Offset(
                                      1,
                                      3,
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/airplane1.png'),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Flight",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Metropolis',
                                          color: isSelected == "flight"
                                              ? Colors.purple
                                              : Colors.black,
                                          fontWeight: isSelected == "flight"
                                              ? FontWeight.bold
                                              : FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: AnimatedSizeAndFade(
                        fadeDuration: const Duration(milliseconds: 600),
                        sizeDuration: const Duration(milliseconds: 600),
                        fadeInCurve: Curves.bounceIn,
                        fadeOutCurve: Curves.bounceOut,
                        sizeCurve: Curves.fastLinearToSlowEaseIn,
                        child: isSelected == "hotel"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Find Your Hotel",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                        width: 65,
                                        child: Lottie.asset(
                                            'assets/lottie/hotel-bell.json',
                                            fit: BoxFit.contain)),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Find Your Flight",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                        width: 130,
                                        child: Lottie.asset(
                                            'assets/lottie/flight-ticket.json',
                                            fit: BoxFit.contain)),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: AnimatedSizeAndFade(
                        fadeDuration: const Duration(milliseconds: 300),
                        sizeDuration: const Duration(milliseconds: 600),
                        child: isSelected == "hotel"
                            ? hotelCard(screenSize, context, orientation)
                            : flightCard(screenSize, context),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // imageSlider(),
                    const MyCarousel(),
                    const SizedBox(
                      height: 30,
                    ),
                    popularPlaces(),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Column imageSlider() {
  //   return Column(
  //     children: [
  //       CarouselSlider(
  //         options: CarouselOptions(
  //           height: 180,
  //           autoPlay: true,
  //           enlargeCenterPage: true,
  //           autoPlayInterval: const Duration(seconds: 5),
  //           autoPlayAnimationDuration: const Duration(milliseconds: 800),
  //           autoPlayCurve: Curves.linear,
  //           pauseAutoPlayOnTouch: true,
  //           onPageChanged: (index, reason) {
  //             setState(() {
  //               currentIndex = index;
  //             });
  //           },
  //         ),
  //         items: imageList.map((imagePath) {
  //           return Builder(
  //             builder: (BuildContext context) {
  //               return SizedBox(
  //                 height: 250,
  //                 width: 300,
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     // Handle item tap
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(16),
  //                       image: DecorationImage(
  //                         image: AssetImage(imagePath),
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         }).toList(),
  //       ),
  //
  //       // Padding(
  //       //   padding: const EdgeInsets.only(left: 10, right: 10),
  //       //   child: Row(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     children: List<Widget>.generate(imageList.length, (index) {
  //       //       return Container(
  //       //         width: 10.0,
  //       //         height: 10.0,
  //       //         margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
  //       //         decoration: BoxDecoration(
  //       //           shape: BoxShape.circle,
  //       //           color: currentIndex == index
  //       //               ? const Color(0xff92278f)
  //       //               : Colors.grey,
  //       //         ),
  //       //       );
  //       //     }),
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }

  Column flightCard(Size screenSize, BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0x1f000000),
              width: 1,
            ),
            gradient: const LinearGradient(
              colors: [Color(0xFFF6F6FF), Color(0xFFF6F6FF)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xd1d19cd1),
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  4,
                ),
              )
            ],
            //color: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      btn1 = "active";
                      btn2 = "";
                      btn3 = "";
                      journeyType = 1;
                    });
                  },
                  child: Text(
                    "ONE-WAY",
                    style: TextStyle(
                        fontSize: 14,
                        color: btn1 == "active"
                            ? const Color(0xff92278f)
                            : const Color(0xffb2a1b8),
                        fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      btn2 == "active"
                          ? null
                          : retDate = DateFormat('dd MMM')
                              .format(DateTime.parse(departureDate)
                                  .add(const Duration(days: 1)))
                              .toString();
                      btn1 = "";
                      btn2 = "active";
                      btn3 = "";
                      journeyType = 2;
                    });
                  },
                  child: Text(
                    "ROUND TRIP",
                    style: TextStyle(
                        fontSize: 14,
                        color: btn2 == "active"
                            ? const Color(0xff92278f)
                            : const Color(0xffb2a1b8),
                        fontWeight: FontWeight.bold),
                  )),
              // TextButton(
              //     onPressed: () {
              //       setState(() {
              //         btn1 = "";
              //         btn2 = "";
              //         btn3 = "active";
              //         journeyType = 3;
              //       });
              //     },
              //     child: Text(
              //       "MULTICITY",
              //       style: TextStyle(
              //           fontSize: 14,
              //           color: btn3 == "active"
              //               ? Color(0xff92278f)
              //               : Color(0xffb2a1b8),
              //           fontWeight: FontWeight.bold),
              //     ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0x1f000000),
              width: 1,
            ),
            gradient: const LinearGradient(
              colors: [Color(0xFFF6F6FF), Color(0xFFF6F6FF)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xd1d19cd1),
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  4,
                ),
              )
            ],
            //color: Colors.blue,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            "Departure",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF900082),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const AirportListPage(
                              type: "origin",
                            ));
                          },
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0x0d000000),
                                width: 1,
                              ),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5, right: 10),
                                  child: Icon(
                                    Icons.flight_land_outlined,
                                    color: Color(0xA5000000),
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  "$fromPort,$fromPlace",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xA5000000),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // print("swap click");
                                String place;
                                String port;
                                String origin;

                                place = toPlace;
                                toPlace = fromPlace;
                                fromPlace = place;

                                port = toPort;
                                toPort = fromPort;
                                fromPort = port;

                                origin = originAirportCode;
                                originCode = destinationCode;
                                destinationCode = origin;
                              });
                            },
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 13,
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.swap_vert_outlined,
                                  // size: 18,
                                  color: Color(0xA5000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Destination",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF900082),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const AirportListPage(
                              type: "destination",
                            ));
                          },
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0x0d000000),
                                width: 1,
                              ),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5, right: 10),
                                  child: Icon(
                                    Icons.flight_takeoff_outlined,
                                    color: Color(0xA5000000),
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  "$toPort,$toPlace",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xA5000000),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    btn2 == "active"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10, top: 8),
                                    child: Text(
                                      "Departure Date",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF900082),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _restorableDateRangePickerRouteFuture
                                          .present();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: screenSize.width / 2.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(0x0d000000),
                                          width: 1,
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFFFFFFFF)
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 10),
                                            child: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Color(0xA5000000),
                                              size: 18,
                                            ),
                                          ),
                                          Text(
                                            depDate,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xA5000000),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10, top: 8),
                                    child: Text(
                                      "Arrival Date",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF900082),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _restorableDateRangePickerRouteFuture
                                          .present();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: screenSize.width / 2.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(0x0d000000),
                                          width: 1,
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFFFFFFFF)
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 10),
                                            child: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Color(0xA5000000),
                                              size: 18,
                                            ),
                                          ),
                                          Text(
                                            retDate,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xA5000000),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10, top: 8),
                                    child: Text(
                                      "Departure Date",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF900082),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      var datePicker = await showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: initialDate,
                                        lastDate: DateTime(2099),
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              primaryColor:
                                                  const Color(0xFF92278F),
                                              // accentColor: const Color(0xFF879AE9),
                                              colorScheme:
                                                  const ColorScheme.light(
                                                      primary:
                                                          Color(0xFF92278F)),
                                              dialogTheme: const DialogTheme(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  18)))),
                                              buttonTheme:
                                                  const ButtonThemeData(
                                                      textTheme: ButtonTextTheme
                                                          .primary),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      _dateTime = datePicker!;
                                      setState(() {
                                        depDate = DateFormat('dd MMM')
                                            .format(_dateTime);

                                        //if the time needed to be like 2015-08-10T00:00:00 , with 00:00:00 as constant . use below code
                                        //departureDate = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss').format(DateTime(_dateTime.year, _dateTime.month, _dateTime.day)).toString();

                                        departureDate =
                                            DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                .format(_dateTime)
                                                .toString();

                                        retDate = DateFormat('dd MMM')
                                            .format(_dateTime);

                                        returnDate =
                                            DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                .format(_dateTime)
                                                .toString();

                                        //
                                        // DateFormat(
                                        //         'dd MMM')
                                        //     .format(
                                        //         _dateTime)
                                        //     .toString();
                                      });
                                    },
                                    child: Container(
                                      height: 45,
                                      width: screenSize.width / 2.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(0x0d000000),
                                          width: 1,
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFFFFFFFF)
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 10),
                                            child: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Color(0xA5000000),
                                              size: 18,
                                            ),
                                          ),
                                          Text(
                                            depDate,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xA5000000),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10, top: 8),
                              child: Text(
                                "Passengers",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF900082),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const PassengerSelectionPage());
                              },
                              child: Container(
                                height: 45,
                                width: screenSize.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0x0d000000),
                                    width: 1,
                                  ),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFFFFFF)
                                    ],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 10),
                                      child: Icon(
                                        Icons.people_outline,
                                        color: Color(0xA5000000),
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      "${noOfAdult + noOfChild + noOfInfant}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xA5000000),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10, top: 8),
                              child: Text(
                                "Cabin Class",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF900082),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const PassengerSelectionPage());
                              },
                              child: Container(
                                height: 45,
                                width: screenSize.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0x0d000000),
                                    width: 1,
                                  ),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFFFFFF)
                                    ],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 10),
                                      child: Icon(
                                        Icons.event_seat_outlined,
                                        color: Color(0xA5000000),
                                        size: 18,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        planeClassName,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xA5000000),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFE9D4E9),
                          offset: Offset(0, 3),
                          blurRadius: 5.0,
                          spreadRadius: 0,
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
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print(originCode);
                          print(destinationCode);
                          print(departureDate);
                          print(returnDate);
                        }
                        Get.to(() => const FlightSearch());
                      },
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const StadiumBorder(),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.search,
                              color: Color(0xFFFFFFFF),
                              size: 18,
                            ),
                          ),
                          Text(
                            "Search Flight",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Metropolis',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Column hotelCard(Size screenSize, BuildContext context, String orientation) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0x1f000000),
              width: 1,
            ),
            gradient: const LinearGradient(
              colors: [Color(0xFFF6F6FF), Color(0xFFF6F6FF)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xd1d19cd1),
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  4,
                ),
              )
            ],
            //color: Colors.blue,
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 8),
                    child: Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF900082),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const HotelPlacesPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0x0d000000),
                            width: 1,
                          ),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 5, right: 10),
                              child: Icon(
                                Icons.place_outlined,
                                color: Color(0xA5000000),
                                size: 18,
                              ),
                            ),
                            Text(
                              city == "" ? "Place, Country" : "$city,$country",
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xA5000000),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            "Check In",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF900082),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _restorableDateRangePickerRouteFuture.present();
                          },
                          child: Container(
                            height: 45,
                            width: screenSize.width / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0x0d000000),
                                width: 1,
                              ),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                              ),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5, right: 10),
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Color(0xA5000000),
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  inDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xA5000000),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            "Check Out",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF900082),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _restorableDateRangePickerRouteFuture.present();
                          },
                          child: Container(
                            height: 45,
                            width: screenSize.width / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0x0d000000),
                                width: 1,
                              ),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                              ),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5, right: 10),
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Color(0xA5000000),
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  outDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xA5000000),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            "Guests",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF900082),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const RoomSelectionPage(
                              page: "home",
                            ));
                          },
                          child: Container(
                            height: 45,
                            width: screenSize.width / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0x0d000000),
                                width: 1,
                              ),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                              ),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5, right: 10),
                                  child: Icon(
                                    Icons.people_outline,
                                    color: Color(0xA5000000),
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  "$GuestCount",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xA5000000),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            "Rooms",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF900082),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const RoomSelectionPage(
                              page: "home",
                            ));
                          },
                          child: Container(
                            height: 45,
                            width: screenSize.width / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0x0d000000),
                                width: 1,
                              ),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                              ),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5, right: 10),
                                  child: Icon(
                                    Icons.meeting_room_outlined,
                                    color: Color(0xA5000000),
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  "$room",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xA5000000),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFE9D4E9),
                          offset: Offset(0, 3),
                          blurRadius: 5.0,
                          spreadRadius: 0,
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
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (city == "") {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              icon: SizedBox(
                                height: 100,
                                child: Lottie.asset(
                                    'assets/lottie/warning.json',
                                    fit: BoxFit.contain),
                              ),
                              title: Text(
                                "Select a destination",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 20
                                        : screenSize.height / 20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          side: const BorderSide(
                                            color: Color(0xff92278f),
                                            width: 1.0,
                                          ),
                                        ),
                                        backgroundColor:
                                            const Color(0xff92278f),
                                      ),
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontFamily: 'Metropolis',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          Get.to(() => SearchResult(
                              cityId: cityId,
                              countryCode: countryCode,
                              night: night,
                              checkinDate: chechinDate,
                              checkoutDate: checkOutDate,
                              inDate: passDate1,
                              outdate: passDate2,
                              city: city,
                              restorationId: 'main'));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const StadiumBorder(),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.search,
                              color: Color(0xFFFFFFFF),
                              size: 18,
                            ),
                          ),
                          Text(
                            "Search Hotel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Metropolis',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Column popularPlaces() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Places",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const Divider(
          height: 20,
          indent: 10,
          endIndent: 10,
          color: Colors.black54,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotDestination.length,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 10 : 0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => SearchResult(
                              cityId: hotDestination[index]['cityId'],
                              countryCode: 'IN',
                              night: night,
                              checkinDate: chechinDate,
                              checkoutDate: checkOutDate,
                              inDate: passDate1,
                              outdate: passDate2,
                              city: hotDestination[index]['placeName'],
                              restorationId: 'main'));
                        },
                        child: hotDestinationCard(
                            hotDestination[index]['imagePath']!,
                            hotDestination[index]['placeName']!,
                            hotDestination[index]['placeCount']!,
                            hotDestination[index]['cityId']!,
                            context),
                      ),
                    )),
          ),
        ),
      ],
    );
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.get('name').toString();
    });
  }
}
