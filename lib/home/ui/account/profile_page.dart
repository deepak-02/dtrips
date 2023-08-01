import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Shared/SharedPrefs.dart';
import '../../../db/Membership/GetPlan.dart';
import '../../../db/Profile/GetProfile.dart';
import '../../../db/api.dart';
import '../../../login/login_page.dart';
import '../../constant.dart';
import '../../global.dart';
import '../membership/membership_page.dart';
import '../membership/single_membership.dart';
import '../settings/Settings_Page.dart';
import 'edit_profile_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

var email;
var loginMethod;
dynamic plan = "Delight";
dynamic level = "white";
dynamic bookLevel = "Grey";
double bookValue = 0.0;
String bookDivision = "0/2";
String levelNote =
    "Complete bookings worth 3000 rupees to unlock Delight Level";

class _UserProfilePageState extends State<UserProfilePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // print('username = ' + username);

    super.initState();
    getData();
    //getMembership();
    getMembershipDetails();
    getMembershipStatus();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // print('refresher loading...');

    setState(() {});
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // monitor network fetch
    getData();
    //getMembership();
    getMembershipDetails();
    getMembershipStatus();
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});

    _refreshController.refreshCompleted();
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
          // Positioned(
          //   top: -250,
          //   left: -40,
          //   child: topWidget(screenSize.width),
          // ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(
                  waterDropColor: Colors.purple,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.only(right: 20, top: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       InkWell(
                          //         onTap: () {
                          //           getMembershipDetails();
                          //           // loginMethod == null || loginMethod == 'guest' ?
                          //           // showDialog<String>(
                          //           //   context: context,
                          //           //   builder: (BuildContext context) =>
                          //           //       AlertDialog(
                          //           //         shape: RoundedRectangleBorder(
                          //           //             borderRadius: BorderRadius.all(
                          //           //                 Radius.circular(15.0))),
                          //           //         title: Text(
                          //           //             "Not a user?",
                          //           //           style: TextStyle(
                          //           //               fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                          //           //               fontFamily: 'Metropolis',
                          //           //               color: Colors.black,
                          //           //               fontWeight: FontWeight.bold),
                          //           //         ),
                          //           //         content: Text(
                          //           //             "Login or Create an account to get more features and access our exclusive deals and offers.",
                          //           //           style: TextStyle(
                          //           //               fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                          //           //               fontFamily: 'Metropolis',
                          //           //               color: Colors.black,
                          //           //               fontWeight: FontWeight.w500),
                          //           //         ),
                          //           //         actions: <Widget>[
                          //           //           TextButton(
                          //           //             onPressed: () => Get.back(),
                          //           //             child: const Text('Cancel',
                          //           //               style: TextStyle(color: Colors.black54, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                          //           //             ),
                          //           //           ),
                          //           //           TextButton(
                          //           //             onPressed: () {
                          //           //               Get.to(LoginPage());
                          //           //             },
                          //           //             child: const Text(
                          //           //               'OK',
                          //           //               style: TextStyle(color: Colors.purple, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                          //           //             ),
                          //           //           ),
                          //           //         ],
                          //           //       ),
                          //           // ) : print('notifications');
                          //         },
                          //         child: Badge(
                          //             badgeContent: Text(
                          //               '3',
                          //               style: TextStyle(color: Colors.white),
                          //             ),
                          //             badgeColor: Colors.red,
                          //             child: CircleAvatar(
                          //               radius: 20,
                          //               backgroundColor: Colors.transparent,
                          //               child: Image.asset(
                          //                 "assets/images/icons/bell.png",
                          //                 fit: BoxFit.contain,
                          //               ),
                          //             )),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 65,
                                      backgroundColor: Color(0xfff4e9f4),
                                      child: CircleAvatar(
                                        radius: 64,
                                        //Color of membership
                                        backgroundColor: color,
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Color(0xfff4e9f4),
                                          child: Text(
                                            name == null
                                                ? "G"
                                                : "${name[0].toString().toUpperCase()}",
                                            style: TextStyle(
                                                fontSize: 60,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Image.asset(
                                        //   'assets/images/avatar.png',
                                        //   fit: BoxFit.contain,
                                        // ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      loginMethod == null ||
                                              loginMethod == 'guest'
                                          ? "Guest"
                                          : "$name",
                                      style: TextStyle(
                                          fontSize: orientation == "portrait"
                                              ? screenSize.width / 15
                                              : screenSize.height / 15,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          plan == null ? "" : "$plan",
                                          style: TextStyle(
                                              fontSize: screenSize.width / 22,
                                              fontFamily: 'Metropolis',
                                              color: Color(0xff92278f),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        plan == "Delight"
                                            ? SizedBox(
                                                width: 10,
                                              )
                                            : Container(),
                                        plan == "Delight"
                                            ? Text(
                                                "Level",
                                                style: TextStyle(
                                                  fontSize:
                                                      screenSize.width / 22,
                                                  fontFamily: 'Metropolis',
                                                  color: Colors.black54,
                                                ),
                                              )
                                            : Container(),
                                        plan == "Delight"
                                            ? SizedBox(
                                                width: 10,
                                              )
                                            : Container(),
                                        plan == "Delight"
                                            ? Text(
                                                "$level",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 22,
                                                    fontFamily: 'Metropolis',
                                                    color: Color(0xff92278f),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          InkWell(
                            onTap: () {
                              // getMembership();
                              showModalBottomSheet<void>(
                                context: context,
                                // backgroundColor: Colors.white,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: Colors.white,
                                    height: screenSize.height / 2,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 10),
                                          child: Text(
                                            "Dtrips Membership Plans",
                                            style: TextStyle(
                                                fontSize: screenSize.width / 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(MembershipPage());
                                            //getMembership();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Explore all plans",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenSize.width / 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.purple,
                                                  radius: 12,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 10),
                                            child: Row(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width:
                                                        screenSize.width / 1.5,
                                                    height:
                                                        screenSize.height / 3,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFFFFFFF),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xff000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0xFFCCCCCC),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 2,
                                                          offset: Offset(
                                                            2,
                                                            2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 10,
                                                          ),
                                                          child: ListTile(
                                                            leading:
                                                                Image.asset(
                                                              'assets/images/icons/free-delivery.png',
                                                              width: 40,
                                                            ),
                                                            trailing: Container(
                                                              width: 40,
                                                            ),
                                                            title: Center(
                                                              child: Text(
                                                                "Delight",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        screenSize.width /
                                                                            18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Free",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  right: 20,
                                                                  top: 8,
                                                                  bottom: 8),
                                                          child: Container(
                                                            color: Colors.black,
                                                            height: 2,
                                                            width: screenSize
                                                                .width,
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹0.0",
                                                          style: TextStyle(
                                                              fontSize: screenSize
                                                                      .width /
                                                                  18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "per month",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                24,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30.0,
                                                                      vertical:
                                                                          10.0),
                                                              shape:
                                                                  StadiumBorder(),
                                                            ),
                                                            onPressed: () {
                                                              Get.to(
                                                                  SingleMembershipPage(
                                                                Mplan: 1,
                                                              ));
                                                            },
                                                            child: Text(
                                                              'View',
                                                              style: TextStyle(
                                                                fontSize: screenSize
                                                                        .width /
                                                                    22,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width:
                                                        screenSize.width / 1.5,
                                                    height:
                                                        screenSize.height / 3,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF4CCCC),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xffff0100),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0xFFF4CCCC),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 2,
                                                          offset: Offset(
                                                            2,
                                                            2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 10,
                                                          ),
                                                          child: ListTile(
                                                            leading:
                                                                Image.asset(
                                                              'assets/images/icons/start-up.png',
                                                              width: 40,
                                                            ),
                                                            trailing: Container(
                                                              width: 40,
                                                            ),
                                                            title: Center(
                                                              child: Text(
                                                                "Delish",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        screenSize.width /
                                                                            18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹20,000/-",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  right: 20,
                                                                  top: 8,
                                                                  bottom: 8),
                                                          child: Container(
                                                            color: Color(
                                                                0xffff0100),
                                                            height: 2,
                                                            width: screenSize
                                                                .width,
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹3,400",
                                                          style: TextStyle(
                                                              fontSize: screenSize
                                                                      .width /
                                                                  18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "per month \nx 6 months",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                24,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30.0,
                                                                      vertical:
                                                                          10.0),
                                                              shape:
                                                                  StadiumBorder(),
                                                            ),
                                                            onPressed: () {
                                                              Get.to(
                                                                  SingleMembershipPage(
                                                                Mplan: 2,
                                                              ));
                                                            },
                                                            child: Text(
                                                              'View',
                                                              style: TextStyle(
                                                                fontSize: screenSize
                                                                        .width /
                                                                    22,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width:
                                                        screenSize.width / 1.5,
                                                    height:
                                                        screenSize.height / 3,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF9CB9C),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFFF8200),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0xFFF4CCCC),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 2,
                                                          offset: Offset(
                                                            2,
                                                            2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 10,
                                                          ),
                                                          child: ListTile(
                                                            leading:
                                                                Image.asset(
                                                              'assets/images/icons/diamond.png',
                                                              width: 40,
                                                            ),
                                                            trailing: Container(
                                                              width: 40,
                                                            ),
                                                            title: Center(
                                                              child: Text(
                                                                "Delux",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        screenSize.width /
                                                                            18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹50,000/-",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  right: 20,
                                                                  top: 8,
                                                                  bottom: 8),
                                                          child: Container(
                                                            color: Color(
                                                                0xFFFF8200),
                                                            height: 2,
                                                            width: screenSize
                                                                .width,
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹8,400",
                                                          style: TextStyle(
                                                              fontSize: screenSize
                                                                      .width /
                                                                  18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "per month \nx 6 months",
                                                          style: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                24,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30.0,
                                                                      vertical:
                                                                          10.0),
                                                              shape:
                                                                  StadiumBorder(),
                                                            ),
                                                            onPressed: () {
                                                              Get.to(
                                                                  SingleMembershipPage(
                                                                      Mplan:
                                                                          3));
                                                            },
                                                            child: Text(
                                                              'View',
                                                              style: TextStyle(
                                                                fontSize: screenSize
                                                                        .width /
                                                                    22,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              //height: screenSize.height/4,
                              width: screenSize.width / 1.2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border.all(
                                  color: Color(0xff92278f),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xfff4e9f4),
                                    blurRadius: 5.0,
                                    spreadRadius: 2,
                                    offset: Offset(
                                      2,
                                      2,
                                    ),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$levelNote $bookLevel.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 24,
                                        fontFamily: 'Metropolis',
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      height: 20,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: LinearProgressIndicator(
                                          value: bookValue, //value
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xff92278f)),
                                          backgroundColor: Color(0xffD6D6D6),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "$bookDivision Bookings above 3000",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 24,
                                        fontFamily: 'Metropolis',
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Divider(
                                      height: 20,
                                      indent: 0,
                                      endIndent: 0,
                                      color: Colors.black54,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Membership Plan",
                                          style: TextStyle(
                                            fontSize: screenSize.width / 24,
                                            fontFamily: 'Metropolis',
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        Text(
                                          plan == null ? "Delight" : "$plan",
                                          style: TextStyle(
                                              fontSize: screenSize.width / 18,
                                              fontFamily: 'Metropolis',
                                              color: Color(0xff92278f),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          Row(
                            children: [
                              Text(
                                "Account Settings",
                                style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 17
                                        : screenSize.height / 17,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              // print('Edit Profile');
                              loginMethod == null || loginMethod == 'guest'
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
                                              'assets/lottie/info.json',
                                              fit: BoxFit.contain),
                                        ),
                                        title: Text(
                                          "Login to continue",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              fontFamily: 'Metropolis',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          "Login or Create an account to book rooms.\nGet more features and access our exclusive deals and offers.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  24,
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
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Color(0xff92278f),
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
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Get.to(() => LoginPage(
                                                          page: 'room',
                                                        )),
                                                child: const Text(
                                                  'Login',
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
                                  : Get.to(EditProfilePage());
                            },
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                            'assets/images/icons/profile-settings.png'),
                                        radius: 15,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            fontSize: orientation == "portrait"
                                                ? screenSize.width / 20
                                                : screenSize.height / 20,
                                            fontFamily: 'Metropolis',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //   //  print('Notification Srttings');
                          //
                          //     loginMethod == null || loginMethod == 'guest' ? showDialog<String>(
                          //       context: context,
                          //       builder: (BuildContext context) =>
                          //           AlertDialog(
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(15.0))),
                          //             icon: Container(
                          //               height: 100,
                          //               child:  Lottie.asset(
                          //                   'assets/lottie/info.json',
                          //                   fit: BoxFit.contain),
                          //             ),
                          //             title: Text(
                          //               "Login to continue",
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                   fontSize:MediaQuery.of(context).size.width/20 ,
                          //                   fontFamily: 'Metropolis',
                          //                   color: Colors.black,
                          //                   fontWeight: FontWeight.bold),
                          //             ),
                          //             content: Text(
                          //               "Login or Create an account to book rooms.\nGet more features and access our exclusive deals and offers.",
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                   fontSize: MediaQuery.of(context).size.width/24,
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
                          //                     child: const Text('Cancel',
                          //                       style: TextStyle(color: Color(0xff92278f), fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
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
                          //                     onPressed: () => Get.to(() =>LoginPage(page: 'room',)),
                          //                     child: const Text('Login',
                          //                       style: TextStyle(
                          //                           color: Color(0xffffffff),
                          //                           fontFamily: 'Metropolis',
                          //                           fontWeight: FontWeight.bold
                          //                       ),
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
                          //     ):print('notification Settings');
                          //   },
                          //   child: Container(
                          //     height: 50,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Row(
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             CircleAvatar(
                          //               backgroundColor: Colors.transparent,
                          //               child: Image.asset(
                          //                   'assets/images/icons/notification-settings.png'),
                          //               radius: 15,
                          //             ),
                          //             SizedBox(
                          //               width: 20,
                          //             ),
                          //             Text(
                          //               "Notification Settings",
                          //               style: TextStyle(
                          //                   fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                          //                   fontFamily: 'Metropolis',
                          //                   color: Colors.black,
                          //                   fontWeight: FontWeight.bold),
                          //             ),
                          //           ],
                          //         ),
                          //         Icon(
                          //           Icons.keyboard_arrow_right,
                          //           size: 30,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Divider(
                            height: 20,
                            indent: 10,
                            endIndent: 10,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "App Settings",
                                style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 17
                                        : screenSize.height / 17,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              //  print('App Settings');
                              Get.to(SettingsPage());
                            },
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                            'assets/images/icons/settings1.png'),
                                        radius: 15,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Settings",
                                        style: TextStyle(
                                            fontSize: orientation == "portrait"
                                                ? screenSize.width / 20
                                                : screenSize.height / 20,
                                            fontFamily: 'Metropolis',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: AssetImage(
                                        "assets/images/dtrips_logo_dark.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              loginMethod == null || loginMethod == 'guest'
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Join us to explore more & Get exclusive deals and offers.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: orientation ==
                                                        "portrait"
                                                    ? screenSize.width / 20
                                                    : screenSize.height / 20,
                                                fontFamily: 'Metropolis',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Get.to(LoginPage());
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xfff4e9f4)),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                              ),
                                            ),
                                            child: Text(
                                              "Join Us",
                                              style: TextStyle(
                                                  fontSize: orientation ==
                                                          "portrait"
                                                      ? screenSize.width / 26
                                                      : screenSize.height / 26,
                                                  fontFamily: 'Metropolis',
                                                  color: Color(0xff92278f),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0))),
                                              title: Text("Are you sure?"),
                                              content: Text(
                                                  "Do you want to logout?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text('Cancel',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff7f91dd))),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    logout();
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xfff4e9f4)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                          ),
                                        ),
                                        child: Text(
                                          "Log Out",
                                          style: TextStyle(
                                              fontSize:
                                                  orientation == "portrait"
                                                      ? screenSize.width / 26
                                                      : screenSize.height / 26,
                                              fontFamily: 'Metropolis',
                                              color: Color(0xff92278f),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    // GoogleSignInApi.logout();
    GoogleSignIn().disconnect();

    removeName();
    removeJwt();
    removeEmail();
    removeLogin();
    removePhone();
    removeAddress();
    removeGender();
    setState(() {
      userimg = '';
      username = '';
      token = '';
      plan = "Delight";
      level = "white";
      bookLevel = "Grey";
      bookValue = 0.0;
      bookDivision = "0/2";
      levelNote = "Complete bookings worth 3000 rupees to unlock Delight Level";
      color = Color(0xFFFFFFFF);
    });
    Get.offAll(LoginPage());
  }

  void getData() async {
    print('get-profile');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
      pemail = prefs.getString('email');
      pphone = prefs.getString('phone');
      paddress = prefs.getString('address');
      loginMethod = prefs.getString('login');
      // print('Login Method: $loginMethod');
    });

    final response = await http.get(
      Uri.parse(api + 'api/auth/get-profile?email=$email'),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      try {
        final result = getProfileFromJson(response.body.toString());
        setState(() {
          name = result.name;
          // email = result.email;
          pemail = result.email;
          pphone = result.phone;
          paddress = result.address;

          result.phone == null ? null : setPhone(result.phone);
          result.name == null ? null : setName(result.name);
          result.address == null ? null : setAddress(result.address);
          result.gender == null ? null : setGender(result.gender);
          print('Login email: $email');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  // getMembership() async {
  //
  //   final response = await http.post(
  //     Uri.parse(api + 'api/membership/get-all'),
  //     body: jsonEncode({
  //
  //     }),
  //     headers: {"content-type": "application/json"},
  //   );
  //   // print(response.body);
  //   // print(response.statusCode);
  //
  //   final result = membershipFromJson(response.body);
  //
  //   if(response.statusCode == 200){
  //     setState(() {
  //       result!.length == 0 ? null : membershipData = result.cast<Membership>();
  //     });
  //
  //   }
  //
  // }

  getMembershipDetails() async {
    print('membership details');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(api + 'api/list/get'),
      body: jsonEncode({
        'identity': prefs.getString('email'),
      }),
      headers: {"content-type": "application/json"},
    );
    print("response.body of details: $email");
    print(response.body);
    print(response.statusCode);

    try {
      final result =
          response.body.isNotEmpty ? getPlanFromJson(response.body) : null;

      if (result?.plan == "white" ||
          result?.plan == "grey" ||
          result?.plan == "onyx" ||
          result?.plan == "black") {
        setState(() {
          plan = "Delight";
          level = result!.plan!;
        });
        if (result?.plan == "white") {
          setState(() {
            color = Color(0xFFFFFFFF);
          });
        } else if (result?.plan == "grey") {
          setState(() {
            color = Color(0xFFCCCCCC);
          });
        } else if (result?.plan == "onyx") {
          setState(() {
            color = Color(0xFF666666);
          });
        } else if (result?.plan == "black") {
          setState(() {
            color = Color(0xFF000000);
          });
        }
      } else {
        setState(() {
          plan = result?.plan ?? null;
        });

        if (result?.plan == "Delux") {
          setState(() {
            color = Color(0xFFFF8200);
            bookValue = 1;
            bookLevel = "";
            levelNote = "Congratulations you are now a Dulex member.";
          });
        }
        if (result?.plan == "Delish") {
          setState(() {
            color = Color(0xFFE06666);
            bookValue = 1;
            bookLevel = "";
            levelNote = "Congratulations you are now a Delish member.";
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getMembershipStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(api + 'api/hotel-book/count'),
      body: jsonEncode({
        'identity': prefs.getString('email'),
      }),
      headers: {"content-type": "application/json"},
    );
    print('aaaaaaaaaaaaa');
    print(response.body);
    print(response.statusCode);
    double bookCount = double.parse(response.body);
    int count = int.parse(response.body);
    if (bookCount <= 2 && plan == "Delight") {
      setState(() {
        bookValue = bookCount / 2;
        bookLevel = "Grey";
        bookDivision = "$count/2";
      });
    } else if (bookCount > 2 && bookCount <= 5 && plan == "Delight") {
      setState(() {
        bookValue = bookCount / 5;
        bookLevel = "Onyx";
        bookDivision = "$count/5";
      });
    } else if (bookCount > 5 && bookCount <= 20 && plan == "Delight") {
      setState(() {
        bookValue = bookCount / 20;
        bookLevel = "Black";
        bookDivision = "$count/20";
      });
    } else if (bookCount > 20 && plan == "Delight") {
      setState(() {
        bookValue = 1;
        bookLevel = "";
        bookDivision = "$count";
        levelNote =
            "Congratulations you are now at level black. Upgrade your plans to enjoy greater discounts and offers.";
      });
    } else if (plan != "Delight") {
      setState(() {
        bookDivision = "$count";
      });
    }
  }
}
