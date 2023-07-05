import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/Hotel/BookingStatus.dart';
import '../../../db/api.dart';
import '../../../login/login_page.dart';
import '../hotel/BookedHotelPage.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List MyBookingsList = [];
  String? login = 'login';
  // final RefreshController _refreshController1 =RefreshController(initialRefresh: false);
  // final RefreshController _refreshController2 =RefreshController(initialRefresh: false);
  // final RefreshController _refreshController3 =RefreshController(initialRefresh: false);

  bool active = false;
  bool past = false;
  bool cancelled = false;

  // void _onLoading(int tab) async {
  //   // monitor network fetch
  //
  //   try{
  //     await Future.delayed(Duration(milliseconds: 1000));
  //     // print('refresher loading...');
  //     setState(() {
  //       MyBookingsList.clear();
  //     });
  //     // if failed,use loadFailed(),if no data return,use LoadNodata()
  //     setState(() {
  //       if(tab==1){
  //         _refreshController1.loadComplete();
  //       }
  //       if(tab == 2){
  //         _refreshController2.loadComplete();
  //       }
  //       if(tab == 3){
  //         _refreshController3.loadComplete();
  //       }
  //     });
  //
  //   }catch(e){
  //     setState(() {
  //       if(tab==1){
  //         _refreshController1.loadComplete();
  //       }
  //       if(tab == 2){
  //         _refreshController2.loadComplete();
  //       }
  //       if(tab == 3){
  //         _refreshController3.loadComplete();
  //       }
  //     });
  //
  //     print(e);
  //   }
  //
  //
  //
  // }

  void _onRefresh(int tab) async {
    try{
      await Future.delayed(Duration(milliseconds: 1000));
      setState(() {
        MyBookingsList.clear();
      });

      await getBookings(tab);

      setState(() {
      //   if(tab==1){
      //     _refreshController1.loadComplete();
      //   }
      //   if(tab == 2){
      //     _refreshController2.loadComplete();
      //   }
      //   if(tab == 3){
      //     _refreshController3.loadComplete();
      //   }
      });

    }catch(e){
      print(e);
      setState(() {
        // if(tab==1){
        //   _refreshController1.loadFailed();
        // }
        // if(tab == 2){
        //   _refreshController2.loadFailed();
        // }
        // if(tab == 3){
        //   _refreshController3.loadFailed();
        // }
      });

    }

  }

  @override
  void initState() {
    super.initState();
    getBookings(1);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            // toolbarHeight: 80,
            backgroundColor: Colors.purple,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Trips',
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
            ),
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.5),
                    indicatorColor: Colors.white,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                    labelPadding: EdgeInsets.symmetric(horizontal: 40),
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: 'Active',
                        icon: Icon(
                          Icons.check_circle_outline,
                          size: 18,
                        ),
                        height: 50,
                        // child: Text('Active'),
                      ),
                      Tab(
                        text: 'Past',
                        icon: Icon(
                          Icons.history,
                          size: 18,
                        ),
                        height: 50,
                        //  child: Text('Past'),
                      ),
                      Tab(
                        text: 'Cancelled',
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 18,
                        ),
                        height: 50,
                        // child: Text('Cancelled'),
                      ),
                    ]),
                preferredSize: Size.fromHeight(30.0)),
          ),
          body: TabBarView(
            children: <Widget>[
              //Tab 1
            RefreshIndicator(

              onRefresh: () async { _onRefresh(1); },
              child:
              MyBookingsList.isEmpty || active == false
                  ? ListView(
                    children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 50,),
                                Container(
                                    height: 300,
                                    child: Image.asset(
                                      'assets/images/travel-time.png',
                                    )),
                                SizedBox(height: 50,),
                                Text(
                                  "Revisit your favourite places",
                                  style: TextStyle(
                                    fontSize:25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Text(
                                  "Here you will see all your active trips and get inspired for your next ones.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                SizedBox(height: 50,),
                                login == 'guest' || login == null || login == ''
                                    ? ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => LoginPage(
                                              page: 'room',
                                            ));
                                      },
                                      // style: ElevatedButton.styleFrom(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 40.0,
                                      //       vertical: 20.0),
                                      //   backgroundColor:
                                      //       Colors.transparent,
                                      //   shadowColor: Colors.transparent,
                                      //   shape: StadiumBorder(),
                                      // ),
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    22,
                                            fontFamily: 'Metropolis',
                                            fontWeight:
                                                FontWeight.bold),
                                      ),
                                    )
                                    : Container(),

                              ],
                            ),
                          ),
                        ),
                      ],
                  )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: MyBookingsList.length,
                      // reverse: true,
                      itemBuilder: (BuildContext context, index) {
                        print("length: ${MyBookingsList.length}");
                        var checkInDate =
                            MyBookingsList[index].checkindate.toString();
                        var inDate = DateTime.parse(checkInDate);
                        var CheckIn =
                            DateFormat('dd MMM').format(inDate).toString();

                        var checkOutDate =
                            MyBookingsList[index].checkoutdate.toString();
                        var outDate = DateTime.parse(checkOutDate);
                        var CheckOut =
                            DateFormat('dd MMM').format(outDate).toString();

                        var BookedDate =
                            MyBookingsList[index].bookingdate.toString();
                        var BookDate = DateTime.parse(BookedDate);
                        var Booked = DateFormat('dd MMM')
                            .format(BookDate)
                            .toString();

                        return MyBookingsList[index].status == 1 || MyBookingsList[index].status == 4
                            ? GestureDetector(
                                onTap: () {
                                  print(MyBookingsList[index].changerequestid);
                                  Get.to(BookedHotelDetailsPage(
                                    BookingId:
                                        MyBookingsList[index].bookingid,
                                    payId: MyBookingsList[index].payid,
                                    cancellationCharge:
                                        MyBookingsList[index].cancelcharge,
                                    Bookedprice:
                                        MyBookingsList[index].price,
                                    img: MyBookingsList[index].image,
                                    status: MyBookingsList[index].status,
                                    city: MyBookingsList[index].city,
                                      changerequestid: MyBookingsList[index].changerequestid,
                                    refund: MyBookingsList[index].refund,
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xffffffff),
                                          Color(0xffffffff)
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFE9D4E9),
                                          blurRadius: 5.0,
                                          spreadRadius: 2,
                                          offset: Offset(
                                            2,
                                            3,
                                          ),
                                        )
                                      ],
                                      //color: Colors.blue,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(
                                                    8), // Image radius
                                                child: CachedNetworkImage(
                                                  imageUrl: MyBookingsList[index].image,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url, error) => Container(
                                                    height: 100,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      image: DecorationImage(
                                                        image: AssetImage("assets/images/no-img.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    "${MyBookingsList[index].hotelname}",
                                                    style: TextStyle(
                                                        fontSize: screenSize
                                                                .width /
                                                            24,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      '$CheckIn - $CheckOut',
                                                      style: TextStyle(
                                                        fontSize: screenSize
                                                                .width /
                                                            28,
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${MyBookingsList[index].city}',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                            color: Colors
                                                                .black54,
                                                          )),
                                                      Text(
                                                          '₹${MyBookingsList[index].price.toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color: Colors
                                                                    .purple[
                                                                400],
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          MyBookingsList[index].status == 4 ? 'Pending cancellation' :'Confirm',
                                                          style: TextStyle(
                                                              fontSize: MyBookingsList[index].status == 4 ? 12:14,
                                                              color: MyBookingsList[index].status == 4 ? Colors.orange :Colors.green[400],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          'Booked on: $Booked',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      }),
            ),

              //Tab 2
          RefreshIndicator(
            onRefresh: () async { _onRefresh(2); },
            child:
              MyBookingsList.isEmpty || past == false
                  ? ListView(
                    children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Spacer(),
                                SizedBox(height: 50,),
                                Container(
                                    height: 300,
                                    child: Image.asset(
                                      'assets/images/travel-time.png',
                                    )),
                               // Spacer(),
                                SizedBox(height: 50,),
                                Text(
                                  "Revisit your favourite places",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //Spacer(),
                                SizedBox(height: 30,),
                                Text(
                                  "Here you will see all your past trips and get inspired for your next ones.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                //Spacer(),
                                SizedBox(height: 50,),
                                login == 'guest' || login == null || login == ''
                                    ? ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => LoginPage(
                                              page: 'room',
                                            ));
                                      },
                                      // style: ElevatedButton.styleFrom(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 40.0,
                                      //       vertical: 20.0),
                                      //   backgroundColor:
                                      //       Colors.transparent,
                                      //   shadowColor: Colors.transparent,
                                      //   shape: StadiumBorder(),
                                      // ),
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    22,
                                            fontFamily: 'Metropolis',
                                            fontWeight:
                                                FontWeight.bold),
                                      ),
                                    )
                                    : Container(),
                                //Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                  )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: MyBookingsList.length,
                      // reverse: true,
                      itemBuilder: (_, index) {
                        var checkInDate =
                            MyBookingsList[index].checkindate.toString();
                        var inDate = DateTime.parse(checkInDate);
                        var CheckIn =
                            DateFormat('dd MMM').format(inDate).toString();

                        var checkOutDate =
                            MyBookingsList[index].checkoutdate.toString();
                        var outDate = DateTime.parse(checkOutDate);
                        var CheckOut =
                            DateFormat('dd MMM').format(outDate).toString();

                        var BookedDate =
                            MyBookingsList[index].bookingdate.toString();
                        var BookDate = DateTime.parse(BookedDate);
                        var Booked = DateFormat('dd MMM')
                            .format(BookDate)
                            .toString();

                        return MyBookingsList[index].status == 2
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(BookedHotelDetailsPage(
                                    BookingId:
                                        MyBookingsList[index].bookingid,
                                    payId: MyBookingsList[index].payid,
                                    cancellationCharge:
                                        MyBookingsList[index].cancelcharge,
                                    Bookedprice:
                                        MyBookingsList[index].price,
                                    img: MyBookingsList[index].image,
                                    status: MyBookingsList[index].status,
                                    city: MyBookingsList[index].city,
                                    changerequestid: MyBookingsList[index].changerequestid,
                                    refund: MyBookingsList[index].refund,
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xffffffff),
                                          Color(0xffffffff)
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFE9D4E9),
                                          blurRadius: 5.0,
                                          spreadRadius: 2,
                                          offset: Offset(
                                            2,
                                            3,
                                          ),
                                        )
                                      ],
                                      //color: Colors.blue,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(
                                                    8), // Image radius
                                                child: CachedNetworkImage(
                                                  imageUrl: MyBookingsList[index].image,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url, error) => Container(
                                                    height: 100,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      image: DecorationImage(
                                                        image: AssetImage("assets/images/no-img.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    "${MyBookingsList[index].hotelname}",
                                                    style: TextStyle(
                                                        fontSize: screenSize
                                                                .width /
                                                            24,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      '$CheckIn - $CheckOut',
                                                      style: TextStyle(
                                                        fontSize: screenSize
                                                                .width /
                                                            28,
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${MyBookingsList[index].city}',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                            color: Colors
                                                                .black54,
                                                          )),
                                                      Text(
                                                          '₹${MyBookingsList[index].price.toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color: Colors
                                                                    .purple[
                                                                400],
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Expired',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  screenSize.width /
                                                                      28,
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          'Booked on: $Booked',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // ListTile(
                                    //   dense: true,
                                    //   leading:
                                    //   Container(
                                    //     color: Colors.red,
                                    //     height: 100,
                                    //     child: Image.asset(
                                    //         'assets/images/icons/hotel3.png'),
                                    //   ),
                                    //   title: Padding(
                                    //     padding: EdgeInsets.only(
                                    //         top: 10, bottom: 10),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Text(
                                    //           "${MyBookingsList[index].hotelname}",
                                    //           style: TextStyle(
                                    //               fontSize:
                                    //                   screenSize.width / 24,
                                    //               fontWeight:
                                    //                   FontWeight.bold),
                                    //           maxLines: 2,
                                    //           overflow: TextOverflow.ellipsis,
                                    //         ),
                                    //         SizedBox(
                                    //           height: 10,
                                    //         ),
                                    //         Text('$CheckIn - $CheckOut',
                                    //             style: TextStyle(
                                    //               fontSize:
                                    //                   screenSize.width / 28,
                                    //             )),
                                    //         SizedBox(
                                    //           height: 10,
                                    //         ),
                                    //         Row(
                                    //           mainAxisAlignment:
                                    //           MainAxisAlignment
                                    //               .spaceBetween,
                                    //           children: [
                                    //             Text('${MyBookingsList[index].city}',
                                    //                 style: TextStyle(
                                    //                     fontSize:
                                    //                     screenSize.width /
                                    //                         28,
                                    //                     color:
                                    //                     Colors.black54,
                                    //                     )),
                                    //             Text('₹${MyBookingsList[index].price}',
                                    //                 style: TextStyle(
                                    //                   fontSize:
                                    //                   screenSize.width /
                                    //                       28,
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color:  Colors.purple[400],
                                    //                 )),
                                    //           ],
                                    //         ),
                                    //         SizedBox(
                                    //           height: 10,
                                    //         ),
                                    //         Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment
                                    //                   .spaceBetween,
                                    //           children: [
                                    //             Text('Confirm',
                                    //                 style: TextStyle(
                                    //                     fontSize:
                                    //                         screenSize.width /
                                    //                             28,
                                    //                     color:
                                    //                         Colors.green[400],
                                    //                     fontWeight:
                                    //                         FontWeight.bold)),
                                    //             Text('Booked on: $Booked',
                                    //                 style: TextStyle(
                                    //                   fontSize:
                                    //                       screenSize.width /
                                    //                           28,
                                    //                 )),
                                    //           ],
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   onTap: () {
                                    //     // print("..........");
                                    //     // print(MyBookingsList.length);
                                    //     // print(MyBookingsList);
                                    //     //
                                    //     // print(MyBookingsList[index].status);
                                    //     // print(MyBookingsList[index].city);
                                    //     // print(MyBookingsList[index].identity);
                                    //     // print(MyBookingsList[index].hotelname);
                                    //
                                    //     Get.to(BookedHotelDetailsPage(
                                    //       BookingId:
                                    //           MyBookingsList[index].bookingid,
                                    //       payId: MyBookingsList[index].payid,
                                    //       cancellationCharge:
                                    //           MyBookingsList[index]
                                    //               .cancelcharge,
                                    //       Bookedprice:
                                    //           MyBookingsList[index].price,
                                    //     ));
                                    //   },
                                    // ),
                                  ),
                                ),
                              )
                            : Container();
                      }),
          ),

              //Tab 3
              RefreshIndicator(
                onRefresh: () async { _onRefresh(1); },
                child:
              MyBookingsList.isEmpty || cancelled == false
                  ? ListView(
                    children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 50,),
                                Container(
                                    height: 300,
                                    child: Image.asset(
                                      'assets/images/travel-time.png',
                                    )),
                                SizedBox(height: 50,),
                                Text(
                                  "Revisit your favourite places",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Text(
                                  "Here you will see all your cancelled trips and get inspired for your next ones.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                SizedBox(height: 50,),
                                login == 'guest' || login == null || login == ''
                                    ? ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => LoginPage(
                                              page: 'room',
                                            ));
                                      },
                                      // style: ElevatedButton.styleFrom(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 40.0,
                                      //       vertical: 20.0),
                                      //   backgroundColor:
                                      //       Colors.transparent,
                                      //   shadowColor: Colors.transparent,
                                      //   shape: StadiumBorder(),
                                      // ),
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    22,
                                            fontFamily: 'Metropolis',
                                            fontWeight:
                                                FontWeight.bold),
                                      ),
                                    )
                                    : Container(),

                              ],
                            ),
                          ),
                        ),
                      ],
                  )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: MyBookingsList.length,
                      // reverse: true,
                      itemBuilder: (_, index) {
                        var checkInDate =
                            MyBookingsList[index].checkindate.toString();
                        var inDate = DateTime.parse(checkInDate);
                        var CheckIn =
                            DateFormat('dd MMM').format(inDate).toString();

                        var checkOutDate =
                            MyBookingsList[index].checkoutdate.toString();
                        var outDate = DateTime.parse(checkOutDate);
                        var CheckOut =
                            DateFormat('dd MMM').format(outDate).toString();

                        var BookedDate =
                            MyBookingsList[index].bookingdate.toString();
                        var BookDate = DateTime.parse(BookedDate);
                        var Booked = DateFormat('dd MMM')
                            .format(BookDate)
                            .toString();

                        return MyBookingsList[index].status == 3
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(BookedHotelDetailsPage(
                                    BookingId:
                                        MyBookingsList[index].bookingid,
                                    payId: MyBookingsList[index].payid,
                                    cancellationCharge:
                                        MyBookingsList[index].cancelcharge,
                                    Bookedprice:
                                        MyBookingsList[index].price,
                                    img: MyBookingsList[index].image,
                                    status: MyBookingsList[index].status,
                                    city: MyBookingsList[index].city,
                                    changerequestid: MyBookingsList[index].changerequestid,
                                    refund: MyBookingsList[index].refund,
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xffffffff),
                                          Color(0xffffffff)
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFE9D4E9),
                                          blurRadius: 5.0,
                                          spreadRadius: 2,
                                          offset: Offset(
                                            2,
                                            3,
                                          ),
                                        )
                                      ],
                                      //color: Colors.blue,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(
                                                    8), // Image radius
                                                child: CachedNetworkImage(
                                                  imageUrl: MyBookingsList[index].image,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url, error) => Container(
                                                    height: 100,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      image: DecorationImage(
                                                        image: AssetImage("assets/images/no-img.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    "${MyBookingsList[index].hotelname}",
                                                    style: TextStyle(
                                                        fontSize: screenSize
                                                                .width /
                                                            24,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      '$CheckIn - $CheckOut',
                                                      style: TextStyle(
                                                        fontSize: screenSize
                                                                .width /
                                                            28,
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${MyBookingsList[index].city}',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                            color: Colors
                                                                .black54,
                                                          )),
                                                      Text(
                                                          '₹${MyBookingsList[index].price.toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color: Colors
                                                                    .purple[
                                                                400],
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Cancelled',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  screenSize
                                                                          .width /
                                                                      28,
                                                              color: Colors
                                                                  .red[400],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          'Booked on: $Booked',
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                28,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      }),
      ),
            ],
          ),
      ),
    );
  }

  getBookings(int tab) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var loginMethod = prefs.getString('login');
      var email = prefs.getString('email');
      // print(loginMethod);
      setState(() {
        login = loginMethod;
      });
      final response = await http.post(
        Uri.parse('${api}api/hotel-book/get-details'),
        body: jsonEncode({"identity": "$email"}),
        headers: {"content-type": "application/json"},
      );
      log(response.body);
      print(response.statusCode);
