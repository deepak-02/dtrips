import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../global.dart';
import '../../items.dart';
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
  int _currentIndex = 0;
  bool isLoading = true;
  List cardList = [
    Item1(),
    Item2(),
    Item3(),
    Item4(),
    Item5(),
    Item6(),
    Item7()
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _endDate =
      RestorableDateTimeN(DateTime.now().add(Duration(days: 1)));
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
      decoration: BoxDecoration(
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = "hotel";
                              });
                            },
                            child: Container(
                              height: 94,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border.all(
                                  color: isSelected == "hotel"
                                      ? Color(0xff92278f)
                                      : Color(0xffffffff),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected == "hotel"
                                        ? Color(0x4092278e)
                                        : Color(0xFFE9D4E9),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: Offset(
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = "flight";
                              });
                            },
                            child: Container(
                              height: 94,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                border: Border.all(
                                  color: isSelected == "flight"
                                      ? Color(0xff92278f)
                                      : Color(0xffffffff),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected == "flight"
                                        ? Color(0x4092278e)
                                        : Color(0xFFE9D4E9),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: Offset(
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
                                  Text(
                                    "Find Your Hotel",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(
                                    child: Container(
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
                                  Text(
                                    "Find Your Flight",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(
                                    child: Container(
                                        width: 130,
                                        child: Lottie.asset(
                                            'assets/lottie/flight-ticket.json',
                                            fit: BoxFit.contain)),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: AnimatedSizeAndFade(
                        fadeDuration: const Duration(milliseconds: 300),
                        sizeDuration: const Duration(milliseconds: 600),
                        child: isSelected == "hotel"
                            ?
                        hotelCard(screenSize, context, orientation)
                            : flightCard(screenSize, context),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    imageSlider(),

                    SizedBox(
                      height: 30,
                    ),

                    popularPlaces(),

                    SizedBox(
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


  Column imageSlider() {
    return Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 180,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: Duration(seconds: 5),
                          autoPlayAnimationDuration:
                          Duration(milliseconds: 800),
                          autoPlayCurve: Curves.linear,
                          pauseAutoPlayOnTouch: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: cardList.map((card) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              height: 250,
                              width: 300,
                              child: GestureDetector(
                                onTap: () {
                                  // print(_currentIndex);
                                },
                                child: Container(
                                  child: card,
                                ),
                              ),
                            );
                          });
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(cardList, (index, url) {
                            return Container(
                              width: 10.0,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Color(0xff92278f)
                                    : Colors.grey,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
  }

  Column flightCard(Size screenSize, BuildContext context) {
    return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Color(0x1f000000),
                                      width: 1,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF6F6FF),
                                        Color(0xFFF6F6FF)
                                      ],
                                    ),
                                    boxShadow: [
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                                    ? Color(0xff92278f)
                                                    : Color(0xffb2a1b8),
                                                fontWeight: FontWeight.bold),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              btn2 == "active"
                                                  ? null
                                                  : retDate = DateFormat(
                                                          'dd MMM')
                                                      .format(DateTime.parse(
                                                              departureDate)
                                                          .add(Duration(
                                                              days: 1)))
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
                                                    ? Color(0xff92278f)
                                                    : Color(0xffb2a1b8),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Color(0x1f000000),
                                      width: 1,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF6F6FF),
                                        Color(0xFFF6F6FF)
                                      ],
                                    ),
                                    boxShadow: [
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
                                      Container(
                                        //color: Color(0x8bffffff),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 8),
                                                    child: Text(
                                                      "Departure",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFF900082),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(AirportListPage(
                                                        type: "origin",
                                                      ));
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: double.infinity,
                                                      decoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        border: Border.all(
                                                          color: Color(
                                                              0xd000000),
                                                          width: 1,
                                                        ),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFFFFFFF),
                                                            Color(0xFFFFFFFF)
                                                          ],
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right:
                                                                        10),
                                                            child: Icon(
                                                              Icons
                                                                  .flight_land_outlined,
                                                              color: Color(
                                                                  0xA5000000),
                                                              size: 18,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${fromPort},${fromPlace}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xA5000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 8, 8, 0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          // print("swap click");
                                                          var place;
                                                          var port;
                                                          var origin;

                                                          place = toPlace;
                                                          toPlace = fromPlace;
                                                          fromPlace = place;

                                                          port = toPort;
                                                          toPort = fromPort;
                                                          fromPort = port;

                                                          origin =
                                                              originAirportCode;
                                                          originCode =
                                                              destinationCode;
                                                          destinationCode =
                                                              origin;
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 14,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        child: CircleAvatar(
                                                          radius: 13,
                                                          foregroundColor:
                                                              Colors.black,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Icon(
                                                            Icons
                                                                .swap_vert_outlined,
                                                            // size: 18,
                                                            color: Color(
                                                                0xA5000000),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Text(
                                                      "Destination",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFF900082),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(AirportListPage(
                                                        type: "destination",
                                                      ));
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: double.infinity,
                                                      decoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        border: Border.all(
                                                          color: Color(
                                                              0xd000000),
                                                          width: 1,
                                                        ),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFFFFFFF),
                                                            Color(0xFFFFFFFF)
                                                          ],
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right:
                                                                        10),
                                                            child: Icon(
                                                              Icons
                                                                  .flight_takeoff_outlined,
                                                              color: Color(
                                                                  0xA5000000),
                                                              size: 18,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${toPort},${toPlace}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xA5000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              btn2 == "active"
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10,
                                                                      top: 8),
                                                              child: Text(
                                                                "Departure Date",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14,
                                                                  color: Color(
                                                                      0xFF900082),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _restorableDateRangePickerRouteFuture
                                                                    .present();
                                                              },
                                                              child:
                                                                  Container(
                                                                height: 45,
                                                                width: screenSize
                                                                        .width /
                                                                    2.5,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          16),
                                                                  border:
                                                                      Border
                                                                          .all(
                                                                    color: Color(
                                                                        0xd000000),
                                                                    width: 1,
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFFFFFFFF),
                                                                      Color(
                                                                          0xFFFFFFFF)
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .calendar_today_outlined,
                                                                        color:
                                                                            Color(0xA5000000),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${depDate}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(0xA5000000),
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10,
                                                                      top: 8),
                                                              child: Text(
                                                                "Arrival Date",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14,
                                                                  color: Color(
                                                                      0xFF900082),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _restorableDateRangePickerRouteFuture
                                                                    .present();
                                                              },
                                                              child:
                                                                  Container(
                                                                height: 45,
                                                                width: screenSize
                                                                        .width /
                                                                    2.5,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          16),
                                                                  border:
                                                                      Border
                                                                          .all(
                                                                    color: Color(
                                                                        0xd000000),
                                                                    width: 1,
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFFFFFFFF),
                                                                      Color(
                                                                          0xFFFFFFFF)
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .calendar_today_outlined,
                                                                        color:
                                                                            Color(0xA5000000),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${retDate}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(0xA5000000),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10,
                                                                      top: 8),
                                                              child: Text(
                                                                "Departure Date",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14,
                                                                  color: Color(
                                                                      0xFF900082),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap:
                                                                  () async {
                                                                var datePicker =
                                                                    await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      initialDate,
                                                                  firstDate:
                                                                      initialDate,
                                                                  lastDate:
                                                                      DateTime(
                                                                          2099),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return Theme(
                                                                      data: ThemeData.light()
                                                                          .copyWith(
                                                                        primaryColor:
                                                                            const Color(0xFF92278F),
                                                                        // accentColor: const Color(0xFF879AE9),
                                                                        colorScheme:
                                                                            ColorScheme.light(primary: const Color(0xFF92278F)),
                                                                        dialogTheme:
                                                                            const DialogTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18)))),
                                                                        buttonTheme:
                                                                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                                                      ),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );
                                                                _dateTime =
                                                                    datePicker!;
                                                                setState(() {
                                                                  depDate = DateFormat(
                                                                          'dd MMM')
                                                                      .format(
                                                                          _dateTime);

                                                                  //if the time needed to be like 2015-08-10T00:00:00 , with 00:00:00 as constant . use below code
                                                                  //departureDate = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss').format(DateTime(_dateTime.year, _dateTime.month, _dateTime.day)).toString();

                                                                  departureDate = DateFormat(
                                                                          'yyyy-MM-ddTHH:mm:ss')
                                                                      .format(
                                                                          _dateTime)
                                                                      .toString();

                                                                  retDate = DateFormat(
                                                                          'dd MMM')
                                                                      .format(
                                                                          _dateTime);

                                                                  returnDate = DateFormat(
                                                                          'yyyy-MM-ddTHH:mm:ss')
                                                                      .format(
                                                                          _dateTime)
                                                                      .toString();

                                                                  //
                                                                  // DateFormat(
                                                                  //         'dd MMM')
                                                                  //     .format(
                                                                  //         _dateTime)
                                                                  //     .toString();
                                                                });
                                                              },
                                                              child:
                                                                  Container(
                                                                height: 45,
                                                                width: screenSize
                                                                        .width /
                                                                    2.5,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          16),
                                                                  border:
                                                                      Border
                                                                          .all(
                                                                    color: Color(
                                                                        0xd000000),
                                                                    width: 1,
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFFFFFFFF),
                                                                      Color(
                                                                          0xFFFFFFFF)
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .calendar_today_outlined,
                                                                        color:
                                                                            Color(0xA5000000),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${depDate}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(0xA5000000),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 8),
                                                        child: Text(
                                                          "Passengers",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFF900082),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              PassengerSelectionPage());
                                                        },
                                                        child: Container(
                                                          height: 45,
                                                          width: screenSize
                                                                  .width /
                                                              2.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            border:
                                                                Border.all(
                                                              color: Color(
                                                                  0xd000000),
                                                              width: 1,
                                                            ),
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0xFFFFFFFF),
                                                                Color(
                                                                    0xFFFFFFFF)
                                                              ],
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right:
                                                                        10),
                                                                child: Icon(
                                                                  Icons
                                                                      .people_outline,
                                                                  color: Color(
                                                                      0xA5000000),
                                                                  size: 18,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${noOfAdult + noOfChild + noOfInfant}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Color(
                                                                        0xA5000000),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 8),
                                                        child: Text(
                                                          "Cabin Class",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFF900082),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              PassengerSelectionPage());
                                                        },
                                                        child: Container(
                                                          height: 45,
                                                          width: screenSize
                                                                  .width /
                                                              2.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            border:
                                                                Border.all(
                                                              color: Color(
                                                                  0xd000000),
                                                              width: 1,
                                                            ),
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0xFFFFFFFF),
                                                                Color(
                                                                    0xFFFFFFFF)
                                                              ],
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right:
                                                                        10),
                                                                child: Icon(
                                                                  Icons
                                                                      .event_seat_outlined,
                                                                  color: Color(
                                                                      0xA5000000),
                                                                  size: 18,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  "$planeClassName",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xA5000000),
                                                                      fontWeight:
                                                                          FontWeight.w500),
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
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFFE9D4E9),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.0, 1.0],
                                                colors: [
                                                  Color(0xff92278f),
                                                  Color(0xff92278f),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                print(originCode);
                                                print(destinationCode);
                                                print(departureDate);
                                                print(returnDate);
                                                Get.to(() => FlightSearch());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor:
                                                    Colors.transparent,
                                                shape: StadiumBorder(),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Icon(
                                                      Icons.search,
                                                      color:
                                                          Color(0xFFFFFFFF),
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Search Flight",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'Metropolis',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
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
                                      color: Color(0x1f000000),
                                      width: 1,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF6F6FF),
                                        Color(0xFFF6F6FF)
                                      ],
                                    ),
                                    boxShadow: [
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 8),
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
                                              Get.to(HotelPlacesPage());
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 45,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16),
                                                  border: Border.all(
                                                    color: Color(0xd000000),
                                                    width: 1,
                                                  ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFFFFFFFF),
                                                      Color(0xFFFFFFFF)
                                                    ],
                                                  ),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                                  .only(
                                                              left: 5,
                                                              right: 10),
                                                      child: Icon(
                                                        Icons.place_outlined,
                                                        color:
                                                            Color(0xA5000000),
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      city == ""
                                                          ? "Place, Country"
                                                          : "$city,$country",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xA5000000),
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 8),
                                                  child: Text(
                                                    "Check In",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xFF900082),
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
                                                    width: screenSize.width /
                                                        2.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(16),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xd000000),
                                                        width: 1,
                                                      ),
                                                      gradient:
                                                          LinearGradient(
                                                        colors: [
                                                          Color(0xFFFFFFFF),
                                                          Color(0xFFFFFFFF)
                                                        ],
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 10),
                                                          child: Icon(
                                                            Icons
                                                                .calendar_today_outlined,
                                                            color: Color(
                                                                0xA5000000),
                                                            size: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${inDate}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xA5000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 8),
                                                  child: Text(
                                                    "Check Out",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xFF900082),
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
                                                    width: screenSize.width /
                                                        2.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(16),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xd000000),
                                                        width: 1,
                                                      ),
                                                      gradient:
                                                          LinearGradient(
                                                        colors: [
                                                          Color(0xFFFFFFFF),
                                                          Color(0xFFFFFFFF)
                                                        ],
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 10),
                                                          child: Icon(
                                                            Icons
                                                                .calendar_today_outlined,
                                                            color: Color(
                                                                0xA5000000),
                                                            size: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${outDate}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xA5000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 8),
                                                  child: Text(
                                                    "Guests",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xFF900082),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(RoomSelectionPage(
                                                      page: "home",
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    width: screenSize.width /
                                                        2.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(16),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xd000000),
                                                        width: 1,
                                                      ),
                                                      gradient:
                                                          LinearGradient(
                                                        colors: [
                                                          Color(0xFFFFFFFF),
                                                          Color(0xFFFFFFFF)
                                                        ],
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 10),
                                                          child: Icon(
                                                            Icons
                                                                .people_outline,
                                                            color: Color(
                                                                0xA5000000),
                                                            size: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${GuestCount}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xA5000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 8),
                                                  child: Text(
                                                    "Rooms",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xFF900082),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(RoomSelectionPage(
                                                      page: "home",
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    width: screenSize.width /
                                                        2.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(16),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xd000000),
                                                        width: 1,
                                                      ),
                                                      gradient:
                                                          LinearGradient(
                                                        colors: [
                                                          Color(0xFFFFFFFF),
                                                          Color(0xFFFFFFFF)
                                                        ],
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 10),
                                                          child: Icon(
                                                            Icons
                                                                .meeting_room_outlined,
                                                            color: Color(
                                                                0xA5000000),
                                                            size: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${room}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xA5000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFFE9D4E9),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.0, 1.0],
                                                colors: [
                                                  Color(0xff92278f),
                                                  Color(0xff92278f),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (city == "") {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0))),
                                                      icon: Container(
                                                        height: 100,
                                                        child: Lottie.asset(
                                                            'assets/lottie/warning.json',
                                                            fit: BoxFit
                                                                .contain),
                                                      ),
                                                      title: Text(
                                                        "Select a destination",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: orientation ==
                                                                    "portrait"
                                                                ? screenSize
                                                                        .width /
                                                                    20
                                                                : screenSize
                                                                        .height /
                                                                    20,
                                                            fontFamily:
                                                                'Metropolis',
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      actions: <Widget>[
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child:
                                                                  const Text(
                                                                'OK',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffffffff),
                                                                    fontFamily:
                                                                        'Metropolis',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              style: OutlinedButton
                                                                  .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          16),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xff92278f),
                                                                    width:
                                                                        1.0,
                                                                  ),
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xff92278f),
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
                                                      countryCode:
                                                          countryCode,
                                                      night: night,
                                                      checkinDate:
                                                          chechinDate,
                                                      checkoutDate:
                                                          checkOutDate,
                                                      inDate: passDate1,
                                                      outdate: passDate2,
                                                      city: city,
                                                      restorationId: 'main'));
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor:
                                                    Colors.transparent,
                                                shape: StadiumBorder(),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Icon(
                                                      Icons.search,
                                                      color:
                                                          Color(0xFFFFFFFF),
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Search Hotel",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'Metropolis',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
  }

  Column popularPlaces() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
        Divider(
          height: 20,
          indent: 10,
          endIndent: 10,
          color: Colors.black54,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotDestination.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 10 : 0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => SearchResult(
                          cityId: hotDestination[index]
                          ['cityId'],
                          countryCode: 'IN',
                          night: night,
                          checkinDate: chechinDate,
                          checkoutDate: checkOutDate,
                          inDate: passDate1,
                          outdate: passDate2,
                          city: hotDestination[index]
                          ['placeName'],
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
