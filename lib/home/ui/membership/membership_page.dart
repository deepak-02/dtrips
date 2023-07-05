import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../db/api.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  bool btnVisible = true;

  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  late double amt;
  late var plan;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final GlobalKey<TooltipState> tooltipkey1 = GlobalKey<TooltipState>();
    final GlobalKey<TooltipState> tooltipkey2 = GlobalKey<TooltipState>();
    final GlobalKey<TooltipState> tooltipkey3 = GlobalKey<TooltipState>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: btnVisible
          ? Padding(
              padding: const EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!btnVisible) setState(() => btnVisible = true);
            } else if (notification.direction == ScrollDirection.reverse) {
              if (btnVisible) setState(() => btnVisible = false);
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
              child: Column(
                children: [
                  Container(
                    width: screenSize.width,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFCCCCCC),
                      border: Border.all(
                        color: Color(0xff000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFCCCCCC),
                          blurRadius: 5.0,
                          spreadRadius: 2,
                          offset: Offset(
                            2,
                            2,
                          ),
                        )
                      ],
                    ),
                    child: Text(
                      "Dtrips Membership Plans",
                      style: TextStyle(
                          fontSize: screenSize.width / 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenSize.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFCCCCCC),
                      border: Border.all(
                        color: Color(0xff000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFCCCCCC),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Dtrips ",
                                    style: TextStyle(
                                      fontSize: screenSize.width / 20,
                                    ),
                                  ),
                                  Text(
                                    "Delight ",
                                    style: TextStyle(
                                        fontSize: screenSize.width / 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Plan",
                                    style: TextStyle(
                                      fontSize: screenSize.width / 20,
                                    ),
                                  ),
                                ],
                              ),
                              Tooltip(
                                key: tooltipkey1,
                                triggerMode: TooltipTriggerMode.manual,
                                showDuration: const Duration(seconds: 5),
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xff000000),
                                    width: 1,
                                  ),
                                ),
                                richMessage: TextSpan(
                                  text:
                                      '*trip - One trip equal to oneway flight ticket or one night hotel stay above Rs.3,000/-\n',
                                  style: TextStyle(color: Colors.black),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          '**Savings offered in Dtrips selected flights and hotels only.',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                    onTap: () {
                                      tooltipkey1.currentState
                                          ?.ensureTooltipVisible();
                                    },
                                    child: Icon(Icons.info_outline)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: 1,
                          width: screenSize.width,
                        ),
                        FittedBox(
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Container(
                                  width: screenSize.width / 4,
                                 // height: screenSize.height / 2.5,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "White",
                                          style: TextStyle(
                                            fontSize: screenSize.width / 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Sign up",
                                                style: TextStyle(
                                                  fontSize: screenSize.width / 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Up to 5% on selected domestic and international flights",
                                                style: TextStyle(
                                                  fontSize: screenSize.width / 26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Up to 20% on over 10,000 hotels",
                                                style: TextStyle(
                                                  fontSize: screenSize.width / 26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width / 4,
                                  //height: screenSize.height / 2.5,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFCCCCCC),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Grey",
                                          style: TextStyle(
                                              fontSize: screenSize.width / 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "2 trips with Dtrips",
                                                style: TextStyle(
                                                  fontSize: screenSize.width / 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Domestic and up to 5% on international flights",
                                                style: TextStyle(
                                                  fontSize: screenSize.width / 26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Up to 30% on over 25,000 hotels",
                                                style: TextStyle(
                                                  fontSize: screenSize.width / 26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width / 4,
                                  //height: screenSize.height / 2.5,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF666666),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Onyx",
                                          style: TextStyle(
                                              fontSize: screenSize.width / 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "5 trips with Dtrips",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Domestic and up to 5% on international flights",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 26,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Up to 40% on over 75,000 hotels",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 26,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width / 4,
                                  //height: screenSize.height / 2.5,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF000000),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Black",
                                          style: TextStyle(
                                              fontSize: screenSize.width / 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "20 trips with Dtrips",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Domestic and up to 10% on international flights",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 26,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, right: 2),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 10,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Up to 50% on over 10,000 hotels",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.width / 26,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
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
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    // height: screenSize.height/5,
                    width: screenSize.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4CCCC),
                      border: Border.all(
                        color: Color(0xFFFF0100),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF4CCCC),
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
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE06666),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Dtrips ",
                                      style: TextStyle(
                                          fontSize: screenSize.width / 20,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Delish ",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Plan",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Tooltip(
                                  key: tooltipkey2,
                                  triggerMode: TooltipTriggerMode.manual,
                                  showDuration: const Duration(seconds: 5),
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xFFE06666),
                                      width: 1,
                                    ),
                                  ),
                                  richMessage: TextSpan(
                                    text:
                                        'Eligible to use in all flights and hotels available in www.dtrips.com , we are associated with 1 million plus hotels and all domestic and international flights',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        tooltipkey2.currentState
                                            ?.ensureTooltipVisible();
                                      },
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFFFF0100),
                          height: 1,
                          width: screenSize.width,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFEA9999),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Free flight tickets upto Rs.18,000/- and free Hotel bookings / Holidays upto Rs.18,000/- Or Free Hotel bookings / Holidays upto Rs.36,000/- ",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Free flight /bus tickets / cabs upto Rs.3,600/- and Hotel bookings / holidays upto Rs.,3,600/- Or Free Hotel bookings / Holidays upto  Rs.7,200/- per year.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Purchase flight ticket upto Rs.3,600/- and hotel rooms upto Rs.3,600/- or hotel rooms only upto Rs.7,200/- immediately after your joining amount credited in your Dtrips account.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Cancellations and modifications of bookings are as per the carrier / property policies.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Plan is valid upto 5 years from joining date. Unlimited carry forward allowed upto 8 years from joining year without any additional charges. No annual / renewal charges required.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF4CCCC),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Add on benefits of  Dtrips Delish account holder on all trips after yearly free tickets / hotels are :-",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF4CCCC),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 50% discount on over 150,000 hotels",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF4CCCC),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 10% discount on selected international flights.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF4CCCC),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 20% discount on selected domestic flights.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF4CCCC),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 25% discount on holiday packages.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF4CCCC),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "3 to 10% discount on cab / bus / cruise trips.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: screenSize.width / 1.1,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xffff0100),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenSize.width / 2,
                                            child: Text(
                                              "Pay 20,000/- today and start your trips tomorrow onwards.",
                                              style: TextStyle(
                                                fontSize: screenSize.width / 24,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                plan = "Delish";
                                              });
                                              getOrderId(20000);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 40.0, vertical: 20.0),
                                              shape: StadiumBorder(),
                                            ),
                                            child: Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize:
                                                      screenSize.width / 24),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- OR -",
                                        style: TextStyle(
                                          fontSize: screenSize.width / 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenSize.width / 2,
                                            child: Text(
                                              "Pay in installment, Rs. 3,400/- x 6 months.",
                                              style: TextStyle(
                                                fontSize: screenSize.width / 24,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              //EMI 20000
                                              setState(() {
                                                plan = "Delish";
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 40.0, vertical: 20.0),
                                              shape: StadiumBorder(),
                                            ),
                                            child: Text(
                                              'Pay as EMI',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: screenSize.width / 24,
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    // height: screenSize.height/5,
                    width: screenSize.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9CB9C),
                      border: Border.all(
                        color: Color(0xFFFF8200),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF9CB9C),
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
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE69138),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Dtrips ",
                                      style: TextStyle(
                                          fontSize: screenSize.width / 20,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Delux ",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Plan",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Tooltip(
                                  key: tooltipkey3,
                                  triggerMode: TooltipTriggerMode.manual,
                                  showDuration: const Duration(seconds: 5),
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xFFF9CB9C),
                                      width: 1,
                                    ),
                                  ),
                                  richMessage: TextSpan(
                                    text:
                                        'Eligible to use in all flights and hotels available in www.dtrips.com , we are associated with 1 million plus hotels and all domestic and international flights ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        tooltipkey3.currentState
                                            ?.ensureTooltipVisible();
                                      },
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFFE69138),
                          height: 1,
                          width: screenSize.width,
                        ),
                        Column(
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF6B26B),
                              //   border: Border.all(
                              //     color: Color(0xff000000),
                              //     width: 1,
                              //   ),
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Free flight tickets upto Rs.50,000/- and free Hotel bookings / Holidays upto Rs.50,000/- Or Free Hotel bookings / Holidays upto Rs.100,000/- ",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              // decoration: BoxDecoration(
                              //   color: Color(0xFFF4CCCC),
                              //   border: Border.all(
                              //     color: Color(0xff000000),
                              //     width: 1,
                              //   ),
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Free flight /bus tickets / cabs upto Rs.10,000/- and Hotel bookings / holidays upto Rs.10,000/- Or Free Hotel bookings / Holidays upto  Rs.20,000/- per year.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              // decoration: BoxDecoration(
                              //   color: Color(0xFFF4CCCC),
                              //   border: Border.all(
                              //     color: Color(0xff000000),
                              //     width: 1,
                              //   ),
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Purchase flight ticket upto Rs.10,000/-  and hotel rooms upto Rs.10,000/- or hotel rooms only upto Rs.20,000/- immediately after your joining amount credited in your Dtrips account.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              // decoration: BoxDecoration(
                              //   color: Color(0xFFF4CCCC),
                              //   border: Border.all(
                              //     color: Color(0xff000000),
                              //     width: 1,
                              //   ),
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Cancellations and modifications of bookings are as per the carrier / property policies.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFFFFFFF),
                              // decoration: BoxDecoration(
                              //
                              // borderRadius: BorderRadius.only(
                              //   bottomRight: Radius.circular(16),
                              //   bottomLeft: Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Plan is valid upto 5 years from joining date. Unlimited carry forward allowed upto 8 years from joining year without any additional charges. No annual / renewal charges required.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF9CB9C),
                              // decoration: BoxDecoration(
                              //
                              // borderRadius: BorderRadius.only(
                              //   bottomRight: Radius.circular(16),
                              //   bottomLeft: Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 2),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Other benefits of  Dtrips Delux account holder on all trips after yearly free tickets / hotels are :-",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF9CB9C),
                              // decoration: BoxDecoration(
                              //
                              // borderRadius: BorderRadius.only(
                              //   bottomRight: Radius.circular(16),
                              //   bottomLeft: Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 50% discount on over 150,000 hotels",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF9CB9C),
                              // decoration: BoxDecoration(
                              //
                              // borderRadius: BorderRadius.only(
                              //   bottomRight: Radius.circular(16),
                              //   bottomLeft: Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 10% discount on selected international flights.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF9CB9C),
                              // decoration: BoxDecoration(
                              //
                              // borderRadius: BorderRadius.only(
                              //   bottomRight: Radius.circular(16),
                              //   bottomLeft: Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 20% discount on selected domestic flights.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF9CB9C),
                              // decoration: BoxDecoration(
                              //
                              // borderRadius: BorderRadius.only(
                              //   bottomRight: Radius.circular(16),
                              //   bottomLeft: Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Upto 33% discount on holiday packages.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF9CB9C),
                              // decoration: BoxDecoration(
                              //
                              // borderRadius: BorderRadius.only(
                              //   bottomRight: Radius.circular(16),
                              //   bottomLeft: Radius.circular(16),
                              // ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 2, left: 10),
                                    child: Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "5 to 15% discount on cab / bus / cruise trips.",
                                      style: TextStyle(
                                        fontSize: screenSize.width / 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: screenSize.width / 1.1,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xFFE69138),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenSize.width / 2,
                                            child: Text(
                                              "Pay 50,000/- today and start your trips tomorrow onwards",
                                              style: TextStyle(
                                                fontSize: screenSize.width / 24,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                plan = "Delux";
                                              });
                                              getOrderId(50000);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 40.0, vertical: 20.0),
                                              shape: StadiumBorder(),
                                            ),
                                            child: Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize:
                                                      screenSize.width / 24),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- OR -",
                                        style: TextStyle(
                                          fontSize: screenSize.width / 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenSize.width / 2,
                                            child: Text(
                                              "Pay in installment, Rs. 8,500/- x 6 months",
                                              style: TextStyle(
                                                fontSize: screenSize.width / 24,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              //EMI 50000
                                              setState(() {
                                                plan = "Delux";
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 40.0, vertical: 20.0),
                                              shape: StadiumBorder(),
                                            ),
                                            child: Text(
                                              'Pay as EMI',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize:
                                                      screenSize.width / 24),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getPlan(
    String paymentId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    var email = prefs.getString('email');
    final response = await http.post(
      Uri.parse(api + 'api/membership/buy-plan'),
      body: jsonEncode({'identity': '$email', 'plan': '$plan'}),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
    } else {
      refundPayment(paymentId);
    }
  }

  refundPayment(String paymentId) async {
    final response = await http.post(
      Uri.parse('${api}api/payments/refund'),
      body: jsonEncode(
          {'amount': ((amt * 100).round()).toString(), 'payId': paymentId}),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);
    print('refund api');
  }

  getOrderId(double amount) async {
    final response = await http.post(
      Uri.parse('${api}api/payments/order'),
      body: jsonEncode({
        'amount': ((amount * 100).round()).toString(),
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    var orderId = response.body.replaceAll('"', '');
    //if get order id then call start payment method
    if (response.statusCode == 200) {
      setState(() {
        amt = amount;
      });
      startPayment(orderId, amount);
    }
  }

  startPayment(var orderId, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var phone = prefs.getString('phone');
    var options = {
      'key': "rzp_test_ehCpwEfxvPgoqK",
      // amount will be multiple of 100
      'amount': ((amount * 100).round())
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
    getPlan(response.paymentId.toString());
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
}
