import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:readmore/readmore.dart';
import '../../global.dart';
import 'BookingRoomSelection.dart';
import 'HotelGalleryPage.dart';
import 'package:http/http.dart' as http;
import 'allFacelities.dart';
import 'map.dart';

class SingleHotelPage extends StatefulWidget {
  const SingleHotelPage({
    Key? key,
    this.discription,
    this.rating,
    this.price,
    this.address,
    this.categoryId,
    this.picture,
    this.images,
    this.latitude,
    this.longitude,
    this.name,
    this.contact,
    this.hotelMap,
    this.hotelPolicy,
    this.hotelFacilities,
    this.night,
    this.checkout,
    this.checkin,
    this.hotelCode,
    this.traceId,
    this.resultIndex,
    this.categoryIndex,
    this.tokenId,
    this.Datein,
    this.Dateout,
  }) : super(key: key);

  final discription;
  final rating;
  final price;
  final address;
  final categoryId;
  final picture;
  final images;
  final latitude;
  final longitude;
  final name;
  final contact;
  final hotelMap;
  final hotelPolicy;
  final hotelFacilities;
  final night;
  final checkout;
  final checkin;
  final hotelCode;
  final traceId;
  final resultIndex;
  final categoryIndex;
  final tokenId;
  final Datein;
  final Dateout;

  @override
  State<SingleHotelPage> createState() => _SingleHotelPageState();
}

class _SingleHotelPageState extends State<SingleHotelPage> {
  List common = [];

