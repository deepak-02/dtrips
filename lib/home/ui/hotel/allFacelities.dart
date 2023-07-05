import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../global.dart';

class AllFacilities extends StatefulWidget {
  AllFacilities({Key? key, this.common}) : super(key: key);
  final common;
  @override
  State<AllFacilities> createState() => _AllFacilitiesState();
}

class _AllFacilitiesState extends State<AllFacilities> {
  bool btnVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;

    return Stack(
      children: [
        Container(
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
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: btnVisible
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
                  } else if (notification.direction ==
                      ScrollDirection.reverse) {
                    if (btnVisible) setState(() => btnVisible = false);
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffffffff),
                                offset: Offset(0, 5),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenSize.width / 1.5,
                                      child: Text(
                                        "Property facilities",
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: "Metropolis",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(2, 2),
                                          blurRadius: 2.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              print("Popular Facilities : ");
                                              //print(hotelFacilities);
                                              log(hotelFacilities.toString());
                                            },
                                            child: Text(
                                              "Popular Facilities",
                                              style: TextStyle(
                                                fontFamily: "Metropolis",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            child: Wrap(
                                          spacing: 0,
                                          children: List.generate(
                                            widget.common.length,
                                            (index) {
                                              return Chip(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                backgroundColor:
                                                    Color(0xFFFFFFFF),
                                                avatar: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      Color(0xffffff),
                                                  child: Icon(
                                                    widget.common[index]
                                                        ["icon"],
                                                    size: 14,
                                                  ),
                                                ),
                                                label: Text(
                                                  "${widget.common[index]["name"]}",
                                                  style: TextStyle(
                                                    fontFamily: "Metropolis",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "All Facilities",
                                style: TextStyle(
                                  fontFamily: "Metropolis",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Wrap(
                                    spacing: 0,
                                    children: List.generate(
                                      hotelFacilities.length,
                                      (index) {
                                        return Chip(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          backgroundColor: Color(0xFFFFFFFF),
                                          avatar: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Color(0xffffff),
                                            child: Icon(
                                              Icons.circle_outlined,
                                              size: 14,
                                            ),
                                          ),
                                          label: Text(
                                            "${hotelFacilities[index]}",
                                            style: TextStyle(
                                              fontFamily: "Metropolis",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
