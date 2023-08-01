import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../db/Hotel/BlockRoom.dart';
import '../../../db/Hotel/hotelRoomDetails_model.dart';
import '../../../db/api.dart';
import '../../../login/login_page.dart';
import '../../global.dart';
import '../dashboard.dart';
import 'bookRoomDetailsPage.dart';
import 'models/bookRoomModel.dart';

class BookRoomSelection extends StatefulWidget {
  const BookRoomSelection(
      {Key? key,
      this.hotelCode,
      this.resultIndex,
      this.traceId,
      this.tokenId,
      this.hotelName,
      this.night,
      this.checkin,
      this.checkout,
      this.categoryId,
      this.Datein,
      this.Dateout})
      : super(key: key);
  final hotelCode;
  final resultIndex;
  final traceId;
  final tokenId;
  final hotelName;
  final night;
  final checkin;
  final checkout;
  final categoryId;
  final Datein;
  final Dateout;

  @override
  State<BookRoomSelection> createState() => _BookRoomSelectionState();
}

List<HotelRoomsDetail> hotelRoomDetails = [];
List roomCombinationsArray = [];
List details = [];
List selectedRooms = [];
double price = 0;
double tax = 0;
double offeredPrice = 0;
double cancelAmount = 0;

bool isload = true;

var name;
var email;
var loginMethod;

bool passport = false;
bool pan = true;

