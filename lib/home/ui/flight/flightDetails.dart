import 'dart:convert';
import 'dart:developer';

import 'package:dtrips/home/ui/flight/xmlView.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'package:http/http.dart' as http;
import '../../../db/Flight/LccSsrModel.dart';
import '../../../db/Flight/fareQuoteModel.dart';
import '../../../db/Flight/fareRuleModel.dart';
import '../../../db/api.dart';
import '../../global.dart';
import 'farePage.dart';
import 'flightCustomise.dart';

class FlightDetails extends StatefulWidget {
  const FlightDetails({Key? key, this.ResultIndex, this.TraceId, this.Token})
      : super(key: key);
  final ResultIndex;
  final TraceId;
  final Token;

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  var xmlString = "";
  var DestinationCityName = "";
  var DestinationCountryName = "";

  bool isLoading = true;

  @override
  void initState() {
    ClickLoading = false;
    getfareRule(widget.ResultIndex, widget.TraceId, widget.Token);
    getFareQuote(widget.ResultIndex, widget.TraceId, widget.Token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          tooltip: 'back',
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () async {
            Get.back();
            await Future.delayed(Duration(seconds: 2));
            flightDetails.clear();
          },
        ),
        title: Text(
          "Your flight to Dublin",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Rs. ${double.parse((flightDetails[0].fare!.tax! + flightDetails[0].fare!.otherCharges! + flightDetails[0].fare!.baseFare! - flightDetails[0].fare!.discount!).toStringAsFixed(2))}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.all(10.0),
                              child: Wrap(
                                children: <Widget>[
                                  Center(
                                      child: Container(
                                    height: 4.0,
                                    width: 50.0,
                                    color: Colors.grey[800],
                                  )),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: Text(
                                            "Price breakdown",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "Tickets (1 adult)",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                "Rs. ${double.parse(flightDetails[0].fare!.publishedFare!.toStringAsFixed(2))}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "Flight fare",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Rs. ${double.parse(flightDetails[0].fare!.baseFare!.toStringAsFixed(2))}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "Taxes and charges",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Rs. ${double.parse(flightDetails[0].fare!.tax!.toStringAsFixed(2)) + double.parse(flightDetails[0].fare!.otherCharges!.toStringAsFixed(2))}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "Discount",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Rs. -${flightDetails[0].fare!.discount}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "Total price",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Rs. ${double.parse((flightDetails[0].fare!.tax! + flightDetails[0].fare!.otherCharges! + flightDetails[0].fare!.baseFare! - flightDetails[0].fare!.discount!).toStringAsFixed(2))}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "includes taxes and charges",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.info_outline,
                        size: 18,
                      ),
                    )
                  ],
                ),
                Text("${noOfAdult + noOfChild + noOfInfant} traveller")
              ],
            ),

            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlightCustomisePage(
                              ResultIndex: widget.ResultIndex,
                              TraceId: widget.TraceId,
                              Token: widget.Token,
                            )),
                  );
                },
                // style: ElevatedButton.styleFrom(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 40.0, vertical: 20.0),
                //   backgroundColor: Colors.transparent,
                //   shadowColor: Colors.transparent,
                //   shape: const StadiumBorder(),
                // ),
                child: isLoading
                    ? Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ))
                    : Text(
                        "Select",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Container(
              //     width: double.infinity,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(color: Colors.black12, width: 1)),
              //     child: Padding(
              //       padding: const EdgeInsets.only(
              //           top: 20, bottom: 20, left: 20, right: 30),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Expanded(
              //             child: Text(
              //               "8% lower CO2 emissions than the average of all flights we offer for this route",
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.green),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: flightDetails[0].segments![0].length,
                itemBuilder: (BuildContext context, int index) {
                  final items = flightDetails[0];

                  var segment = items.segments![0][index];

                  String formatDuration(int duration) {
                    int hours = duration ~/ 60;
                    int minutes = duration % 60;

                    String formattedHours = hours.toString().padLeft(2, '0');
                    String formattedMinutes =
                        minutes.toString().padLeft(2, '0');

                    return '$formattedHours h $formattedMinutes m';
                  }

                  DestinationCityName = segment.destination!.airport!.cityName!;
                  DestinationCountryName =
                      segment.destination!.airport!.countryName!;

                  List<String> _cabinClassOptions = [
                    'All',
                    'Economy',
                    'Premium economy',
                    'Business',
                    'Premium Business',
                    'First class',
                  ];

                  var cabinName = _cabinClassOptions[segment.cabinClass!];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Flight to ${segment.destination!.airport!.cityName}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${formatDuration(segment.duration!)}, ${cabinName}"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    OutlinedDotIndicator(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "${DateFormat('E dd MMM, HH:mm').format(segment.origin!.depTime!)}") //Sat 03 Jun, 03:55
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6, top: 8, bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 180,
                                          child: DashedLineConnector(
                                            color: Colors.grey,
                                            dash: 5,
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Column(
                                          //   crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           top: 10, bottom: 10, left: 15),
                                          //       child: Text(
                                          //         "${segment.origin!.airport!.airportCode}, ${segment.origin!.airport!.cityName}",
                                          //         style: TextStyle(
                                          //             fontSize: 18,
                                          //             fontWeight: FontWeight.bold),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           bottom: 10, left: 15),
                                          //       child: Text(
                                          //         "${segment.origin!.airport!.airportName}",
                                          //         style: TextStyle(
                                          //           fontSize: 14,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding: const EdgeInsets.only(bottom: 10, left: 15),
                                          //       child: Text(
                                          //         segment.origin!.airport!.terminal == null ? "":"Terminal: ${segment.origin!.airport!.terminal}",
                                          //         style: TextStyle(
                                          //           fontSize: 14,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${segment.origin!.airport!.airportCode}, ${segment.origin!.airport!.cityName}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    "${segment.origin!.airport!.airportName}"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(segment.origin!.airport!
                                                            .terminal ==
                                                        null
                                                    ? ""
                                                    : "Terminal: ${segment.origin!.airport!.terminal}"),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 30, bottom: 10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.flight),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${segment.airline!.airlineName}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Flight: ${segment.airline!.airlineCode} ${segment.airline!.flightNumber}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Flight time: ${formatDuration(segment.duration!)}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     OutlinedDotIndicator(
                                //       color: Colors.grey,
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     Text("Sat 03 Jun, 05:50")
                                //   ],
                                // ),
                                // Padding(
                                //   padding:
                                //   const EdgeInsets.only(left: 6, top: 8, bottom: 8),
                                //   child: Row(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       SizedBox(
                                //           height: 130,
                                //           child: DashedLineConnector(
                                //             color: Colors.grey,
                                //             dash: 5,
                                //           )),
                                //       Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.only(
                                //                 top: 10, bottom: 10, left: 15),
                                //             child: Text(
                                //               "DOH, Doha",
                                //               style: TextStyle(
                                //                   fontSize: 18,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding: const EdgeInsets.only(
                                //                 bottom: 10, left: 15, top: 20),
                                //             child: Container(
                                //               width: MediaQuery.of(context).size.width /
                                //                   1.5,
                                //               alignment: Alignment.center,
                                //               decoration: BoxDecoration(
                                //                 color: Colors.black12,
                                //               ),
                                //               child: Padding(
                                //                 padding: const EdgeInsets.all(10),
                                //                 child: Row(
                                //                   children: [
                                //                     Icon(Icons.access_time),
                                //                     SizedBox(
                                //                       width: 5,
                                //                     ),
                                //                     Text(
                                //                       "Layover 2h 10m",
                                //                       style: TextStyle(
                                //                         fontSize: 14,
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // Row(
                                //   children: [
                                //     OutlinedDotIndicator(
                                //       color: Colors.grey,
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     Text("Sat 03 Jun, 08:00")
                                //   ],
                                // ),
                                // Padding(
                                //   padding:
                                //   const EdgeInsets.only(left: 6, top: 8, bottom: 8),
                                //   child: Row(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       SizedBox(
                                //           height: 130,
                                //           child: SolidLineConnector(
                                //             color: Colors.grey,
                                //           )),
                                //       Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.only(
                                //                 top: 10, bottom: 10, left: 15),
                                //             child: Text(
                                //               "DOH, Doha",
                                //               style: TextStyle(
                                //                   fontSize: 18,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding: const EdgeInsets.only(left: 15),
                                //             child: Row(
                                //               children: [
                                //                 Icon(Icons.flight),
                                //                 SizedBox(
                                //                   width: 20,
                                //                 ),
                                //                 Column(
                                //                   crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //                   children: [
                                //                     Text(
                                //                       "Qatar Airways",
                                //                       style: TextStyle(
                                //                           fontSize: 14,
                                //                           color: Colors.grey),
                                //                     ),
                                //                     Text(
                                //                       "Flight QR517",
                                //                       style: TextStyle(
                                //                           fontSize: 14,
                                //                           color: Colors.grey),
                                //                     ),
                                //                     Text(
                                //                       "Flight time 7h 40m",
                                //                       style: TextStyle(
                                //                           fontSize: 14,
                                //                           color: Colors.grey),
                                //                     ),
                                //                   ],
                                //                 )
                                //               ],
                                //             ),
                                //           )
                                //         ],
                                //       )
                                //     ],
                                //   ),
                                // ),
                                Row(
                                  children: [
                                    OutlinedDotIndicator(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "${DateFormat('E dd MMM, HH:mm').format(DateTime.parse(segment.destination!.arrTime.toString()))}")
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${segment.destination!.airport!.airportCode}, ${segment.destination!.airport!.cityName}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${segment.destination!.airport!.airportName}"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(segment.destination!.airport!
                                                  .terminal ==
                                              null
                                          ? ""
                                          : "Terminal: ${segment.destination!.airport!.terminal}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Divider(),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              ),

              Divider(
                color: Colors.black12,
                thickness: 10,
              ),

              ListTile(
                  onTap: () {
                    if (xmlString == null || xmlString == "") {
                      //show error toast
                      Fluttertoast.showToast(
                          msg: "Loading failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.black,
                          fontSize: 16.0);

                      getfareRule(
                          widget.ResultIndex, widget.TraceId, widget.Token);
                    } else {
                      Get.to(XMLContentWidget(xmlString));
                    }
                  },
                  tileColor: Colors.white,
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.flight_takeoff,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    "Check the fare rules and the COVID-19 travel restrictions for $DestinationCountryName",
                    maxLines: 5,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )),

              // Container(
              //   width: double.infinity,
              //   alignment: Alignment.center,
              //   color: Colors.white,
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //         left: 10, right: 10, top: 20, bottom: 20),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(right: 10),
              //           child: Icon(
              //             Icons.flight_takeoff,
              //           ),
              //         ),
              //
              //         Container(
              //           child: Expanded(
              //             child: GestureDetector(
              //               onTap: (){
              //                 if(xmlString == null || xmlString == ""){
              //                   //show error toast
              //                 }else{
              //                   Get.to(XMLContentWidget(xmlString));
              //                 }
              //               },
              //               child: Text(
              //                 "Check the COVID-19 travel restrictions for Ireland",
              //                 maxLines: 5,
              //                 style: TextStyle(fontSize: 16),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Icon(Icons.arrow_forward_ios)
              //       ],
              //     ),
              //   ),
              // ),
              Divider(
                color: Colors.black12,
                thickness: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Included baggage",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("The total baggage included in the price"),
              ),

              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: flightDetails[0].segments![0].length,
                itemBuilder: (BuildContext context, int index) {
                  final items = flightDetails[0];

                  var segment = items.segments![0][index];

                  return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trip to ${segment.destination!.airport!.cityName}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.shopping_bag,
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.only(left: 20),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             "Personal item",
                          //             style: TextStyle(fontSize: 16),
                          //           ),
                          //           Text(
                          //             "Must go under the seat in front of you",
                          //             style: TextStyle(fontSize: 16),
                          //           ),
                          //           Text(
                          //             "Included",
                          //             style: TextStyle(
                          //                 fontSize: 16, color: Colors.green),
                          //           ),
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Row(
                            children: [
                              Icon(
                                Icons.luggage_outlined,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "cabin bag",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      segment.cabinBaggage == null
                                          ? "Up to 0 KG"
                                          : "Up to ${segment.cabinBaggage} each",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      segment.cabinBaggage == null
                                          ? "Not-Included"
                                          : "Included",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: segment.cabinBaggage == null
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.luggage_outlined,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "checked bag",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      segment.baggage == null
                                          ? "Up to 0 KG"
                                          : "Max weight ${segment.baggage}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      segment.baggage == null
                                          ? "Not-Included"
                                          : "Included",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: segment.baggage == null
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),

              Divider(
                color: Colors.black12,
                thickness: 10,
              ),
              // Container(
              //   width: double.infinity,
              //   alignment: Alignment.center,
              //   color: Colors.white,
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //         left: 10, right: 10, top: 20, bottom: 20),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "Tell us how we're doing and what could be better",
              //           style: TextStyle(
              //             fontSize: 16,
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Text(
              //           "Give feedback",
              //           style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.blue),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Divider(
              //   color: Colors.black12,
              //   thickness: 10,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void getfareRule(resultIndex, traceId, token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');

    final response = await http.post(
      Uri.parse(api + 'api/flight/fare-rule'),
      body: jsonEncode({
        "EndUserIp": "$ips",
        "TokenId": "$token",
        "TraceId": "$traceId",
        "ResultIndex": "$resultIndex"
      }),
      headers: {"content-type": "application/json"},
    );

    // print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final result = fareRuleFromJson(response.body);

      try {
        setState(() {
          xmlString = result.response!.fareRules![0].fareRuleDetail!;
        });
      } catch (e) {
        setState(() {
          xmlString = "Something wrong!";
        });
        print(e);
      }
    } else {}
  }

  void getFareQuote(resultIndex, traceId, token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');

    final response = await http.post(
      Uri.parse(api + 'api/flight/fare-quote'),
      body: jsonEncode({
        "EndUserIp": "$ips",
        "TokenId": "$token",
        "TraceId": "$traceId",
        "ResultIndex": "$resultIndex"
      }),
      headers: {"content-type": "application/json"},
    );

    print("fare quote");
    print(response.statusCode);
     log(response.body);

    if (response.statusCode == 200) {
      final result = fareQuoteModelFromJson(response.body);

      print(result.response!.results!.isLcc!);
      // fareQuoteResult.add(result.response!.results);

      try{
        LccBaggage.isNotEmpty ? LccBaggage.clear() : null;
        mealItems.isNotEmpty ? mealItems.clear() : null;
        specialServices!.isNotEmpty ? specialServices!.clear() : null;
        seatDynamic!.isNotEmpty ? seatDynamic!.clear() : null;

      }catch(e){
        print("error: $e");
      }

      setState(() {
        isLoading = false;
        lcc = result.response!.results!.isLcc!;
      });
    }

    if (lcc) {
      getSSR(token, traceId, resultIndex);
    } else {
      getSSRWithoutLcc(token, traceId, resultIndex);
    }
  }

  void getSSR(token, traceId, resultIndex) async {
    print("lcc trueeeee: $lcc");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');

    final response = await http.post(
      Uri.parse(api + 'api/flight/ssr'),
      body: jsonEncode({
        "EndUserIp": "$ips",
        "TokenId": "$token",
        "TraceId": "$traceId",
        "ResultIndex": "$resultIndex"
      }),
      headers: {"content-type": "application/json"},
    );

    // log(response.body);
    print(response.statusCode);

    setState(() {
      res = response.body;
    });

    if (response.body.contains("No SSR details found")) {
      setState(() {
        ssr = false;
      });
    }

    if (response.statusCode == 200) {
      getSeats(response.body);

      final lccResult = ssrWithLccModelFromJson(response.body);

      // print(lccResult.response!.specialServices);
      // print(lccResult.response!.specialServices![0]);
      // print(lccResult.response!.specialServices![0].segmentSpecialService![0]);
      // print(lccResult.response!.specialServices![0].segmentSpecialService![0].ssrService);
      // print(lccResult.response!.specialServices![0].segmentSpecialService![0].ssrService![0]);
      // print(".....................");
      // print(lccResult.response!.seatDynamic);
      // print(lccResult.response!.seatDynamic![0]);
      // print(lccResult.response!.seatDynamic![0].segmentSeat);
      // print(lccResult.response!.seatDynamic![0].segmentSeat![0]);
      // print(lccResult.response!.seatDynamic![0].segmentSeat![0].rowSeats);
      // print(lccResult.response!.seatDynamic![0].segmentSeat![0].rowSeats![0]);
      // print(lccResult.response!.seatDynamic![0].segmentSeat![0].rowSeats![0].seats);
      // print(lccResult.response!.seatDynamic![0].segmentSeat![0].rowSeats![0].seats![0]);

      setState(() {
        LccBaggage = lccResult.response!.baggage![0];
        mealItems = lccResult.response!.mealDynamic![0];
        specialServices = lccResult.response!.specialServices;
        seatDynamic = lccResult.response!.seatDynamic;

        selectedOption = LccBaggage[0];
        selectedMeal = mealItems[0];
      });
    }
  }

  void getSeats(var body) {
// Parse the JSON string
    setState(() {
      if (FlightSeats.isNotEmpty) FlightSeats.clear();
    });

    var data = jsonDecode(body);

    // Extract seat information from SeatDynamic
    var seats = data['Response']['SeatDynamic'][0]['SegmentSeat'][0]['RowSeats']
        [1]['Seats'];
    var Rowseats = data['Response']['SeatDynamic'][0]['SegmentSeat'];

    for (var rowSeats in Rowseats) {
      // log(rowSeats.toString());
      FlightSeats.add(rowSeats);
    }

    // print(FlightSeats.length);

    // for (var flight in FlightSeats) {
    //   var rowSeats = flight["RowSeats"];
    //   for (var rowSeat in rowSeats) {
    //     var seats = rowSeat["Seats"];
    //     for (var seat in seats) {
    //       // print("Airline Code: ${seat["AirlineCode"]}");
    //       // print("Flight Number: ${seat["FlightNumber"]}");
    //       // print("Craft Type: ${seat["CraftType"]}");
    //       // print("Origin: ${seat["Origin"]}");
    //       // print("Destination: ${seat["Destination"]}");
    //       // print("Availability Type: ${seat["AvailablityType"]}");
    //       // print("Description: ${seat["Description"]}");
    //       print("Code: ${seat["Code"]}");
    //       print("Row No: ${seat["RowNo"]}");
    //       print("Seat No: ${seat["SeatNo"]}");
    //       // print("Seat Type: ${seat["SeatType"]}");
    //       // print("Seat Way Type: ${seat["SeatWayType"]}");
    //       // print("Compartment: ${seat["Compartment"]}");
    //       // print("Deck: ${seat["Deck"]}");
    //       // print("Currency: ${seat["Currency"]}");
    //       // print("Price: ${seat["Price"]}");
    //       // print("\n");
    //     }
    //   }
    // }
  }

  void getSSRWithoutLcc(token, traceId, resultIndex) async {
    print("lcc falseeee: $lcc");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');

    final response = await http.post(
      Uri.parse(api + 'api/flight/ssr'),
      body: jsonEncode({
        "EndUserIp": "$ips",
        "TokenId": "$token",
        "TraceId": "$traceId",
        "ResultIndex": "$resultIndex"
      }),
      headers: {"content-type": "application/json"},
    );

    // log(response.body);
    print(response.statusCode);

    setState(() {
      res = response.body;
    });

    if (response.body.contains("No SSR details found")) {
      setState(() {
        ssr = false;
      });
    }
  }
}
