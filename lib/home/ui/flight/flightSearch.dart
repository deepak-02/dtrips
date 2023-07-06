import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/Flight/newsearchModel.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../../widgets/flightBottomSheets.dart';
import '../dashboard.dart';
import 'flightDetails.dart';
import 'package:http/http.dart' as http;

class FlightSearch extends StatefulWidget {
  const FlightSearch() : super();

  @override
  State<FlightSearch> createState() => _FlightSearchState();
}

class _FlightSearchState extends State<FlightSearch> {
  bool loading = true;

  List<Result> flightResult = [];

  int resultLength = 0;

  var TraceId = "";

  var Token = "";

  List<String> imagePaths = [];

  @override
  void initState() {
    flightDetails.clear();
    getData();
    loadImages();
    super.initState();
  }

  Future<void> loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = Map<String, dynamic>.from(json.decode(manifestContent));

    final imagePaths = manifestMap.keys
        .where((String key) => key.startsWith('assets/images/AirlineLogo'))
        .toList();

    setState(() {
      this.imagePaths = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.purple,
        leading: IconButton(
          tooltip: 'back',
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "$resultLength results",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "$originCode ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "$originCityName",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.arrow_right_alt),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "$destinationCode ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "$destinationCityName",
                                  style: TextStyle(
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
                                  "${DateFormat('E dd MMM').format(DateTime.parse(departureDate))}, ${noOfAdult + noOfChild + noOfInfant} Passengers, ${planeClassName}",
                                  style: TextStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.mode_edit_outlined),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: flightResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    var items = flightResult[index];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedItem = flightResult[index];
                          ClickLoading = true;
                          if (flightDetails.isNotEmpty) {
                            flightDetails.clear();
                          }
                          flightDetails.add(flightResult[index]);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightDetails(
                                    ResultIndex: items.resultIndex,
                                    TraceId: TraceId,
                                    Token: Token,
                                  )),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.segments![0].length,
                              itemBuilder: (BuildContext context, int index) {
                                var segment = items.segments![0][index];

                                String formatDuration(int duration) {
                                  int hours = duration ~/ 60;
                                  int minutes = duration % 60;

                                  String formattedHours =
                                      hours.toString().padLeft(2, '0');
                                  String formattedMinutes =
                                      minutes.toString().padLeft(2, '0');

                                  return '$formattedHours h $formattedMinutes m';
                                }

                                var airLogo =
                                    "assets/images/AirlineLogo/nologo.gif";

                                for (int i = 0; i < imagePaths.length; i++) {
                                  var imgPath = imagePaths[i];
                                  var imgName = imgPath
                                      .split('/')
                                      .last; // Extract the image name from the path
                                  var imgCode = imgName
                                      .split('.')
                                      .first; // Extract the code from the image name
                                  var airCode = segment.airline!.airlineCode;

                                  if (imgCode.toLowerCase() ==
                                      airCode!.toLowerCase()) {
                                    // print(airCode);
                                    // print(imgCode);
                                    airLogo = imgPath;
                                  }
                                }

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${DateFormat.Hm().format(DateTime.parse(segment.origin!.depTime.toString()))}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${segment.origin!.airport!.airportCode}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${DateFormat('dd MMM').format(DateTime.parse(segment.origin!.depTime.toString()))}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${formatDuration(segment.duration!)}",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    // "1 stop",
                                                    "${segment.flightStatus}",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${DateFormat.Hm().format(DateTime.parse(segment.destination!.arrTime.toString()))}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${segment.destination!.airport!.airportCode}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${DateFormat('dd MMM').format(DateTime.parse(segment.destination!.arrTime.toString()))}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          // Icon(
                                          //     Icons.airplane_ticket_rounded
                                          // ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 50,
                                            child: Image.asset(
                                              airLogo,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${segment.airline!.airlineName}",
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons
                                                      .shopping_bag_outlined),
                                                  Icon(Icons.luggage_outlined),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Included: cabin bag,",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "checked bag",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Text(
                                            segment.noOfSeatAvailable == null
                                                ? ""
                                                : "${segment.noOfSeatAvailable} left at this price on Dtrips.com",
                                            style:
                                                TextStyle(color: Colors.brown),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Rs.${double.parse((items.fare!.tax! + items.fare!.otherCharges! + items.fare!.baseFare! - items.fare!.discount!).toStringAsFixed(2))}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return FlightPriceBreakdown(
                                                    count: noOfAdult + noOfChild + noOfInfant,
                                                    tickets: double.parse(items.fare!.publishedFare!.toStringAsFixed(2)),
                                                    fare: double.parse(items.fare!.baseFare!.toStringAsFixed(2)),
                                                    tax: double.parse(items.fare!.tax!.toStringAsFixed(2)) + double.parse(items.fare!.otherCharges!.toStringAsFixed(2)),
                                                    discount: items.fare!.discount,
                                                    totalPrice: double.parse((items.fare!.tax! + items.fare!.otherCharges! + items.fare!.baseFare! - items.fare!.discount!).toStringAsFixed(2)),
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Rs. ${double.parse(((items.fare!.tax! + items.fare!.otherCharges! + items.fare!.baseFare! - items.fare!.discount!) * (noOfAdult + noOfChild + noOfInfant)).toStringAsFixed(2))} for all travellers", //price * number of travellers
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 10,
                      color: Colors.grey[200],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
// Uri.parse(api + 'api/flight/search'),'http://api.tektravels.com/BookingEngineService_Air/AirService.svc/rest/Search/'
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');

    var segments = [
      {
        "Origin": "$originCode",
        "Destination": "$destinationCode",
        "FlightCabinClass": "$planeClassType",
        "PreferredDepartureTime": "$departureDate", //"2023-05-26T00: 00: 00",
        "PreferredArrivalTime": "$returnDate" //"2023-05-27T00: 00: 00"
      }
    ];

    if (journeyType == 1) {
      setState(() {
        segments = [
          {
            "Origin": "$originCode",
            "Destination": "$destinationCode",
            "FlightCabinClass": "$planeClassType",
            "PreferredDepartureTime":
                "$departureDate", //"2023-05-26T00: 00: 00",
            "PreferredArrivalTime": "$returnDate" //"2023-05-27T00: 00: 00"
          }
        ];
      });
    } else if (journeyType == 2) {
      setState(() {
        segments = [
          {
            "Origin": "$originCode",
            "Destination": "$destinationCode",
            "FlightCabinClass": "$planeClassType",
            "PreferredDepartureTime":
                "$departureDate", //"2023-05-26T00: 00: 00",
            "PreferredArrivalTime": "$departureDate" //"2023-05-27T00: 00: 00"
          },
          {
            "Origin": "$originCode",
            "Destination": "$destinationCode",
            "FlightCabinClass": "$planeClassType",
            "PreferredDepartureTime": "$returnDate", //"2023-05-26T00: 00: 00",
            "PreferredArrivalTime": "$returnDate" //"2023-05-27T00: 00: 00"
          }
        ];
      });
    } else {}

    final response = await http.post(
      Uri.parse(api + 'api/flight/search'),
      body: jsonEncode({
        "EndUserIp": "$ips",
        // "TokenId": "02651000-5593-43cc-ac84-5147ecb90ca3",
        "AdultCount": "$noOfAdult",
        "ChildCount": "$noOfChild",
        "InfantCount": "$noOfInfant",
        "DirectFlight": "false",
        "OneStopFlight": "false",
        "JourneyType": "$journeyType",
        "PreferredAirlines": null,
        "Segments": segments,
        "Sources": null
      }),
      headers: {"content-type": "application/json"},
    );

    print(response.statusCode);
    // log(response.body);

    if (response.statusCode == 200) {
      final result = newSearchModelFromJson(response.body);

      setState(() {
        loading = false;
      });

      if (result.response!.error!.errorCode != 0) {
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
              "${result.response!.error!.errorCode}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              "${result.response!.error!.errorMessage}",
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
                    onPressed: () {
                      Navigator.pop(context);
                      getData();
                    },
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        color: Colors.purple,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.purple,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.off(() => Dashboard()),
                    child: const Text(
                      'Go Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Colors.purple,
                          width: 1.0,
                        ),
                      ),
                      backgroundColor: Colors.purple,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }

      setState(() {
        TraceId = result.response!.traceId!;
        Token = result.token!;

        resultLength = result.response!.results![0].length;
        flightResult = result.response!.results![0];
        // flightResult.addAll(result.response!.results as Iterable<Result>);
        print("added");
      });
    } else if (response.statusCode == 504) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: Container(
            height: 100,
            child:
                Lottie.asset('assets/lottie/error-x.json', fit: BoxFit.contain),
          ),
          title: Text(
            "504",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'Metropolis',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Gateway Time-out",
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
                  onPressed: () {
                    Navigator.pop(context);
                    getData();
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.purple,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.purple,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.off(() => Dashboard()),
                  child: const Text(
                    'Go Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Colors.purple,
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: Container(
            height: 100,
            child:
                Lottie.asset('assets/lottie/error-x.json', fit: BoxFit.contain),
          ),
          title: Text(
            "${response.statusCode}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'Metropolis',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Something Wrong",
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
                  onPressed: () {
                    Navigator.pop(context);
                    getData();
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.purple,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.purple,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.off(() => Dashboard()),
                  child: const Text(
                    'Go Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Colors.purple,
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