if(response.statusCode == 200){

  if (response.body.contains('"status":1') || response.body.contains('"status":4')) {
    setState(() {
      active = true;
    });
  }
  if (response.body.contains('"status":2')) {
    setState(() {
      past = true;
    });
  }
  if (response.body.contains('"status":3')) {
    setState(() {
      cancelled = true;
    });
  }

  var details = json.decode(response.body);
  details.forEach((element) {
    setState(() {
      MyBookingsList.add(BookingStatus.fromJson(element));
    });
  });


}else{
  Fluttertoast.showToast(
      msg: "${response.statusCode}: Can't get details!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0x23000000),
      textColor: Colors.white,
      fontSize: 16.0);
  setState(() {
    // if (tab == 1) {
    //   _refreshController1.loadFailed();
    // } else if (tab == 2) {
    //   _refreshController2.loadFailed();
    // } else if (tab == 3) {
    //   _refreshController3.loadFailed();
    // }
  });
}

    }catch(e){
      Fluttertoast.showToast(
          msg: "${e}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0x23000000),
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        // if (tab == 1) {
        //   _refreshController1.loadFailed();
        // } else if (tab == 2) {
        //   _refreshController2.loadFailed();
        // } else if (tab == 3) {
        //   _refreshController3.loadFailed();
        // }
      });

      print(e);
    } finally {
      // Update the refresh controllers after completing the API call
      setState(() {
        // if (tab == 1) {
        //   _refreshController1.loadComplete();
        // } else if (tab == 2) {
        //   _refreshController2.loadComplete();
        // } else if (tab == 3) {
        //   _refreshController3.loadComplete();
        // }
      });
    }


  }
}
