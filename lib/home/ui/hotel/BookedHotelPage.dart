import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/Hotel/HotelCancellation.dart';
import '../../../db/Hotel/bookedHotelDetails.dart';
import '../../../db/api.dart';
import 'package:http/http.dart' as http;

import '../dashboard.dart';
import 'map.dart';

class BookedHotelDetailsPage extends StatefulWidget {
  const BookedHotelDetailsPage({
    Key? key,
    this.BookingId,
    this.cancellationCharge,
    this.payId,
    this.Bookedprice,
    this.img,
    this.status,
    this.city,
    this.page,
    this.changerequestid,
    this.refund,
  }) : super(key: key);
  final BookingId;
  final cancellationCharge;
  final payId;
  final Bookedprice;
  final img;
  final status;
  final city;
  final page;
  final changerequestid;
  final refund;

  @override
  State<BookedHotelDetailsPage> createState() => _BookedHotelDetailsPageState();
}

class _BookedHotelDetailsPageState extends State<BookedHotelDetailsPage> {
  List<HotelRoomsDetail> bookedRoomDetails = [];
  var HotelBookingStatus = "";
  var ConfirmationNo = "";
  var BookingId = "";
  var BookingDate = "";
  var CheckinDate = "";
  var CheckoutDate = "";
  var LastCancellationDate = "";
  var Latitude = "";
  var Longitude = "";
  var HotelName = "";
  var Address = "";
  var Contact = "";
  var HotelPolicyDetail = "";
  var NoOfRooms = "";
  var starRating = 0;

  var sts = 0;
  bool loading = true;
  bool clickCancel = false;