  bool btnVisible = true;
  @override
  void initState() {
    super.initState();
    common = [];

    for (int i = 0; i < hotelFacilities.length; i++) {
      for (int j = 0; j < commonFacilities.length; j++) {
        if (hotelFacilities[i] == commonFacilities[j]['name']) {
          common.add(commonFacilities[j]);
          print("added $j");
        }
      }
    }

    // print("discription:${widget.discription} ");
    // print("address: ${widget.address}");
    // print("contact : ${widget.contact}");
    // print("Name : ${widget.name}");
    // print("images: ${widget.images}");
    // print("location: ${widget.latitude},${widget.longitude}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;

    List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                // margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${imgList.indexOf(item) + 1}/${imgList.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ))
        .toList();

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
                        Get.back(result: true);
                        setState(() {
                          imgList = [];
                          hotelFacilities = [];
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : null,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 56,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                                fontFamily: "Metropolis",
                                fontSize: screenSize.width / 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                          Text(
                            "₹${widget.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontFamily: "Metropolis",
                                fontSize: screenSize.width / 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff92278f)),
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
                        hotelRoomDetail.clear();
                        hotelRoomDetail1.clear();
                        Get.to(BookRoomSelection(
                          hotelCode: widget.hotelCode,
                          resultIndex: widget.resultIndex,
                          traceId: widget.traceId,
                          tokenId: widget.tokenId,
                          night: widget.night,
                          checkin: widget.checkin,
                          checkout: widget.checkout,
                          hotelName: widget.name,
                          categoryId: widget.categoryId,
                          Dateout: widget.Dateout,
                          Datein: widget.Datein,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        "Select rooms",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width / 23,
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
                      imgList.isEmpty || imgList.length <= 1
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/no-image-available.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imgList = widget.images;
                                    hotelFacilities = widget.hotelFacilities;
                                  });
                                  Get.to(() => HotelGallery(
                                        images: widget.images,
                                      ));
                                },

                                // child: CarouselSlider(
                                //   options: CarouselOptions(
                                //     clipBehavior: Clip.none,
                                //     aspectRatio: 2,
                                //     viewportFraction: 1.0,
                                //   ),
                                //   items: imageSliders,
                                // ),

                                child: StaggeredGrid.count(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 3,
                                  crossAxisSpacing: 3,
                                  children: [
                                    imgList.length < 3
                                        ? Container()
                                        : StaggeredGridTile.count(
                                            crossAxisCellCount: 2,
                                            mainAxisCellCount: 2,
                                            child: Container(
                                              child: Image.network(
                                                imgList[0],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    imgList.length < 2
                                        ? Container()
                                        : StaggeredGridTile.count(
                                            crossAxisCellCount: 2,
                                            mainAxisCellCount: 1,
                                            child: Container(
                                              child: Image.network(
                                                imgList[1],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    imgList.length <= 1
                                        ? Container()
                                        : StaggeredGridTile.count(
                                            crossAxisCellCount: 1,
                                            mainAxisCellCount: 1,
                                            child: Container(
                                              child: Image.network(
                                                imgList[2],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    imgList.length < 3
                                        ? Container()
                                        : StaggeredGridTile.count(
                                            crossAxisCellCount: 1,
                                            mainAxisCellCount: 1,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            imgList[3]),
                                                        fit: BoxFit.cover)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: new BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.6)),
                                                  child: Text(
                                                    "+${imgList.length - 3}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                  ),
                                                )),
                                          ),
                                  ],
                                ),
                              ),
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
                                        "${widget.name}",
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: "Metropolis",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   child: IconButton(
                                    //       onPressed: () {},
                                    //       icon: Icon(
                                    //         Iconsax.heart5,
                                    //         size: 30,
                                    //         color: Colors.red,
                                    //       )),
                                    // )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: widget.rating,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Rating : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color(0xfff04e6e),
                                      ),
                                      alignment: Alignment.center,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // height: 30,
                                        // width: 45,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "${widget.rating}",
                                            style: TextStyle(
                                                fontFamily: "Metropolis",
                                                fontWeight: FontWeight.w100,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Stack(children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          'assets/images/city-map.png',
                                        ),
                                      ),
                                    ),
                                    height: screenSize.height / 6.8,
                                  ),
                                  Container(
                                    height: screenSize.height / 6.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color(0xffffffff),
                                        gradient: LinearGradient(
                                            begin: FractionalOffset.centerRight,
                                            end: FractionalOffset.center,
                                            colors: [
                                              Color(0xFFFFFF).withOpacity(0.0),
                                              Color(0xfff6f6f6),
                                            ],
                                            stops: [
                                              0.0,
                                              1.0
                                            ])),
                                  ),
                                  Container(
                                    height: screenSize.height / 6.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 50, top: 5),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: ReadMoreText(
                                                        widget.address == null
                                                            ? "No data available"
                                                            : "${widget.address}",
                                                        trimLines: 4,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Metropolis",
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                        trimMode: TrimMode.Line,
                                                        trimCollapsedText:
                                                            ' Show more',
                                                        trimExpandedText:
                                                            '   Show less',
                                                        lessStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff92278f)),
                                                        moreStyle: TextStyle(
                                                            fontSize: screenSize
                                                                    .width /
                                                                26,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff92278f)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30, top: 5),
                                                  child: ReadMoreText(
                                                    widget.contact == null
                                                        ? "No data available!"
                                                        : "${widget.contact}",
                                                    trimLines: 4,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Metropolis",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            screenSize.width /
                                                                26,
                                                        color: Colors.black),
                                                    trimMode: TrimMode.Line,
                                                    trimCollapsedText:
                                                        ' Show more',
                                                    trimExpandedText:
                                                        '   Show less',
                                                    lessStyle: TextStyle(
                                                        fontSize:
                                                            screenSize.width /
                                                                26,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff92278f)),
                                                    moreStyle: TextStyle(
                                                        fontSize:
                                                            screenSize.width /
                                                                26,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff92278f)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  widget.longitude == null &&
                                              widget.latitude == null ||
                                          widget.longitude == "" &&
                                              widget.latitude == ""
                                      ? Container()
                                      : Container(
                                          padding: EdgeInsets.only(
                                              top: 40, bottom: 40, right: 20),
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  widget.longitude == ""
                                                      ? null
                                                      :
                                                      // Get.to(LocationPage(
                                                      //         longitude: double.parse(
                                                      //             widget.longitude),
                                                      //         latitude: double.parse(
                                                      //             widget.latitude),
                                                      //         name: widget.name,
                                                      //         description: widget.address,
                                                      //       ));

                                                      await MapLauncher
                                                          .showMarker(
                                                          mapType:
                                                              MapType.google,
                                                          coords: Coords(
                                                              double.parse(widget
                                                                  .latitude),
                                                              double.parse(widget
                                                                  .longitude)),
                                                          title:
                                                              '${widget.name}',
                                                        );
                                                },
                                                child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Image.asset(
                                                        'assets/images/icons/location.png')),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "MAP",
                                                style: TextStyle(
                                                  fontFamily: "Metropolis",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ]),
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
                                          offset: Offset(3, 3),
                                          blurRadius: 3.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Check-in & Check-out",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Metropolis",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black45),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      "${widget.Datein} - ${widget.Dateout}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Metropolis",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                      "${widget.night} night",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Metropolis",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.black26,
                                              height: 50,
                                              width: 1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Rooms & Guest",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Metropolis",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black45),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.door_front_door,
                                                        color: Colors.black26,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "${StoredGuest.length}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Metropolis",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Icon(
                                                        Icons.people,
                                                        color: Colors.black26,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "${GuestCount}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Metropolis",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
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
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
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
                                        InkWell(
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
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Wrap(
                                          spacing: 0,
                                          children: List.generate(
                                            common.length,
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
                                                    common[index]["icon"],
                                                    size: 14,
                                                  ),
                                                ),
                                                label: Text(
                                                  "${common[index]["name"]}",
                                                  style: TextStyle(
                                                    fontFamily: "Metropolis",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.to(AllFacilities(
                                                    common: common,
                                                  ));
                                                },
                                                child: Text(
                                                  "See All Facilities",
                                                  style: TextStyle(
                                                    fontFamily: "Metropolis",
                                                    fontSize: 14,
                                                    color: Colors.purple,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(5, 5),
                                  blurRadius: 5.0,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
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
                                Card(
                                  color: Colors.white,
                                  elevation: 1,
                                  child: Html(data: widget.discription),
                                ),
                              ],
                            ),
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
