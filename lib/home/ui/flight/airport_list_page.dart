import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import '../../../db/Flight/airportSearchModel.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../dashboard.dart';

class AirportListPage extends StatefulWidget {
  const AirportListPage({Key? key, this.type}) : super(key: key);
  final type;

  @override
  State<AirportListPage> createState() => _AirportListPageState();
}

class _AirportListPageState extends State<AirportListPage> {
  bool loading = true;

  List<AirportListModel> _placelist = [];
  int onset = 0;
  int offset = 10;
  late int totalPages;
  TextEditingController searchController = new TextEditingController();

  final RefreshController refreshController1 =
      RefreshController(initialRefresh: false);

  Future getplace({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        offset = offset + 10;
      });
    } else {
      if (offset >= 500) {
        refreshController1.loadNoData();
        return false;
      }
    }

    final response = await http.post(
      Uri.parse('${api}api/city/get-flight'),
      body: jsonEncode({
        "off": onset,
        "on": offset,
        "keyword": searchController.text.toString().trim(),
        //"page": currentPage.toString()
      }),
      headers: {"content-type": "application/json"},
    );

    setState(() {
      onset = offset + 1;
      offset = offset + 10;
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      loading = false;
      final result = airportListModelFromJson(response.body);

      if (isRefresh) {
        _placelist = result;
      } else {
        _placelist.addAll(result);
      }

      print(response.body);
      setState(() {
        // totalPages = result.totalPages;
      });
      return true;
    } else {
      return false;
    }
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
          GestureDetector(
            onTap: () {
              if (!FocusScope.of(context).hasPrimaryFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                leadingWidth: 40,
                leading: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        offset = 10;
                        onset = 0;
                      });
                      Get.off(Dashboard());
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: //Image.asset('assets/images/icons/search.png'),
                            const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Color(0xff000000),
                        ),
                        onPressed: () async {
                          // searchController.clear();
                          await getplace(isRefresh: true);
                        },
                      ),
                      contentPadding: EdgeInsets.only(left: 20),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: screenSize.width / 20,
                        color: Color(0xff000000),
                      ),
                      //   border:
                      //   OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    autofocus: true,
                    onChanged: (value) async {
                      setState(() {
                        onset = 0;
                        offset = 10;
                      });
                      await getplace(isRefresh: true);
                      if (searchController.text.isEmpty ||
                          RegExp(r"^/s+$").hasMatch(searchController.text)) {
                        setState(() {
                          onset = 0;
                          offset = 10;
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 65,
              ),
              body: SafeArea(
                child: loading
                    ? Container(
                        child: Center(
                            child: Text(
                          "Search your destination...",
                          style: TextStyle(
                            fontSize: screenSize.width / 25,
                          ),
                        )),
                      )
                    : _placelist.isEmpty
                        ? Container(
                            child: Center(
                              child: Text(
                                "Empty",
                                style: TextStyle(
                                  fontSize: screenSize.width / 25,
                                ),
                              ),
                            ),
                          )
                        : SmartRefresher(
                            controller: refreshController1,
                            enablePullUp: true,
                            header: WaterDropHeader(
                              waterDropColor: Colors.purple,
                            ),
                            onRefresh: () async {
                              final result = await getplace(isRefresh: true);
                              if (result) {
                                refreshController1.refreshCompleted();
                              } else {
                                refreshController1.refreshFailed();
                              }
                            },
                            onLoading: () async {
                              // print("loading");
                              final result = await getplace(isRefresh: false);
                              if (result) {
                                refreshController1.loadComplete();
                              } else {
                                refreshController1.loadFailed();
                              }
                            },
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final items = _placelist[index];

                                return InkWell(
                                  onTap: () {
                                    print("destinationcode = " +
                                        items.destinationcode!);
                                    print(
                                        "airportname = " + items.airportname!);
                                    print(
                                        "airportcode = " + items.airportcode!);
                                    print("cityname = " + items.cityname!);
                                    print("citycode = " + items.cityname!);
                                    print(
                                        "countrycode = " + items.countrycode!);

                                    if (widget.type == "origin") {
                                      setState(() {
                                        fromPort = items.destinationcode!;
                                        fromPlace = items.cityname!;

                                        originCode = items.destinationcode!;
                                        originAirportName = items.airportname!;
                                        originAirportCode = items.airportcode!;
                                        originCityName = items.cityname!;
                                        originCityName = items.cityname!;
                                        originCountryCode = items.countrycode!;
                                        offset = 10;
                                        onset = 0;
                                      });
                                    } else {
                                      setState(() {
                                        toPort = items.destinationcode!;
                                        toPlace = items.cityname!;
                                        destinationCode =
                                            items.destinationcode!;
                                        destinationAirportName =
                                            items.airportname!;
                                        destinationAirportCode =
                                            items.airportcode!;
                                        destinationCityName = items.cityname!;
                                        destinationCityName = items.cityname!;
                                        destinationCountryCode =
                                            items.countrycode!;
                                        offset = 10;
                                        onset = 0;
                                      });
                                    }

                                    Get.off(Dashboard());
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.flight,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "${items.cityname!} ,${items.countrycode!}",
                                      style: TextStyle(
                                          fontSize: screenSize.width / 25,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "${items.airportname!}",
                                      style: TextStyle(
                                          fontSize: screenSize.width / 28,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              },
                              // separatorBuilder: (context, index) => SizedBox(),
                              itemCount: _placelist.length,
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