  @override
  void initState() {
    super.initState();
    getBookingDetails();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime pre_backpress = DateTime.now();

  Future<bool> _onWillPop(BuildContext context) async {
    final timegap = DateTime.now().difference(pre_backpress);

    final cantExit = timegap >= Duration(seconds: 0);

    pre_backpress = DateTime.now();

    if (cantExit) {
      //show snackbar

      Get.offAll(Dashboard());

      return false; // false will do nothing when back press
    } else {
      return false; // true will exit the app
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Stack(
        children: [
          loading
              ? Scaffold(
                  body: Center(
                    child: Container(
                        child: Lottie.asset('assets/lottie/loading.json',
                            fit: BoxFit.contain)),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFFFFF),
                          const Color(0xFFFFFFFF),
                        ],
                        begin: const FractionalOffset(1.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.purple,
                      automaticallyImplyLeading: false,
                      title: Text("Booking confirmation",style: TextStyle(color: Colors.white),),
                      leading: InkWell(
                        onTap: () {
                          Get.off(Dashboard());
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    body: SafeArea(
                        child: sts == 0
                            ? SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        HotelBookingStatus,
                                        style: TextStyle(
                                          fontSize: screenSize.width / 22,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Your Accommodation Booking",
                                        style: TextStyle(
                                            fontSize: screenSize.width / 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.circle_outlined,
                                            color: Color(0xff92278f),
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Booking Date : ",
                                            style: TextStyle(
                                              fontSize: screenSize.width / 24,
                                            ),
                                          ),
                                          Text(
                                            "$BookingDate",
                                            style: TextStyle(
                                              fontSize: screenSize.width / 26,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.circle_outlined,
                                            color: Color(0xff92278f),
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Amount paid : ",
                                            style: TextStyle(
                                              fontSize: screenSize.width / 24,
                                            ),
                                          ),
                                          Text(
                                            "₹${widget.Bookedprice}",
                                            style: TextStyle(
                                              fontSize: screenSize.width / 26,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        height: screenSize.height / 9,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            border: Border.all(
                                                color: Colors.green, width: 1)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Confirmation number:",
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 24,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SelectableText(
                                                  "$ConfirmationNo",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenSize.width / 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Booking Id:",
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 24,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "$BookingId",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenSize.width / 24,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Container(
                                              height: 160,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: SizedBox.fromSize(
                                                  size: Size.fromRadius(
                                                      8), // Image radius
                                                  child: Image.network(
                                                    widget.img,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child: CircularProgressIndicator(
                                                          value: loadingProgress.expectedTotalBytes != null
                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                      return Container(
                                                        height: 160,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          image: DecorationImage(
                                                            image: AssetImage("assets/images/no-img.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$HotelName",
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenSize.width / 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff92278f)),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      "${widget.city}",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenSize.width /
                                                                  26),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                RatingBarIndicator(
                                                  rating: starRating.toDouble(),
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 22,
                                                  direction: Axis.horizontal,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Check In : $CheckinDate",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                30,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          "Check Out : $CheckoutDate",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                30,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: Icon(
                                                        Icons
                                                            .meeting_room_outlined,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "No of rooms : $NoOfRooms",
                                                      style: TextStyle(
                                                        fontSize:
                                                            screenSize.width /
                                                                30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Stack(children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.transparent,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                'assets/images/city-map.png',
                                              ),
                                            ),
                                          ),
                                          height: screenSize.height / 6.5,
                                        ),
                                        Container(
                                          height: screenSize.height / 6.5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: Color(0xffffffff),
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .centerRight,
                                                  end: FractionalOffset.center,
                                                  colors: [
                                                    Color(0xFFFFFF)
                                                        .withOpacity(0.0),
                                                    Color(0xfff6f6f6),
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    1.0
                                                  ])),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.black,
                                                    size: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 30,
                                                              top: 5),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: ReadMoreText(
                                                          Address==null||Address==''? "No data available!" : "$Address",
                                                          trimLines: 4,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Metropolis",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: screenSize
                                                                      .width /
                                                                  26,
                                                              color:
                                                                  Colors.black),
                                                          trimMode:
                                                              TrimMode.Line,
                                                          trimCollapsedText:
                                                              ' Show more',
                                                          trimExpandedText:
                                                              '   Show less',
                                                          lessStyle: TextStyle(
                                                              fontSize: screenSize
                                                                      .width /
                                                                  26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff92278f)),
                                                          moreStyle: TextStyle(
                                                              fontSize: screenSize
                                                                      .width /
                                                                  26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff92278f)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Colors.black,
                                                    size: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 30,
                                                              top: 5),
                                                      child: ReadMoreText(
                                                        Contact == null || Contact == ''  ? "No data available!":"$Contact",
                                                        trimLines: 4,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Metropolis",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: screenSize
                                                                    .width /
                                                                26,
                                                            color:
                                                                Colors.black),
                                                        trimMode: TrimMode.Line,
                                                        trimCollapsedText:
                                                            ' Show more',
                                                        trimExpandedText:
                                                            '   Show less',
                                                        lessStyle: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                26,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff92278f)),
                                                        moreStyle: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                26,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff92278f)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Longitude == '' || Latitude == '' || Longitude == null || Latitude == null ? Container() :  Container(
                                          padding: EdgeInsets.only(
                                              top: 40, bottom: 40, right: 20),
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  // widget.longitude == ""?null:

                                                  // Get.to(LocationPage(
                                                  //   longitude:
                                                  //       double.parse(Longitude),
                                                  //   latitude:
                                                  //       double.parse(Latitude),
                                                  //   name: HotelName,
                                                  //   description: Address,
                                                  // ));

                                                  await MapLauncher.showMarker(
                                                    mapType: MapType.google,
                                                    coords: Coords(
                                                        double.parse(Latitude),
                                                        double.parse(Longitude)),
                                                    title: "$HotelName",
                                                  );
                                                },
                                                child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Image.asset(
                                                        'assets/images/icons/location.png')),
                                              ),
                                              Text(
                                                "MAP",
                                                style: TextStyle(
                                                  fontFamily: "Metropolis",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      screenSize.width / 26,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Room Details",
                                        style: TextStyle(
                                            fontSize: screenSize.width / 20,
                                            color: Color(0xff92278f),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        reverse: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: bookedRoomDetails.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black45,
                                                    offset: Offset(2, 2),
                                                    blurRadius: 5.0)
                                              ],
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.0, 1.0],
                                                colors: [
                                                  Color(0xffffffff),
                                                  Color(0xffffffff),
                                                ],
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            "${bookedRoomDetails[index].roomTypeName}",
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: screenSize
                                                                        .width /
                                                                    20,
                                                                color: Colors
                                                                    .purple),
                                                          ),
                                                        ),
                                                        // Icon(Icons.info_outline,size: 30,color: Colors.purple,),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .meeting_room_outlined,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Html(data: bookedRoomDetails[index].roomDescription),

                                                        // Text(
                                                        //   "${bookedRoomDetails[index].roomDescription}",
                                                        //   maxLines: 3,
                                                        //   style: TextStyle(
                                                        //     fontSize: screenSize
                                                        //             .width /
                                                        //         26,
                                                        //   ),
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(height: 10,),
                                                  // ListView.builder(
                                                  //   itemCount: hotelRoomDetails[index].amenities!.length,
                                                  //   shrinkWrap: true,
                                                  //   physics: NeverScrollableScrollPhysics(),
                                                  //   itemBuilder: (BuildContext ctxt, int Index) {
                                                  //     return Container(
                                                  //       padding: EdgeInsets.only(bottom: 10),
                                                  //       child: Row(
                                                  //         children: [
                                                  //           Icon(Icons.circle,size: 18,color: Colors.green,),
                                                  //           SizedBox(width: 10,),
                                                  //           Text(
                                                  //             "${hotelRoomDetails[index].amenities![Index]}",
                                                  //             maxLines: 2,
                                                  //             style: TextStyle(
                                                  //                 fontSize: screenSize.width / 26,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Colors.green
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  // ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "Last Cancellation date: ${bookedRoomDetails[index].lastCancellationDate}",
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              //color: Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet<
                                                          void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Wrap(
                                                              children: <
                                                                  Widget>[
                                                                Center(
                                                                    child: Container(
                                                                        height:
                                                                            4.0,
                                                                        width:
                                                                            50.0,
                                                                        color: Color(
                                                                            0xFF32335C))),
                                                                SizedBox(
                                                                  height: 10.0,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    ListView.builder(
                                                                        itemCount: 1,
                                                                        shrinkWrap: true,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        itemBuilder: (BuildContext ctxt, int i) {
                                                                          return Container(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 10),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.circle_outlined,
                                                                                      size: 10,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "Charge: ${bookedRoomDetails[index].cancellationPolicies![0].charge}",
                                                                                      maxLines: 2,
                                                                                      style: TextStyle(fontSize: screenSize.width / 26, fontWeight: FontWeight.w600, color: Colors.green),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.circle_outlined,
                                                                                      size: 10,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "ChargeType: ${bookedRoomDetails[index].cancellationPolicies![0].chargeType}",
                                                                                      maxLines: 2,
                                                                                      style: TextStyle(fontSize: screenSize.width / 26, fontWeight: FontWeight.w600, color: Colors.green),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.circle_outlined,
                                                                                      size: 10,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "From: ${bookedRoomDetails[index].cancellationPolicies![0].fromDate}",
                                                                                      maxLines: 2,
                                                                                      style: TextStyle(fontSize: screenSize.width / 26, fontWeight: FontWeight.w600, color: Colors.green),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.circle_outlined,
                                                                                      size: 10,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "To: ${bookedRoomDetails[index].cancellationPolicies![0].toDate}",
                                                                                      maxLines: 2,
                                                                                      style: TextStyle(fontSize: screenSize.width / 26, fontWeight: FontWeight.w600, color: Colors.green),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        })
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          size: 20,
                                                          color: Colors.green,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Flexible(
                                                          child: Html(data: bookedRoomDetails[index].cancellationPolicy),
                                                          // Text(
                                                          //   "${bookedRoomDetails[index].cancellationPolicy!.replaceAll("#^#", '.\n').replaceAll("|#!#", '')}",
                                                          //   // "Room Deluxe#^#100.00% of total amount will be charged, If cancelled between 29-Dec-2022 00:00:00 and 31-Dec-2022 23:59:59.|#!#",
                                                          //   maxLines: 6,
                                                          //   style: TextStyle(
                                                          //       fontSize: screenSize
                                                          //               .width /
                                                          //           26,
                                                          //       color: Colors
                                                          //           .green,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .w600),
                                                          // ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.smoking_rooms,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "${bookedRoomDetails[index].smokingPreference}",
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenSize.width /
                                                                  26,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    color: Colors.black45,
                                                    height: 1,
                                                    width: double.infinity,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Text(
                                                          "Rs. ${bookedRoomDetails[index].price!.roomPrice.toStringAsFixed(2)}",
                                                          style: TextStyle(
                                                              fontSize: screenSize
                                                                      .width /
                                                                  24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            showModalBottomSheet<
                                                                void>(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Container(
                                                                  margin: EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                                  child: Wrap(
                                                                    children: <
                                                                        Widget>[
                                                                      Center(
                                                                          child: Container(
                                                                              height: 4.0,
                                                                              width: 50.0,
                                                                              color: Color(0xFF32335C))),
                                                                      SizedBox(
                                                                        height:
                                                                            10.0,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "RoomPrice: ${bookedRoomDetails[index].price!.roomPrice}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "Tax: ${bookedRoomDetails[index].price!.tax}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "ExtraGuestCharge: ${bookedRoomDetails[index].price!.extraGuestCharge}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "ChildCharge: ${bookedRoomDetails[index].price!.childCharge}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "OtherCharges: ${bookedRoomDetails[index].price!.otherCharges}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "Discount: ${bookedRoomDetails[index].price!.discount}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "PublishedPrice: ${bookedRoomDetails[index].price!.publishedPrice}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "PublishedPriceRoundedOff: ${bookedRoomDetails[index].price!.publishedPriceRoundedOff}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "OfferedPrice: ${bookedRoomDetails[index].price!.offeredPrice}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "OfferedPriceRoundedOff: ${bookedRoomDetails[index].price!.offeredPriceRoundedOff}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "AgentCommission: ${bookedRoomDetails[index].price!.agentCommission}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "AgentMarkUp: ${bookedRoomDetails[index].price!.agentMarkUp}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "ServiceTax: ${bookedRoomDetails[index].price!.serviceTax}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "TCS: ${bookedRoomDetails[index].price!.tcs}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "TDS: ${bookedRoomDetails[index].price!.tds}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "ServiceCharge: ${bookedRoomDetails[index].price!.serviceCharge}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle_outlined,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "TotalGSTAmount: ${bookedRoomDetails[index].price!.totalGstAmount}",
                                                                            maxLines:
                                                                                2,
                                                                            style: TextStyle(
                                                                                fontSize: screenSize.width / 26,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons.info_outlined,
                                                            size: 20,
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Room Passengers",
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenSize.width /
                                                                22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.purple),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    reverse: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        bookedRoomDetails[index]
                                                            .hotelPassenger!
                                                            .length,
                                                    itemBuilder:
                                                        (context, indx) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black45,
                                                                offset: Offset(
                                                                    2, 2),
                                                                blurRadius: 5.0)
                                                          ],
                                                          gradient:
                                                              const LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            stops: [0.0, 1.0],
                                                            colors: [
                                                              Color(0xffffffff),
                                                              Color(0xffffffff),
                                                            ],
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  bookedRoomDetails[index]
                                                                              .hotelPassenger![indx]
                                                                              .paxType ==
                                                                          2
                                                                      ? "Child"
                                                                      : "Adult",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        screenSize.width /
                                                                            26,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "Name: ${bookedRoomDetails[index].hotelPassenger![indx].paxType == 2 ? '' : bookedRoomDetails[index].hotelPassenger![indx].title! + '.'} ${bookedRoomDetails[index].hotelPassenger![indx].firstName} ${bookedRoomDetails[index].hotelPassenger![indx].middleName == null ? '' : bookedRoomDetails[index].hotelPassenger![indx].middleName} ${bookedRoomDetails[index].hotelPassenger![indx].lastName}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      screenSize
                                                                              .width /
                                                                          26,
                                                                ),
                                                              ),
                                                              bookedRoomDetails[
                                                                              index]
                                                                          .hotelPassenger![
                                                                              indx]
                                                                          .paxType ==
                                                                      2
                                                                  ? Container()
                                                                  : SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                              bookedRoomDetails[
                                                                              index]
                                                                          .hotelPassenger![
                                                                              indx]
                                                                          .paxType ==
                                                                      2
                                                                  ? Container()
                                                                  : Text(
                                                                      "Email: ${bookedRoomDetails[index].hotelPassenger![indx].email}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            screenSize.width /
                                                                                26,
                                                                      ),
                                                                    ),
                                                              bookedRoomDetails[
                                                                              index]
                                                                          .hotelPassenger![
                                                                              indx]
                                                                          .paxType ==
                                                                      2
                                                                  ? Container()
                                                                  : SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                              bookedRoomDetails[
                                                                              index]
                                                                          .hotelPassenger![
                                                                              indx]
                                                                          .paxType ==
                                                                      2
                                                                  ? Container()
                                                                  : Text(
                                                                      "Phone: ${bookedRoomDetails[index].hotelPassenger![indx].phoneno}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            screenSize.width /
                                                                                26,
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SizedBox(
                                                        height: 10,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 30,
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "Hotel Policy Detail",
                                        style: TextStyle(
                                            fontSize: screenSize.width / 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),

                                      Html(data: HotelPolicyDetail),
                                      // ReadMoreText(
                                      //   // "$HotelPolicyDetail",
                                      //   "${HotelPolicyDetail}",
                                      //   trimLines: 15,
                                      //   style: TextStyle(
                                      //       fontFamily: "Metropolis",
                                      //       fontWeight: FontWeight.w500,
                                      //       fontSize: screenSize.width / 26,
                                      //       color: Colors.black),
                                      //   trimMode: TrimMode.Line,
                                      //   trimCollapsedText: ' Show more',
                                      //   trimExpandedText: '   Show less',
                                      //   lessStyle: TextStyle(
                                      //       fontSize: screenSize.width / 26,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Color(0xff92278f)),
                                      //   moreStyle: TextStyle(
                                      //       fontSize: screenSize.width / 26,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Color(0xff92278f)),
                                      // ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Last Cancellation Date : $LastCancellationDate",
                                        style: TextStyle(
                                            fontSize: screenSize.width / 26,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 50,
                                        child:
                                      //widget.status != 1 && clickCancel ?
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                color: widget.status == 1
                                                    ? Colors.purple
                                                    : Colors.black26,
                                                width: 2),
                                          ),
                                          onPressed: () => widget.status == 1
                                              ? showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
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
                                                          fit: BoxFit.contain),
                                                    ),
                                                    title: Text(
                                                      "Cancelling?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: orientation ==
                                                                  "portrait"
                                                              ? screenSize
                                                                      .width /
                                                                  20
                                                              : screenSize.height /
                                                                  20,
                                                          fontFamily:
                                                              'Metropolis',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: Text(
                                                      "You are about cancel the entire booking\n Cancellation charge : ${widget.cancellationCharge.toString()}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenSize.width /
                                                                  24,
                                                          fontFamily:
                                                              'Metropolis',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                                Get.back(),
                                                            child: const Text(
                                                              'Close',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff92278f),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                side:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xff92278f),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              CancelBooking();
                                                              Get.back();
                                                            },
                                                            child: const Text(
                                                              'Cancel Booking',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffffffff),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                side:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xff92278f),
                                                                  width: 1.0,
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
                                                )
                                              : null,
                                          child: Text(
                                            widget.status == 1
                                                ? "Cancel Booking"
                                                : widget.status == 2
                                                    ? "Expired" :
                                                widget.status == 4
                                                    ? "Pending"
                                                    : "Cancelled",
                                            style: TextStyle(
                                                fontSize: screenSize.width / 20,
                                                color: widget.status == 1
                                                    ? Colors.purple
                                                    : Colors.black26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        // :
                                        // OutlinedButton(
                                        //   style: OutlinedButton.styleFrom(
                                        //     side: BorderSide(
                                        //         color:  Colors.black26,
                                        //         width: 2),
                                        //   ),
                                        //   onPressed: () => null,
                                        //   child: Text( "Processing",
                                        //     style: TextStyle(
                                        //         fontSize: screenSize.width / 20,
                                        //         color:  Colors.black26,
                                        //         fontWeight: FontWeight.bold),
                                        //   ),
                                        // ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Can't Get Details",
                                  style: TextStyle(fontSize: 24),
                                ),
                              )),
                  ),
                ),
        ],
      ),
    );
  }

  getBookingDetails() async {

    try{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var ips = prefs.getString('ip');
      // print("ip : $ips");
      final response = await http.post(
        Uri.parse(api + 'api/hotels/booking-detail'),
        body: jsonEncode({
          'EndUserIp': ips,
          'BookingId': "${widget.BookingId}",
          // 'TokenId' : '${widget.TokenId}'
        }),
        headers: {"content-type": "application/json"},
      );
      // print(response.body);
      // print(response.statusCode);
      // print(response.body.contains('"Error":{"ErrorCode":2,'));
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
        if (response.body.contains('"Error":{"ErrorCode":2,')) {
          setState(() {
            sts = 2;
            loading = false;
          });
        }

        final result = bookedHotelDetailsFromJson(response.body);
        // print(result.getBookingDetailResult.error!.errorCode);
        // print("..........................................");

        // print(result.getBookingDetailResult.hotelRoomsDetails);
        bookedRoomDetails.addAll(result.getBookingDetailResult.hotelRoomsDetails);

        // String desiredFormat = dateString.substring(0, 10);

        // final xmlString = result.getBookingDetailResult.hotelPolicyDetail.toString();
        //
        // final myTransformer = Xml2Json();
        // myTransformer.parse(xmlString);
        // final json = myTransformer.toParker();
        // final data = jsonDecode(json).length;
        // print('data = ' + data);
        print('json = ' + result.getBookingDetailResult.hotelPolicyDetail!);

        setState(() {
          var checkin = result.getBookingDetailResult.checkInDate
              .toString()
              .substring(0, 10);
          var checkout = result.getBookingDetailResult.checkOutDate
              .toString()
              .substring(0, 10);
          loading = false;
          HotelBookingStatus = result.getBookingDetailResult.hotelBookingStatus!;
          ConfirmationNo = result.getBookingDetailResult.confirmationNo!;
          BookingId = result.getBookingDetailResult.bookingId.toString();
          BookingDate = result.getBookingDetailResult.bookingDate.toString();
          CheckinDate = checkin;
          CheckoutDate = checkout;
          LastCancellationDate =
              result.getBookingDetailResult.lastCancellationDate.toString();
          Latitude = result.getBookingDetailResult.latitude!;
          Longitude = result.getBookingDetailResult.longitude!;
          HotelName = result.getBookingDetailResult.hotelName!;
          Address = result.getBookingDetailResult.addressLine1!;
          Contact = result.getBookingDetailResult.addressLine2!;
          HotelPolicyDetail = result.getBookingDetailResult.hotelPolicyDetail!;
          NoOfRooms = result.getBookingDetailResult.noOfRooms.toString();
          starRating = result.getBookingDetailResult.starRating!;
        });
        if(widget.changerequestid != null){
          checkStatus();
        }
      }

    }catch(e){
      print(e);
    }

  }

