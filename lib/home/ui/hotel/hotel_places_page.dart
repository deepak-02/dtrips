import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import '../../../db/Hotel/PlaceSearch.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../dashboard.dart';

class HotelPlacesPage extends StatefulWidget {
  const HotelPlacesPage({Key? key}) : super(key: key);

  @override
  State<HotelPlacesPage> createState() => _HotelPlacesPageState();
}

class _HotelPlacesPageState extends State<HotelPlacesPage> {
  bool loading = true;

  List<HotelPlaceSearch> _placelist = [];
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
      Uri.parse('${api}api/city/page'),
      body: jsonEncode({
        "off": onset,
        "on": offset,
        "keyword": searchController.text.isEmpty
            ? "india"
            : searchController.text.toString().trim(),
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
      final result = hotelPlaceSearchFromJson(response.body);

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
  void initState() {
    getplace(isRefresh: false);
    super.initState();
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
                                    setState(() {
                                      countryCode =
                                          _placelist[index].countrycode!;
                                      cityId = _placelist[index].cityid!;
                                      country = _placelist[index].country!;
                                      city = _placelist[index].destination!;
                                      offset = 10;
                                      onset = 0;
                                    });

                                    Get.off(Dashboard());
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.location_on,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "${_placelist[index].destination}",
                                      style: TextStyle(
                                          fontSize: screenSize.width / 25,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "${_placelist[index].country}",
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
