import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../../widgets/customStepper.dart';
import 'package:http/http.dart' as http;

import '../../widgets/flightBottomSheets.dart';
import 'SeatSelection.dart';

class FlightCustomisePage extends StatefulWidget {
  const FlightCustomisePage(
      {Key? key, this.ResultIndex, this.TraceId, this.Token})
      : super(key: key);
  final ResultIndex;
  final TraceId;
  final Token;

  @override
  State<FlightCustomisePage> createState() => _FlightCustomisePageState();
}

class _FlightCustomisePageState extends State<FlightCustomisePage> {
  int currentStep = 0;
  final PageController pageController = PageController(initialPage: 0);
  var title = "Customise your flights";

  void incrementStep() {
    if (lcc) {
      if (pageController.page != 3) {
        pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      setState(() {
        currentStep = currentStep < 3 ? currentStep + 1 : currentStep;
        updateTitle();
      });
    } else {
      if (pageController.page != 2) {
        pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      setState(() {
        currentStep = currentStep < 2 ? currentStep + 1 : currentStep;
        updateTitle();
      });
    }
  }

  void decrementStep() {
    if (currentStep == 0) {
      Navigator.pop(context);
    }
    if (pageController.page != 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      currentStep = currentStep > 0 ? currentStep - 1 : currentStep;
      updateTitle();
    });
  }

  void updateTitle() {
    if (lcc) {
      switch (currentStep) {
        case 1:
          setState(() {
            title = "Select your seats";
          });
          break;
        case 2:
          setState(() {
            title = "Who's flying?";
          });
          break;
        case 3:
          setState(() {
            title = "Check and pay";
          });
          break;
        default:
          setState(() {
            title = "Customise your flights";
          });
      }
    } else {
      switch (currentStep) {
        case 0:
          setState(() {
            title = "Customise your flights";
          });
          break;
        case 1:
          setState(() {
            title = "Who's flying?";
          });
          break;
        case 2:
          setState(() {
            title = "Check and pay";
          });
          break;
        default:
          setState(() {
            title = "";
          });
      }
    }
  }

  // void updateTitle() {
  //   switch (currentStep) {
  //     case 1:
  //       title = "Select your seats";
  //       break;
  //     case 2:
  //       title = "Who's flying?";
  //       break;
  //     case 3:
  //       title = "Check and pay";
  //       break;
  //     default:
  //       title = "Customise your flights";
  //   }
  // }

  @override
  void initState() {
    // getSSR(widget.Token,widget.TraceId,widget.ResultIndex);
    setState(() {
      mealItems.isEmpty ? null : selectedMeal = mealItems[0];
      // selectedOption = baggageOptions[0];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("back btn ");
        decrementStep();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "$title",
            style: TextStyle(color: Colors.white),
          ),
          leading: GestureDetector(
              onTap: () {
                print(currentStep);
                decrementStep();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(40), // Set the preferred height of the stepper
            child: Padding(
              padding: const EdgeInsets.only(left: 70),
              child: GestureDetector(
                onTap: () {
                  print("ssr: $ssr");
                  print("lcc: $lcc");
                },
                child: CustomStepper(
                  currentStep: currentStep,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Rs. 165202.56",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Tooltip(
                          message: 'Price breakdown',
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const FlightPriceBreakdown(
                                      count: 3,
                                      tickets: 12345,
                                      fare: 321,
                                      tax: 112,
                                      discount: 100,
                                      totalPrice: 12678,
                                    );
                                  },
                                );
                              },
                              borderRadius: BorderRadius.circular(100),
                              child: const Icon(Icons.info_outline)),
                        ),
                      ],
                    ),
                    const Text("1 traveller"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  incrementStep();
                },
                style: ElevatedButton.styleFrom(
                  // padding: const EdgeInsets.symmetric(
                  // horizontal: 40.0, vertical: 20.0),
                  backgroundColor: Colors.purple,
                  // shadowColor: Colors.transparent,
                  // shape: const StadiumBorder(),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ListView.separated(
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: LccBaggage.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //
                      //     final items = LccBaggage[index];
                      //
                      //
                      //     return Container(
                      //       color: Colors.white,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(10),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               "${items.origin} - ${items.destination}",
                      //               style: TextStyle(
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //
                      //             SizedBox(
                      //               height: 20,
                      //             ),
                      //
                      //             Text(
                      //               "Airline Code: ${items.airlineCode}",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //             Text(
                      //               "Flight Number: ${items.flightNumber}",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //             Text(
                      //               "Airline Description: ${items.airlineDescription}",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //             Text(
                      //               "Code: ${items.code}",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //             Text(
                      //               "Baggage Weight: ${items.weight}",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //             Text(
                      //               "Way type: ${items.wayType}",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //             Text(
                      //               "Price: ₹${items.price}",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   }, separatorBuilder: (BuildContext context, int index) {
                      //   return Divider();
                      // },
                      // ),

                      if (LccBaggage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              print(lcc);
                            },
                            child: Text(
                              "Baggage",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      if (LccBaggage.isNotEmpty)
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: noOfAdult,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Traveller ${index + 1} (Adult)",
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Set the width to device width
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple),
                                      ),
                                    ),
                                    child: DropdownButton<dynamic>(
                                      value: selectedOption,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedOption = newValue;
                                        });
                                      },
                                      isExpanded: true,
                                      underline:
                                          Container(), // Remove the default underline
                                      items: LccBaggage.map<
                                          DropdownMenuItem<dynamic>>(
                                        (option) {
                                          return DropdownMenuItem<dynamic>(
                                            value: option,
                                            child: Text(
                                                'Weight: ${option.weight} KG, Price: ₹${option.price}'),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                      SizedBox(
                        height: 15,
                      ),

                      if (mealItems.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              // log(res);
                              print(LccBaggage);
                            },
                            child: Text(
                              "Meal choice",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                      if (mealItems.isNotEmpty)
                        Text(
                          "Request dietary preferences",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      if (mealItems.isNotEmpty)
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: noOfAdult,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Traveller ${index + 1} (Adult)",
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Set the width to device width
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<dynamic>(
                                    value: selectedMeal,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedMeal = newValue!;
                                      });
                                    },
                                    isExpanded: true,
                                    items: mealItems
                                        .map<DropdownMenuItem<dynamic>>(
                                            (value) {
                                      return DropdownMenuItem<dynamic>(
                                        value: value,
                                        child: Text(
                                            "${value.airlineDescription} (${value.code})"),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            );
                          },
                        ),

                      SizedBox(
                        height: 30,
                      ),

                      if (specialServices!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              // log(res);
                              print(LccBaggage);
                            },
                            child: Text(
                              "Special services",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                      SizedBox(
                        height: 10,
                      ),
                      if (specialServices!.isNotEmpty)
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: specialServices!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: specialServices![index]
                                    .segmentSpecialService!
                                    .length,
                                itemBuilder: (BuildContext context, int ind) {
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: specialServices![index]
                                          .segmentSpecialService![ind]
                                          .ssrService!
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .sentiment_satisfied_rounded,
                                                  size: 16,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${specialServices![index].segmentSpecialService![ind].ssrService![i].text}",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        "${specialServices![index].segmentSpecialService![ind].ssrService![i].currency}. ${specialServices![index].segmentSpecialService![ind].ssrService![i].price}",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        );
                                      });
                                });
                          },
                        ),
                    ],
                  ),
                ),
              ),
              if (lcc)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: FlightSeats.length,
                        itemBuilder: (BuildContext context, int index) {
                          var segment = selectedItem.segments![0][index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print(FlightSeats[index]['RowSeats'][0]
                                        ['Seats'][0]['Origin']);
                                    print(FlightSeats[index]['RowSeats'][0]
                                        ['Seats'][0]['Destination']);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SeatSelectionPage(
                                                origin: FlightSeats[index]
                                                        ['RowSeats'][0]['Seats']
                                                    [0]['Origin'],
                                                destination: FlightSeats[index]
                                                        ['RowSeats'][0]['Seats']
                                                    [0]['Destination'],
                                                index: index,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 20, 8, 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.flight_takeoff),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${FlightSeats[index]['RowSeats'][0]['Seats'][0]['Origin']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(Icons.arrow_right_alt),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(Icons.flight_land),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${FlightSeats[index]['RowSeats'][0]['Seats'][0]['Destination']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${formatDuration(segment.duration!)} - ${segment.airline!.airlineName}",
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "No seats selected",
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      // Center(
                      //   child: InkWell(
                      //     onTap: (){
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => SeatSelectionPage()),
                      //       );
                      //     },
                      //       child: Text("Page 2 , Seat selection")
                      //   ),
                      // ),
                    ],
                  ),
                ),
              SingleChildScrollView(
                child: Center(
                  child: Text("Page 3"),
                ),
              ),
              SingleChildScrollView(
                child: Center(
                  child: Text("Check and pay"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDuration(int duration) {
    int hours = duration ~/ 60;
    int minutes = duration % 60;

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return '$formattedHours h $formattedMinutes m';
  }
}