  CancelBooking() async {
    try{
      loading = true;
      setState(() {
        clickCancel = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var ips = prefs.getString('ip');
      final response = await http.post(
        Uri.parse(api + 'api/hotels/change-request'),
        body: jsonEncode({
          "EndUserIp": ips,
          //"TokenId": "65046ea7-028b-412d-b74b-25c15b0954c5",
          "RequestType": 4,
          "BookingId": "${widget.BookingId}", //1782591
          "Remarks": "abcd"

          // "EndUserIp": "192.168.10.26",
          // "TokenId": "65046ea7-028b-412d-b74b-25c15b0954c5",
          // "RequestType":4,
          // "BookingId": "1782591",
          //
          // "Remarks":"..............."
        }),
        headers: {"content-type": "application/json"},
      );
      print(response.request);
      print(response.body);
      print(response.statusCode);

      final result = hotelCancellationFromJson(response.body);

      if (result!.hotelChangeRequestResult!.responseStatus == 1) {

        // refundPayment(widget.payId);
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            icon: Container(
              height: 100,
              child: Lottie.asset('assets/lottie/success1.json',
                  fit: BoxFit.contain),
            ),
            title: Text(
              "Done",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Your booking cancellation requested",
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
                      'Close',
                      style: TextStyle(
                          color: Color(0xff92278f),
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Color(0xff92278f),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        // var a = result.hotelChangeRequestResult!.changeRequestId;

        saveCancel(widget.BookingId,result.hotelChangeRequestResult!.changeRequestId,4,false);
      }

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    }catch(e){
      print(e);
    }

  }

  // refundPayment(String paymentId) async {
  //   double amount = double.parse(widget.Bookedprice.toString()) -
  //       double.parse(widget.cancellationCharge.toString());
  //   final response = await http.post(
  //     Uri.parse('${api}api/payments/refund'),
  //     body: jsonEncode(
  //         {'amount': ((amount * 100).round()).toString(), 'payId': paymentId}),
  //     headers: {"content-type": "application/json"},
  //   );
  //   print(response.request);
  //   print(response.body);
  //   print(response.statusCode);
  //   print('refund api');
  //
  //   if(response.statusCode == 200){
  //     saveCancel(widget.BookingId,widget.changerequestid,3,true);
  //   }
  //
  // }

  void saveCancel(bookingId,changeRequestId,ststus,refund) async {

    try{
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool("status", true);
      print('changeRequestId: $changeRequestId');

      final response = await http.post(
        Uri.parse(api + 'api/hotel-book/cancel'),
        body: jsonEncode({
          "bookingid": "$bookingId", //1782591
          "status": ststus,
          "changerequestid": changeRequestId,
          "refund": refund
        }),
        headers: {"content-type": "application/json"},
      );
      print(response.request);
      print(response.body);
      print(response.statusCode);

    }catch(e){
      print(e);
    }

  }


  void checkStatus() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var ips = prefs.getString('ip');
//changerequestid
      print("iddd:  ${widget.changerequestid}");
      final response = await http.post(
        Uri.parse(api + 'api/hotels/change-request-status'),
        body: jsonEncode({
          "EndUserIp": ips,
          "ChangeRequestId": "${widget.changerequestid}"
        }),
        headers: {"content-type": "application/json"},
      );
      print(response.request);
      log(response.body);
      print(response.statusCode);

      Map<String, dynamic> result = jsonDecode(response.body);

      int status = result['HotelChangeRequestStatusResult']['ChangeRequestStatus'];

      print(status);
      //ststus 1 = pending, 2 = in progress, 3 = processed, 4 = rejected

      if(status == 3){

        if(widget.refund == false){
          // refundPayment(widget.payId);

        }

      }
    }catch(e){
      print(e);
    }


  }


}