class _BookRoomSelectionState extends State<BookRoomSelection> {
  // late BlockRoomModel blockRoomModel = BlockRoomModel(widget.resultIndex, widget.hotelCode, widget.hotelName, '', '', 0, '', '', '', widget.tokenId, widget.traceId, []);
  bool btnVisible = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // print('refresher loading...');
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      isload = true;
      details.clear();
      price = 0;
      offeredPrice = 0;
      tax = 0;
      hotelRoomDetail.clear();
      hotelRoomDetail1.clear();
      // hotelRoomDetail2.clear();
      active.clear();
      GetRooms();
      getData();
    });
    await Future.delayed(Duration(milliseconds: 1000));
    // print('refreshed');
    setState(() {});

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isload = true;
    });

    details.clear();
    price = 0;
    offeredPrice = 0;
    tax = 0;
    hotelRoomDetail.clear();
    hotelRoomDetail1.clear();
    // hotelRoomDetail2.clear();
    active.clear();
    hotelRoomDetail.clear();
    hotelRoomDetail1.clear();
    // hotelRoomDetail2.clear();

    // print('init page');
    GetRooms();
    getData();
  }

  Set active = {};

  void _handleTap(index) {
    setState(() {
      active.contains(index) ? active.remove(index) : active.add(index);
      // print("................");
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return isload
        ? Scaffold(
            body: Center(
              child: Container(
                  child: Lottie.asset('assets/lottie/loading.json',
                      fit: BoxFit.contain)),
            ),
          )
        : Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: btnVisible
                ? hotelRoomDetails.isEmpty
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isload = true;
                            });
                            Get.back();
                            details.clear();
                            price = 0;
                            offeredPrice = 0;
                            hotelRoomDetail.clear();
                            hotelRoomDetail1.clear();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.black,
                          ),
                          //Icon(Icons.arrow_back,size: 30,color: Colors.black,),
                        ),
                      )
                : null,
            bottomNavigationBar: hotelRoomDetails.isEmpty
                ? null
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                      fontFamily: "Metropolis",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width: 140,
                                  child: Text(
                                    "₹${(price + tax).toStringAsFixed(2)}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: "Metropolis",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff92278f)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE9D4E9),
                                offset: Offset(2, 3),
                                blurRadius: 5.0,
                                spreadRadius: 2,
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
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // print('reserve now');
                              active.length > StoredGuest.length ||
                                      active.length < StoredGuest.length
                                  ? showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        icon: Container(
                                          height: 100,
                                          child: Lottie.asset(
                                              'assets/lottie/warning.json',
                                              fit: BoxFit.contain),
                                        ),
                                        title: Text(
                                          "Room Mismatch",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Metropolis',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          "No of rooms you selected is different from your search.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Metropolis',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () => Get.back(),
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Color(0xffffffff),
                                                      fontFamily: 'Metropolis',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    side: BorderSide(
                                                      color: Color(0xff92278f),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Color(0xff92278f),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  : reserveRooms();
                              //reserveRooms();
                              // apiCall();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 20.0),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              "Reserve Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Metropolis',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            body: SafeArea(
              child: hotelRoomDetails.isEmpty
                  ? Center(
                      child: Container(
                          child: Lottie.asset('assets/lottie/loading.json',
                              fit: BoxFit.contain)),
                    )
                  : SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      enablePullDown: true,
                      enablePullUp: false,
                      header: WaterDropHeader(
                        waterDropColor: Colors.purple,
                      ),
                      child: NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          if (notification.direction ==
                              ScrollDirection.forward) {
                            if (!btnVisible) setState(() => btnVisible = true);
                          } else if (notification.direction ==
                              ScrollDirection.reverse) {
                            if (btnVisible) setState(() => btnVisible = false);
                          }
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Choose your room",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    ListView.separated(
                                      shrinkWrap: true,
                                      reverse: false,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: hotelRoomDetails.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "${hotelRoomDetails[index].roomTypeName}",
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.purple),
                                                      ),
                                                    ),
                                                    // Icon(Icons.info_outline,size: 30,color: Colors.purple,),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .meeting_room_outlined,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Html(
                                                          data: hotelRoomDetails[
                                                                  index]
                                                              .roomDescription),
                                                      // Text(
                                                      //   "${hotelRoomDetails[index].roomDescription}",
                                                      //   maxLines: 3,
                                                      //   style: TextStyle(
                                                      //     fontSize: 14,
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                ListView.builder(
                                                  itemCount:
                                                      hotelRoomDetails[index]
                                                          .amenities!
                                                          .length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (BuildContext ctxt,
                                                          int Index) {
                                                    return Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            size: 18,
                                                            color: Colors.green,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "${hotelRoomDetails[index].amenities![Index]}",
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.book_outlined,
                                                          size: 18),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        hotelRoomDetails[index]
                                                                    .isPassportMandatory ==
                                                                true
                                                            ? "Passport needed"
                                                            : "No passport needed",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.credit_card,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        hotelRoomDetails[index]
                                                                    .isPanMandatory ==
                                                                true
                                                            ? "Pan-Card needed"
                                                            : "No pan-card needed",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                                      Icons.access_time,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "Last Cancellation date: ${hotelRoomDetails[index].lastCancellationDate}",
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
                                                    showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Wrap(
                                                            children: <Widget>[
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
                                                                      itemCount: hotelRoomDetails[index].cancellationPolicies!.length,
                                                                      shrinkWrap: true,
                                                                      physics: NeverScrollableScrollPhysics(),
                                                                      itemBuilder: (BuildContext ctxt, int Index) {
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
                                                                                    size: 14,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    "Charge: ${hotelRoomDetails[index].cancellationPolicies![Index].charge}",
                                                                                    maxLines: 2,
                                                                                    //  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              // Row(
                                                                              //   children: [
                                                                              //     Icon(Icons.circle,size: 18,),
                                                                              //     SizedBox(width: 10,),
                                                                              //     Text(
                                                                              //       "Charge Type: ${hotelRoomDetails[index].cancellationPolicies![Index].chargeType}",
                                                                              //       maxLines: 2,
                                                                              //       style: TextStyle(
                                                                              //           fontSize: 14,
                                                                              //           fontWeight: FontWeight.w600,
                                                                              //           color: Colors.green
                                                                              //       ),
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                              // SizedBox(height: 5,),
                                                                              // Row(
                                                                              //   children: [
                                                                              //     Icon(Icons.circle,size: 18,),
                                                                              //     SizedBox(width: 10,),
                                                                              //     Text(
                                                                              //       "Currency: ${hotelRoomDetails[index].cancellationPolicies![Index].currency}",
                                                                              //       maxLines: 2,
                                                                              //       style: TextStyle(
                                                                              //           fontSize: 14,
                                                                              //           fontWeight: FontWeight.w600,
                                                                              //           color: Colors.green
                                                                              //       ),
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.circle_outlined,
                                                                                    size: 14,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    "From: ${hotelRoomDetails[index].cancellationPolicies![Index].fromDate}",
                                                                                    maxLines: 2,
                                                                                    //  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
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
                                                                                    size: 14,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    "To: ${hotelRoomDetails[index].cancellationPolicies![Index].toDate}",
                                                                                    maxLines: 2,
                                                                                    // style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
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
                                                        size: 16,
                                                        // color: Colors.green,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Html(
                                                            data: hotelRoomDetails[
                                                                    index]
                                                                .cancellationPolicy),
                                                        // Text(
                                                        //   "${hotelRoomDetails[index].cancellationPolicy!.replaceAll("#^#", '.\n').replaceAll("|#!#", '')}",
                                                        //   maxLines: 6,
                                                        //   style: TextStyle(
                                                        //       fontSize: 14,
                                                        //       color:
                                                        //           Colors.green,
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
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "${hotelRoomDetails[index].smokingPreference}",
                                                      style: TextStyle(
                                                        fontSize: 14,
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
                                                    Text(
                                                      "Price for 1 night",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        // print(hotelRoomDetails[index].price!.roomPrice);
                                                        // print(selectedRooms);
                                                        // print(selectedRooms.length);
                                                        // print('///////////////////////////////');
                                                        // print(details);
                                                        // print(details.length);
                                                      },
                                                      child: Text(
                                                        "Rs. ${hotelRoomDetails[index].price!.roomPrice.toStringAsFixed(2)}",
                                                        style: TextStyle(
                                                            fontSize: 14,
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
                                                                    .all(10.0),
                                                                child: Wrap(
                                                                  children: <Widget>[
                                                                    Center(
                                                                        child: Container(
                                                                            height:
                                                                                4.0,
                                                                            width:
                                                                                50.0,
                                                                            color:
                                                                                Color(0xFF32335C))),
                                                                    SizedBox(
                                                                      height:
                                                                          10.0,
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        ListView.builder(
                                                                            itemCount: hotelRoomDetails[index].cancellationPolicies!.length,
                                                                            shrinkWrap: true,
                                                                            physics: NeverScrollableScrollPhysics(),
                                                                            itemBuilder: (BuildContext ctxt, int Index) {
                                                                              return Container(
                                                                                padding: EdgeInsets.only(bottom: 10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.circle,
                                                                                          size: 16,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Text(
                                                                                          "Room price: Rs. ${hotelRoomDetails[index].price!.roomPrice.toStringAsFixed(2)}",
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.circle,
                                                                                          size: 16,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Text(
                                                                                          "Taxable amount: Rs. ${hotelRoomDetails[index].price!.gst!.taxableAmount.toStringAsFixed(2)}",
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.circle,
                                                                                          size: 16,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Text(
                                                                                          "Other Charges: Rs. ${hotelRoomDetails[index].price!.otherCharges.toStringAsFixed(2)}",
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.circle,
                                                                                          size: 16,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Text(
                                                                                          "Total GST amount: Rs. ${hotelRoomDetails[index].price!.totalGstAmount.toStringAsFixed(2)}",
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
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
                                                        child: Icon(
                                                          Icons.info_outlined,
                                                          size: 16,
                                                        ))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "+ Rs. ${hotelRoomDetails[index].price!.otherCharges.toStringAsFixed(2)} taxes and charges",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  width: double.infinity,
                                                  height: 50,
                                                  child: hotelRoomDetails[index]
                                                              .availabilityType ==
                                                          "Confirm"
                                                      ? OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor: active
                                                                    .contains(
                                                                        index)
                                                                ? Colors
                                                                    .purple[300]
                                                                : Colors.white,
                                                            side: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .purple),
                                                          ),
                                                          onPressed: () {
                                                            late int smoking;
                                                            if (hotelRoomDetails[
                                                                        index]
                                                                    .smokingPreference ==
                                                                'NoPreference') {
                                                              setState(() {
                                                                smoking = 0;
                                                              });
                                                            } else if (hotelRoomDetails[
                                                                        index]
                                                                    .smokingPreference ==
                                                                'Smoking') {
                                                              setState(() {
                                                                smoking = 1;
                                                              });
                                                            } else if (hotelRoomDetails[
                                                                        index]
                                                                    .smokingPreference ==
                                                                'NonSmoking') {
                                                              setState(() {
                                                                smoking = 2;
                                                              });
                                                            } else if (hotelRoomDetails[
                                                                        index]
                                                                    .smokingPreference ==
                                                                'Either') {
                                                              setState(() {
                                                                smoking = 3;
                                                              });
                                                            }

                                                            setState(() {
                                                              List detail = [
                                                                {
                                                                  "RoomIndex":
                                                                      hotelRoomDetails[
                                                                              index]
                                                                          .roomIndex,
                                                                  "RoomTypeCode":
                                                                      "${hotelRoomDetails[index].roomTypeCode}",
                                                                  "RoomTypeName":
                                                                      "${hotelRoomDetails[index].roomTypeName}",
                                                                  "RatePlanCode":
                                                                      "${hotelRoomDetails[index].ratePlanCode}",
                                                                  "BedTypeCode":
                                                                      null,
                                                                  "SmokingPreference":
                                                                      smoking,
                                                                  "Supplements":
                                                                      null,
                                                                  "Price": {
                                                                    "CurrencyCode":
                                                                        "${hotelRoomDetails[index].price!.currencyCode}",
                                                                    "RoomPrice": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .roomPrice,
                                                                    "Tax": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .tax,
                                                                    "ExtraGuestCharge": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .extraGuestCharge,
                                                                    "ChildCharge": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .childCharge,
                                                                    "OtherCharges": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .otherCharges,
                                                                    "Discount": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .discount,
                                                                    "PublishedPrice": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .publishedPrice,
                                                                    "PublishedPriceRoundedOff": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .publishedPriceRoundedOff,
                                                                    "OfferedPrice": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .offeredPrice,
                                                                    "OfferedPriceRoundedOff": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .offeredPriceRoundedOff,
                                                                    "AgentCommission": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .agentCommission,
                                                                    "AgentMarkUp": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .agentMarkUp,
                                                                    "ServiceTax": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .serviceTax,
                                                                    "TCS": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .tcs,
                                                                    "TDS": hotelRoomDetails[
                                                                            index]
                                                                        .price!
                                                                        .tds
                                                                  }
                                                                }
                                                              ];

                                                              // print(hotelRoomDetails.length);

                                                              // hotelRoomDetails[
                                                              //                 index]
                                                              //             .isPassportMandatory ==
                                                              //         true
                                                              //     ? passport =
                                                              //         true
                                                              //     : passport = false;
                                                              passport =
                                                                  hotelRoomDetails[
                                                                          index]
                                                                      .isPassportMandatory!;
                                                              pan = hotelRoomDetails[
                                                                      index]
                                                                  .isPanMandatory!;
                                                              // hotelRoomDetails[
                                                              //                 index]
                                                              //             .isPanMandatory ==
                                                              //         true
                                                              //     ? pan = true
                                                              //     : pan = false;

                                                              print(
                                                                  "pan: $pan");

                                                              print(
                                                                  "pan: ${hotelRoomDetails[index].isPanMandatory}");

                                                              print(
                                                                  "passport: $passport");

                                                              active.contains(
                                                                      index)
                                                                  ? details.remove(
                                                                      selectedRooms[0]
                                                                              [
                                                                              'HotelRoomsDetails']
                                                                          [0])
                                                                  : details.add(
                                                                      detail[
                                                                          0]);
                                                              active.contains(
                                                                      index)
                                                                  ? print(
                                                                      'removed')
                                                                  : print(
                                                                      'added');
                                                              // print(detail.length);

                                                              selectedRooms = [
                                                                {
                                                                  "ResultIndex":
                                                                      widget
                                                                          .resultIndex,
                                                                  "HotelCode":
                                                                      "${widget.hotelCode}",
                                                                  "HotelName":
                                                                      "${widget.hotelName}",
                                                                  "GuestNationality":
                                                                      "IN",
                                                                  "NoOfRooms":
                                                                      "", //storedGuest.length,
                                                                  "ClientReferenceNo":
                                                                      0,
                                                                  "IsVoucherBooking":
                                                                      "true",
                                                                  "CategoryId":
                                                                      "${hotelRoomDetails[index].categoryId}",
                                                                  "EndUserIp":
                                                                      "$ip",
                                                                  "TokenId":
                                                                      "${widget.tokenId}",
                                                                  "TraceId":
                                                                      "${widget.traceId}",
                                                                  "HotelRoomsDetails":
                                                                      details
                                                                }
                                                              ];
                                                              _handleTap(index);

                                                              // print(active);
                                                              // print(active.contains(index));
                                                              // print(selectedRooms[0]['HotelRoomsDetails']);
                                                              // print("*************");
                                                              // print(selectedRooms);
                                                              // print(selectedRooms.length);
                                                              // print('///////////////////////////////');
                                                              // print(details);
                                                              // print(details.length);
                                                              // roo1 = selectedRooms.toJSON();
                                                              // roo2 = details.toJSON();

                                                              double
                                                                  roomofferedPrice =
                                                                  hotelRoomDetails[
                                                                          index]
                                                                      .price!
                                                                      .offeredPrice;

                                                              double roomprice =
                                                                  hotelRoomDetails[
                                                                          index]
                                                                      .price!
                                                                      .roomPrice;
                                                              active.contains(
                                                                      index)
                                                                  ? price = (price +
                                                                      roomprice)
                                                                  : price = (price -
                                                                      roomprice);
                                                              active.length == 0
                                                                  ? price = 0
                                                                  : null;

                                                              active.contains(
                                                                      index)
                                                                  ? offeredPrice =
                                                                      (offeredPrice +
                                                                          roomofferedPrice)
                                                                  : offeredPrice =
                                                                      (offeredPrice -
                                                                          roomofferedPrice);
                                                              active.length == 0
                                                                  ? offeredPrice =
                                                                      0
                                                                  : null;

                                                              double roomTax =
                                                                  hotelRoomDetails[
                                                                          index]
                                                                      .price!
                                                                      .otherCharges;
                                                              active.contains(
                                                                      index)
                                                                  ? tax = (tax +
                                                                      roomTax)
                                                                  : tax = (tax -
                                                                      roomTax);
                                                              active.length == 0
                                                                  ? tax = 0
                                                                  : null;
                                                              // print(price);
                                                              dynamic
                                                                  canecllationCharge =
                                                                  hotelRoomDetails[
                                                                          index]
                                                                      .cancellationPolicies![
                                                                          0]
                                                                      .charge;
                                                              active.contains(
                                                                      index)
                                                                  ? cancelAmount =
                                                                      (cancelAmount +
                                                                          canecllationCharge)
                                                                  : cancelAmount =
                                                                      (cancelAmount -
                                                                          canecllationCharge);
                                                              active.length == 0
                                                                  ? cancelAmount =
                                                                      0
                                                                  : null;
                                                            });
                                                          },
                                                          child: Text(
                                                            active.contains(
                                                                    index)
                                                                ? "Selected"
                                                                : "SELECT",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: active
                                                                        .contains(
                                                                            index)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .purple),
                                                          ))
                                                      : OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            side: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          onPressed: null,
                                                          child: Text(
                                                            "NOT-Available",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                ),
                                                SizedBox(
                                                  height: 10,
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
                                    // SizedBox(height: 20,),
                                    // SelectableText(bod),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          );
  }

  void GetRooms() async {
    setState(() {
      details.clear();
      price = 0;
      offeredPrice = 0;
      tax = 0;
      hotelRoomDetail.clear();
      hotelRoomDetail1.clear();
      // hotelRoomDetail2.clear();
      active.clear();
      print('cleared');
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse(api + 'api/hotels/hotel-room'),
      body: jsonEncode({
        "HotelCode": widget.hotelCode,
        "ResultIndex": widget.resultIndex,
        "TraceId": widget.traceId,
        "TokenId": widget.tokenId,
        "EndUserIp": "$ips",
        // "CategoryId": widget.categoryIndex
      }),
      headers: {"content-type": "application/json"},
    );
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
            child: Lottie.asset('assets/lottie/500.json', fit: BoxFit.contain),
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

    final result = hotelRoomsFromJson(response.body);

    // print("result : ${result.getHotelRoomResult}");

    if (response.statusCode == 200) {
      setState(() {
        isload = false;
        hotelRoomDetails = result.getHotelRoomResult.hotelRoomsDetails!;
        roomCombinationsArray =
            result.getHotelRoomResult.roomCombinationsArray!;
        ip = ips!;
        // roo = hotelRoomDetails.toJSON();
        // bod = response.body;
      });
      // print(hotelRoomDetails.length);
      // print(hotelRoomDetails.toJSON());
      // print(roomCombinationsArray.length);
      // print(roomCombinationsArray.toJSON());

      if (response.body.contains('Your session (TraceId) is expired')) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Your session is expired!'),
            content: const Text('Restart from beginning'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.to(Dashboard()),
                child: const Text('Go Home'),
              ),
            ],
          ),
        );
      } else if (result.getHotelRoomResult.error!.errorCode == 3) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('${result.getHotelRoomResult.error!.errorCode}'),
            content: Text('${result.getHotelRoomResult.error!.errorMessage}'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.to(Dashboard()),
                child: Text('Go Home'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      }
    }
  }

  // checkLogin() {
  //   loginMethod == null || loginMethod == 'guest'
  //       ? showDialog<String>(
  //           context: context,
  //           builder: (BuildContext context) => AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //             icon: Container(
  //               height: 100,
  //               child: Lottie.asset('assets/lottie/info.json',
  //                   fit: BoxFit.contain),
  //             ),
  //             title: Text(
  //               "Login to continue",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontFamily: 'Metropolis',
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //             content: Text(
  //               "Login or Create an account to book rooms.\nGet more features and access our exclusive deals and offers.",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                   fontSize: 14,
  //                   fontFamily: 'Metropolis',
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.w500),
  //             ),
  //             actions: <Widget>[
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () => Get.back(),
  //                     child: const Text(
  //                       'Cancel',
  //                       style: TextStyle(
  //                           color: Color(0xff92278f),
  //                           fontFamily: 'Metropolis',
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     style: OutlinedButton.styleFrom(
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(16),
  //                         side: BorderSide(
  //                           color: Color(0xff92278f),
  //                           width: 1.0,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () => Get.to(() => LoginPage(
  //                           page: 'room',
  //                         )),
  //                     child: const Text(
  //                       'Login',
  //                       style: TextStyle(
  //                           color: Color(0xffffffff),
  //                           fontFamily: 'Metropolis',
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     style: OutlinedButton.styleFrom(
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(16),
  //                         side: BorderSide(
  //                           color: Color(0xff92278f),
  //                           width: 1.0,
  //                         ),
  //                       ),
  //                       backgroundColor: Color(0xff92278f),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         )
  //       : reserveRooms();
  // }

  void reserveRooms() async {
    setState(() {
      isload = true;
      hotelRoomDetail = details;
      hotelRoomDetail1 = hotelRoomDetail;
      // hotelRoomDetail2 = hotelRoomDetail;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse(api + 'api/hotels/block-room'),
      body: jsonEncode({
        "ResultIndex": widget.resultIndex,
        "HotelCode": "${widget.hotelCode}",
        "HotelName": "${widget.hotelName}",
        "GuestNationality": "IN",
        "NoOfRooms": StoredGuest.length,
        "ClientReferenceNo": 0,
        "IsVoucherBooking": "true",
        "CategoryId": "${hotelRoomDetails[0].categoryId}",
        "EndUserIp": "$ips",
        "TokenId": "${widget.tokenId}",
        "TraceId": "${widget.traceId}",
        "HotelRoomsDetails": details
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);
    final result = blockRoomFromJson(response.body);
    if (response.statusCode == 500) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: Container(
            height: 100,
            child: Lottie.asset('assets/lottie/500.json', fit: BoxFit.contain),
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
      setState(() {
        isload = false;
      });

      if (result.blockRoomResult!.error!.errorCode != 0) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
                'Error code : ${result.blockRoomResult!.error!.errorCode}'),
            content: Text(
                'Message : \n\n${result.blockRoomResult!.error!.errorMessage}'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.to(Dashboard()),
                child: Text('Go Home'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      } else {
        Get.to(RoomBookPage(
          loginMethod: loginMethod,
          noOfRooms: StoredGuest.length,
          hotelName: widget.hotelName,
          hotelCode: widget.hotelCode,
          resultIndex: widget.resultIndex,
          tokenId: widget.tokenId,
          traceId: widget.traceId,
          hotelRoomDetails: details,
          night: widget.night,
          checkin: widget.checkin,
          checkout: widget.checkout,
          categoryId: widget.categoryId,
          price: price + tax,
          offeredPrice: offeredPrice,
          Datein: widget.Datein,
          Dateout: widget.Dateout,
          cancellationCharge: cancelAmount,
          passport: passport,
          pan: pan,
          IsPackageFare: result.blockRoomResult!.isPackageFare,
          IsPackagePakageDetails:
              result.blockRoomResult!.isPackageDetailsMandatory,
        ));
      }
    } else {
      print(response.statusCode);
      setState(() {
        isload = false;
      });
    }
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.get('name').toString();
      email = prefs.get('email').toString();
      loginMethod = prefs.get('login');
    });
  }
}
