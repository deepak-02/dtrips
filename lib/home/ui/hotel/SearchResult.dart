import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtrips/home/ui/hotel/rooms_page.dart';
import 'package:dtrips/home/ui/hotel/single_hotel_page.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/Hotel/StaticDataModel.dart';
import '../../../db/Hotel/SingleHotelModel.dart';
import '../../../db/Hotel/hotel_model.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../dashboard.dart';

class SearchResult extends StatefulWidget {
  const SearchResult(
      {Key? key,
      this.night,
      this.checkinDate,
      this.checkoutDate,
      this.inDate,
      this.outdate,
      this.countryCode,
      this.cityId,
      this.city,
      this.restorationId})
      : super(key: key);
  final night;
  final checkinDate;
  final checkoutDate;
  final inDate;
  final outdate;
  final countryCode;
  final cityId;
  final city;
  final String? restorationId;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

enum SORT { pop, pL2H, pH2L, rL2H, rH2L, name }

class _SearchResultState extends State<SearchResult>
    with RestorationMixin, AutomaticKeepAliveClientMixin<SearchResult> {
  String? newValue;
  SORT? _new = SORT.pop;
  var body = "empty";
  bool loading = true;
  var sts = 0;
  var categoryId = '';
  var traceId = "";
  var tokenId = "";

  int hotelCount = 20;
  int totalHotels = 0;
  bool pullUp = false;
  bool pullDown = false;
  List<HotelResult> searchResult = [];
  List<HotelResult> showHotels = [];

  final _scrollController = ScrollController();

  List<HotelInfoResult> singleResult = [];
  final TextEditingController _controller = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<BasicPropertyInfo> imgResult = [];

  bool searchBar = false;
  FocusNode myfocus = FocusNode();

  bool loop = false;
  List storeCache = [];

  void _onLoading() async {
    // monitor network fetch
    pullUp ? getMore() : null;
  }

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      sts = 0;
      hotelCount = 20;
      // pullUp = true;
      pullUp = false;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    // print('refreshed');
    setState(() {
      searchResult.clear();
      showHotels.clear();
      imgResult.clear();
      loop = false;
    });
    getHotel();

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _endDate =
      RestorableDateTimeN(DateTime.now().add(const Duration(days: 1)));
  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      setState(() {});
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;

        // print(_startDate.value);
        // print(_endDate.value);

        inDate = DateFormat('dd MMM').format(_startDate.value as DateTime);

        outDate = DateFormat('dd MMM').format(_endDate.value as DateTime);

        chechinDate = DateFormat('yyyy-MM-dd')
            .format(_startDate.value as DateTime)
            .toString();

        checkOutDate = DateFormat('yyyy-MM-dd')
            .format(_endDate.value as DateTime)
            .toString();

        passDate1 = DateFormat('dd MMM')
            .format(_startDate.value as DateTime)
            .toString();
        passDate2 =
            DateFormat('dd MMM').format(_endDate.value as DateTime).toString();

        var day1 = _startDate.value as DateTime;
        var day2 = _endDate.value as DateTime;
        night = day2.difference(day1).inDays;
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime.now(),
          currentDate: DateTime.now(),
          lastDate: DateTime(2099),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }
    return null;
  }

  @override
  void initState() {
    // print(StoredGuest.length);
    // print(StoredGuest);
    // print(widget.checkinDate);
    // print(widget.night);
    loop = false;
    getHotel();
    myfocus.addListener(() {
      if (myfocus.hasFocus) {
        //print("Textfield one got focused.");
      } else {
        print("TextField one got unfocued.");
        setState(() {
          searchBar = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    int appbarGuest = GuestCount;
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1.0),
            Color.fromRGBO(255, 255, 255, 1.0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: loading
          ? Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!FocusScope.of(context).hasPrimaryFocus) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: sts == 200
                        ? AppBar(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            centerTitle: false,
                            automaticallyImplyLeading: false,
                            toolbarHeight: 80,
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1, right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              searchBar
                                                  ? setState(() {
                                                      searchBar = false;
                                                    })
                                                  : Get.off(Dashboard());
                                            },
                                            child: const Icon(
                                              Icons.arrow_back,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        searchBar
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8.0),
                                                width: screenSize.width / 1.3,
                                                child: TextField(
                                                  controller: _controller,
                                                  focusNode: myfocus,
                                                  autofocus: true,
                                                  textInputAction:
                                                      TextInputAction.search,
                                                  // maxLength: 60,
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  onChanged: (text) {
                                                    setState(() {});
                                                  },
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    suffixIcon: hidingIcon(),
                                                    hintText: 'Search Hotels',
                                                    hintStyle: TextStyle(
                                                      fontFamily: 'Metropolis',
                                                      fontSize: MediaQuery.of(
                                                                  context)
                                                              .textScaleFactor *
                                                          16,
                                                      color: const Color(
                                                          0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                "${widget.city}",
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          20,
                                                  color: Colors.black,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ],
                                    ),
                                    searchBar
                                        ? Container()
                                        : Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.search,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    searchBar = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(const RoomSelectionPage(
                                              page: "search",
                                            ));
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                " $appbarGuest guest  ",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.purple),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _restorableDateRangePickerRouteFuture
                                                .present();
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_month,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                " $inDate - $outDate",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.purple),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Color(0xFFE9D4E9),
                                            //     offset: Offset(2, 3),
                                            //     blurRadius: 5.0,
                                            //     spreadRadius: 2,
                                            //   ),
                                            // ],
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              stops: [0.0, 1.0],
                                              colors: [
                                                Color(0xff92278f),
                                                Color(0xff92278f),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                sts = 0;
                                                searchResult.clear();
                                                showHotels.clear();
                                                imgResult.clear();
                                                loop = false;
                                              });
                                              getHotel();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 40.0, vertical: 20.0),
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              shape: const StadiumBorder(),
                                            ),
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenSize.width / 35,
                                                fontFamily: 'Metropolis',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.all(10.0),
                                              child: Wrap(
                                                children: <Widget>[
                                                  Center(
                                                      child: Container(
                                                          height: 4.0,
                                                          width: 50.0,
                                                          color: const Color(
                                                              0xFF32335C))),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'popularity',
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ),
                                                          Radio<SORT>(
                                                            value: SORT.pop,
                                                            groupValue: _new,
                                                            onChanged: (value) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _new = value;
                                                                _new == SORT.pop
                                                                    ? showHotels.sort((a, b) => a
                                                                        .price!
                                                                        .roomPrice!
                                                                        .compareTo(b
                                                                            .price!
                                                                            .roomPrice!
                                                                            .toInt()))
                                                                    : null;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Price (lowest - highest)',
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ),
                                                          Radio<SORT>(
                                                            value: SORT.pL2H,
                                                            groupValue: _new,
                                                            onChanged:
                                                                (SORT? value) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _new = value;
                                                                _new == SORT.pL2H
                                                                    ? showHotels.sort((a, b) => a
                                                                        .price!
                                                                        .roomPrice!
                                                                        .compareTo(b
                                                                            .price!
                                                                            .roomPrice!
                                                                            .toInt()))
                                                                    : null;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Price (highest - lowest)',
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ),
                                                          Radio<SORT>(
                                                            value: SORT.pH2L,
                                                            groupValue: _new,
                                                            onChanged:
                                                                (SORT? value) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _new = value;
                                                                _new == SORT.pH2L
                                                                    ? showHotels.sort((b, a) => a
                                                                        .price!
                                                                        .roomPrice!
                                                                        .compareTo(b
                                                                            .price!
                                                                            .roomPrice!
                                                                            .toInt()))
                                                                    : null;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Star rating (0-5)',
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ),
                                                          Radio<SORT>(
                                                            value: SORT.rL2H,
                                                            groupValue: _new,
                                                            onChanged:
                                                                (SORT? value) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _new = value;
                                                                _new == SORT.rL2H
                                                                    ? showHotels.sort((a, b) => a
                                                                        .starRating!
                                                                        .compareTo(
                                                                            b.starRating!))
                                                                    : null;
                                                                print(value);
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Star rating (5-0)',
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ),
                                                          Radio<SORT>(
                                                            value: SORT.rH2L,
                                                            groupValue: _new,
                                                            onChanged:
                                                                (SORT? value) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _new = value;
                                                                _new == SORT.rH2L
                                                                    ? showHotels.sort((b, a) => a
                                                                        .starRating!
                                                                        .compareTo(
                                                                            b.starRating!))
                                                                    : null;
                                                                print(value);
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Name (A-Z)',
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ),
                                                          Radio<SORT>(
                                                            value: SORT.name,
                                                            groupValue: _new,
                                                            onChanged:
                                                                (SORT? value) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _new = value;
                                                                _new == SORT.name
                                                                    ? showHotels.sort((a, b) => a
                                                                        .hotelName!
                                                                        .toLowerCase()
                                                                        .compareTo(b
                                                                            .hotelName!
                                                                            .toLowerCase()))
                                                                    : null;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.swap_vert_outlined,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Sort",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Get.to(HotelFilter());
                                    //   },
                                    //   child: Container(
                                    //     child: Row(
                                    //       children: [
                                    //         Icon(
                                    //           Icons.filter_list,
                                    //           color: Colors.black,
                                    //         ),
                                    //         Text(
                                    //           "Filters",
                                    //           style: TextStyle(
                                    //               fontSize: 14,
                                    //               color: Colors.black),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ),
                          )
                        : null,
                    body: SafeArea(
                      child: SmartRefresher(
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        enablePullDown: pullDown,
                        enablePullUp: pullUp,
                        header: const WaterDropHeader(
                          waterDropColor: Colors.purple,
                        ),
                        child: _check(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Container(
                  child: Lottie.asset('assets/lottie/loading.json',
                      fit: BoxFit.contain)),
            ),
    );
  }

  _check() {
    if (sts == 200) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text("Showing ${showHotels.length} of $totalHotels"),
                ],
              ),
            ),
            PageStorage(
              bucket: PageStorageBucket(),
              child: ListView.builder(
                  key: const PageStorageKey<String>('page'),
                  controller: _scrollController,
                  itemCount: showHotels.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // loop == false
                    //     ? getImage(searchResult[index].hotelCode)
                    //     : null;
                    // loop == false ? print('loop') : null;
                    // for(int i =0; i<searchResult.length; i++){
                    //   getImage(searchResult[i].hotelCode);
                    //   print('loop');
                    //   for(int j = 0; j<imgResult.length; j++){
                    //     if(searchResult[i].hotelCode == imgResult[j].tboHotelCode){
                    //       searchResult[i].hotelPicture = imgResult[j].vendorMessages!.vendorMessage!.subSection!.paragraph!.url;
                    //     }
                    //   }
                    // }
                    // loop == false ? getImageLoop() : null;
                    // print('loop build');

                    final items = showHotels[index];

                    //final img = imgResults.isNotEmpty ? imgResults[index].vendorMessages!.vendorMessage!.subSection!.paragraph!.url : null;

                    if (_controller.text.isEmpty) {
                      if (showHotels[index].supplierHotelCodes!.isEmpty) {
                        return Container();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  print(index);
                                  // print(img);
                                  print(items.hotelCode);
                                  // print(searchResult[index].supplierHotelCodes!.isEmpty?'null':searchResult[index].supplierHotelCodes![0].categoryId);
                                  goToSingle(index);
                                  setState(() {
                                    SaveImg = items.hotelPicture.toString();
                                  });
                                  //print("cache : ${storeCache[index].hotelCode}");
                                  // print("length : ${storeCache.length}");
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 280,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              8), // Image radius
                                          child: CachedNetworkImage(
                                            imageUrl: "${items.hotelPicture}",
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 280,
                                              width: 140,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/no-img.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Image.network(
                                          //   items.hotelPicture.toString(),
                                          //   fit: BoxFit.cover,
                                          //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          //     if (loadingProgress == null) {
                                          //       return child;
                                          //     }
                                          //     return Center(
                                          //       child: CircularProgressIndicator(
                                          //         value: loadingProgress.expectedTotalBytes != null
                                          //             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          //             : null,
                                          //       ),
                                          //     );
                                          //   },
                                          //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                          //     return Container(
                                          //       height: 225,
                                          //       width: 130,
                                          //       decoration: BoxDecoration(
                                          //         color: Colors.black,
                                          //         image: DecorationImage(
                                          //           image: AssetImage("assets/images/no-img.png"),
                                          //           fit: BoxFit.cover,
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${items.hotelName}",
                                                maxLines: 2,
                                                overflow: TextOverflow.visible,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${items.hotelDescription}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            26,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons.location_city,
                                                        size: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${items.hotelAddress}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              26,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RatingBarIndicator(
                                                rating: items.starRating!
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                direction: Axis.horizontal,
                                              ),
                                              Text(
                                                "Rating : ${items.starRating}",
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      color: Colors.green,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                          "Service Charge : ₹${items.price!.serviceCharge}",
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  32,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Text("Rating : ${items.starRating}",),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "$night ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Icon(
                                                            Icons.nights_stay,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " night - $GuestCount ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Icon(
                                                            Icons.person,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " guest",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    // Text(
                                                    //   "Price: ",
                                                    //   maxLines: 1,
                                                    //   overflow: TextOverflow.clip,
                                                    //   style: TextStyle(
                                                    //     fontSize:
                                                    //     MediaQuery.of(context)
                                                    //         .size
                                                    //         .width /
                                                    //         26,
                                                    //
                                                    //   ),
                                                    // ),
                                                    Text(
                                                      "₹${items.price!.roomPrice.toStringAsFixed(2)}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       right: 10, bottom: 5),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.end,
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.end,
                                              //     children: [
                                              //       Flexible(
                                              //         child: Text(
                                              //           "+ ₹${items.price!.otherCharges} Tax & charges",
                                              //           maxLines: 3,
                                              //           overflow:
                                              //               TextOverflow.clip,
                                              //           style: TextStyle(
                                              //               fontSize: MediaQuery.of(
                                              //                           context)
                                              //                       .size
                                              //                       .width /
                                              //                   30,
                                              //               color: Colors.grey),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.hotel,
                                                      size: 15,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " ${items.hotelCategory}",
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              32,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.room_service,
                                                      size: 15,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " ${items.hotelPromotion}",
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              32,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 20,
                                indent: 10,
                                endIndent: 10,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    // return searchResult[index].supplierHotelCodes!.isEmpty
                    //     ? Container()
                    //     :
                    // else if(searchResult[index].supplierHotelCodes!.isEmpty) {
                    //   return Container();
                    // }
                    else if (items.hotelName!
                        .toString()
                        .toLowerCase()
                        .contains(_controller.text.toLowerCase())) {
                      if (showHotels[index].supplierHotelCodes!.isEmpty) {
                        return Container();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  //print(index);
                                  // print(img);
                                  // print(searchResult[index].hotelCode);
                                  // print(searchResult[index].supplierHotelCodes!.isEmpty?'null':searchResult[index].supplierHotelCodes![0].categoryId);
                                  goToSingle(index);
                                  setState(() {
                                    SaveImg = items.hotelPicture.toString();
                                  });
                                  //print("cache : ${storeCache[index].hotelCode}");
                                  // print("length : ${storeCache.length}");
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 280,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              8), // Image radius
                                          child: CachedNetworkImage(
                                            imageUrl: "${items.hotelPicture}",
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 280,
                                              width: 140,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/no-img.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Image.network(
                                          //   items.hotelPicture.toString(),
                                          //   fit: BoxFit.cover,
                                          //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          //     if (loadingProgress == null) {
                                          //       return child;
                                          //     }
                                          //     return Center(
                                          //       child: CircularProgressIndicator(
                                          //         value: loadingProgress.expectedTotalBytes != null
                                          //             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          //             : null,
                                          //       ),
                                          //     );
                                          //   },
                                          //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                          //     return Container(
                                          //       height: 225,
                                          //       width: 130,
                                          //       decoration: BoxDecoration(
                                          //         color: Colors.black,
                                          //         image: DecorationImage(
                                          //           image: AssetImage("assets/images/no-img.png"),
                                          //           fit: BoxFit.cover,
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${items.hotelName}",
                                                maxLines: 2,
                                                overflow: TextOverflow.visible,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${items.hotelDescription}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            26,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons.location_city,
                                                        size: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${items.hotelAddress}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              26,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RatingBarIndicator(
                                                rating: items.starRating!
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                direction: Axis.horizontal,
                                              ),
                                              Text(
                                                "Rating : ${items.starRating}",
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      color: Colors.green,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                          "Service Charge : ₹${items.price!.serviceCharge}",
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  32,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Text("Rating : ${items.starRating}",),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "$night ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Icon(
                                                            Icons.nights_stay,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " night - $GuestCount ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Icon(
                                                            Icons.person,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " guest",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    // Text(
                                                    //   "Price: ",
                                                    //   maxLines: 1,
                                                    //   overflow: TextOverflow.clip,
                                                    //   style: TextStyle(
                                                    //     fontSize:
                                                    //     MediaQuery.of(context)
                                                    //         .size
                                                    //         .width /
                                                    //         26,
                                                    //
                                                    //   ),
                                                    // ),
                                                    Text(
                                                      "₹${items.price!.roomPrice.toStringAsFixed(2)}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       right: 10, bottom: 5),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.end,
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.end,
                                              //     children: [
                                              //       Flexible(
                                              //         child: Text(
                                              //           "+ ₹${items.price!.otherCharges} Tax & charges",
                                              //           maxLines: 3,
                                              //           overflow:
                                              //               TextOverflow.clip,
                                              //           style: TextStyle(
                                              //               fontSize: MediaQuery.of(
                                              //                           context)
                                              //                       .size
                                              //                       .width /
                                              //                   30,
                                              //               color: Colors.grey),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.hotel,
                                                      size: 15,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " ${items.hotelCategory}",
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              32,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.room_service,
                                                      size: 15,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " ${items.hotelPromotion}",
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              32,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 20,
                                indent: 10,
                                endIndent: 10,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (items.starRating!
                        .toString()
                        .toLowerCase()
                        .contains(_controller.text.toLowerCase())) {
                      if (showHotels[index].supplierHotelCodes!.isEmpty) {
                        return Container();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  //print(index);
                                  // print(img);
                                  // print(searchResult[index].hotelCode);
                                  // print(searchResult[index].supplierHotelCodes!.isEmpty?'null':searchResult[index].supplierHotelCodes![0].categoryId);
                                  goToSingle(index);
                                  setState(() {
                                    SaveImg = items.hotelPicture.toString();
                                  });
                                  //print("cache : ${storeCache[index].hotelCode}");
                                  // print("length : ${storeCache.length}");
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 280,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              8), // Image radius
                                          child: CachedNetworkImage(
                                            imageUrl: "${items.hotelPicture}",
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 280,
                                              width: 140,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/no-img.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Image.network(
                                          //   items.hotelPicture.toString(),
                                          //   fit: BoxFit.cover,
                                          //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          //     if (loadingProgress == null) {
                                          //       return child;
                                          //     }
                                          //     return Center(
                                          //       child: CircularProgressIndicator(
                                          //         value: loadingProgress.expectedTotalBytes != null
                                          //             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          //             : null,
                                          //       ),
                                          //     );
                                          //   },
                                          //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                          //     return Container(
                                          //       height: 225,
                                          //       width: 130,
                                          //       decoration: BoxDecoration(
                                          //         color: Colors.black,
                                          //         image: DecorationImage(
                                          //           image: AssetImage("assets/images/no-img.png"),
                                          //           fit: BoxFit.cover,
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${items.hotelName}",
                                                maxLines: 2,
                                                overflow: TextOverflow.visible,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${items.hotelDescription}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            26,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons.location_city,
                                                        size: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${items.hotelAddress}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              26,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RatingBarIndicator(
                                                rating: items.starRating!
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                direction: Axis.horizontal,
                                              ),
                                              Text(
                                                "Rating : ${items.starRating}",
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      color: Colors.green,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                          "Service Charge : ₹${items.price!.serviceCharge}",
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  32,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Text("Rating : ${items.starRating}",),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "$night ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Icon(
                                                            Icons.nights_stay,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " night - $GuestCount ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Icon(
                                                            Icons.person,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " guest",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    // Text(
                                                    //   "Price: ",
                                                    //   maxLines: 1,
                                                    //   overflow: TextOverflow.clip,
                                                    //   style: TextStyle(
                                                    //     fontSize:
                                                    //     MediaQuery.of(context)
                                                    //         .size
                                                    //         .width /
                                                    //         26,
                                                    //
                                                    //   ),
                                                    // ),
                                                    Text(
                                                      "₹${items.price!.roomPrice.toStringAsFixed(2)}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       right: 10, bottom: 5),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.end,
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.end,
                                              //     children: [
                                              //       Flexible(
                                              //         child: Text(
                                              //           "+ ₹${items.price!.otherCharges} Tax & charges",
                                              //           maxLines: 3,
                                              //           overflow:
                                              //               TextOverflow.clip,
                                              //           style: TextStyle(
                                              //               fontSize: MediaQuery.of(
                                              //                           context)
                                              //                       .size
                                              //                       .width /
                                              //                   30,
                                              //               color: Colors.grey),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.hotel,
                                                      size: 15,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " ${items.hotelCategory}",
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              32,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.room_service,
                                                      size: 15,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " ${items.hotelPromotion}",
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              32,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 20,
                                indent: 10,
                                endIndent: 10,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  }),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    } else if (sts == 1) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/no-result.png',
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "No Result Found",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Please try again later",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFE9D4E9),
                            offset: Offset(2, 3),
                            blurRadius: 5.0,
                            spreadRadius: 2,
                          ),
                        ],
                        gradient: const LinearGradient(
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
                          Get.off(() => Dashboard());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          "Go Home",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 22,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "- OR -",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Pull down to refresh",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (sts == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Lottie.asset('assets/lottie/loading.json',
                    fit: BoxFit.contain)),
            const Text("Loading..."),
          ],
        ),
      );
    }
  }

  Widget? hidingIcon() {
    if (_controller.text.length > 0) {
      return IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.grey,
          ),
          // splashColor: Colors.redAccent,
          onPressed: () {
            setState(() {
              _controller.clear();
            });
          });
    } else {
      return const Icon(
        Icons.search,
        size: 30,
      );
    }
  }

  getHotel() async {
    setState(() {
      city = widget.city;
      print("city =  $city");
      loop = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    var country = prefs.getString('country') ?? "IN";
    var currency = prefs.getString('currency') ?? "INR";
    // print("ip : $ips");
    final response = await http.post(
      Uri.parse('${api}api/hotels/search'),
      body: jsonEncode({
        "CheckInDate": "$chechinDate",
        "NoOfNights": night,
        "ResultCount": 0,
        "PreferredCurrency": currency,
        "MaxRating": 5,
        "GuestNationality": country,
        "NoOfRooms": StoredGuest.length,
        "IsNearBySearchAllowed": false,
        "RoomGuests": StoredGuest,
        "CityId": widget.cityId, // 130443, //
        "MinRating": 1,
        // "TokenId": "632322cd-83c4-48d2-b226-6d0c6f832d9b",
        "CountryCode": widget.countryCode, //'IN', //
        "ReviewScore": 0,
        "EndUserIp": "$ips"
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    log(response.body);
    print(response.statusCode);
    print('aaaaaaaaaaaaaaaaaaaaaaaaa');
    print(response.statusCode.isEqual(500));
    if (response.statusCode.isEqual(500)) {
      print('Error 500');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: Container(
            height: 100,
            child: Lottie.asset('assets/lottie/500.json', fit: BoxFit.contain),
          ),
          title: Text(
            "OOPS! There is an internal server error occoured",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'Metropolis',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Try again or feel free to contact us if the problem persists.",
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
                  onPressed: () => Get.off(() => Dashboard()),
                  child: const Text(
                    'Go Home',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: const Color(0xff92278f),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    print(response.body.contains('No Result Found'));
    if (response.body.contains('No Result Found')) {
      setState(() {
        sts = 1;
        pullDown = true;
      });
    }
    if (response.body
        .contains('Search is not allowed for other than Indian Nationality')) {
      setState(() {
        sts = 1;
      });

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
            "Error",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'Metropolis',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Search is not allowed for other than Indian Nationality for international destination.",
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
                  onPressed: () => Get.off(() => Dashboard()),
                  child: const Text(
                    'Go Home',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: const Color(0xff92278f),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    // print(".........................");
    if (response.statusCode == 200) {
      try {
        final result = hotelSearchFromJson(response.body);
        print("errors : ${result.hotelSearchResult!.error!.errorCode}");
        if (result.hotelSearchResult!.error!.errorCode == 0) {
          for (int i = 0;
              i < result.hotelSearchResult!.hotelResults.length;
              i++) {
            if (result.hotelSearchResult!.hotelResults[i].supplierHotelCodes!
                .isNotEmpty) {
              if (result.hotelSearchResult!.hotelResults[i].isTboMapped ==
                  true) {
                setState(() {
                  searchResult.add(result.hotelSearchResult!.hotelResults[i]);
                });
              }
            }
          }

          setState(() {
            // searchResult.addAll(result.hotelSearchResult!.hotelResults);
            // sts = 200;
            totalHotels = searchResult.length;
          });

          pagenation();

          // setState(() {
          //   sts = 200;
          // });
        } else if (result.hotelSearchResult!.responseStatus == 2) {
          setState(() {
            sts = 1;
          });
        } else if (result.hotelSearchResult!.error!.errorCode == 6) {
          getHotel();
          print('get hotel again');
        } else {
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
                "OOPS! ${result.hotelSearchResult!.error!.errorCode}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                "${result.hotelSearchResult!.error!.errorMessage}",
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
                        getHotel();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xff92278f),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Retry',
                        style: TextStyle(
                            color: Color(0xff92278f),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => Dashboard()),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xff92278f),
                            width: 1.0,
                          ),
                        ),
                        backgroundColor: const Color(0xff92278f),
                      ),
                      child: const Text(
                        'Go Home',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
        setState(() {
          // body = response.body.toString();
          traceId = "${result.hotelSearchResult!.traceId}";
          tokenId = result.token;
          // categoryId="${result.hotelSearchResult.hotelResults[0]}";
        });
      } catch (e) {
        print(e);
      }
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
                    getHotel();
                  },
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                        color: Color(0xff92278f),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
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
                        color: Color(0xffffffff),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: const Color(0xff92278f),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      setState(() {
        // body = response.statusCode.toString();
      });
    }
  }

  void goToSingle(int index) async {
    setState(() {
      loading = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse('${api}api/hotels/hotel-info'),
      body: jsonEncode({
        "HotelCode": "${showHotels[index].hotelCode}",
        "ResultIndex": showHotels[index].resultIndex,
        "TraceId": traceId,
        "TokenId": tokenId,
        "EndUserIp": "$ips",
        "CategoryId":
            "${showHotels[index].supplierHotelCodes!.isEmpty ? 'null' : showHotels[index].supplierHotelCodes![0].categoryId}"
      }),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 500) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: Container(
            height: 100,
            child: Lottie.asset('assets/lottie/500.json', fit: BoxFit.contain),
          ),
          title: Text(
            "OOPS! There is an internal server error occoured",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'Metropolis',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Try again or feel free to contact us if the problem persists.",
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
                  onPressed: () => Get.off(() => Dashboard()),
                  child: const Text(
                    'Go Home',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: const Color(0xff92278f),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    print(response.body);
    print(response.statusCode);
    final result = singleHotelFromJson(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = true;
      });
      if (result.hotelInfoResult!.error!.errorCode == 3) {
        print('invalid city id');
        setState(() {
          loading = false;
        });
      } else if (result.hotelInfoResult!.error!.errorCode == 2) {
        print('No rooms Available from UAPI');
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
              "OOPS!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              "No rooms Available",
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
                      Get.off(Dashboard());
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(
                          color: Color(0xff92278f),
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xff92278f),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        setState(() {
          loading = false;
        });
      } else if (result.hotelInfoResult!.error!.errorCode == 6) {
        print('Invalid Token');
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
              "OOPS!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              "${result.hotelInfoResult!.error!.errorMessage}",
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
                      Get.off(Dashboard());
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(
                          color: Color(0xff92278f),
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xff92278f),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        setState(() {
          loading = false;
        });
      } else if (result.hotelInfoResult!.error!.errorCode == 0) {
        getSingleImg(showHotels[index].hotelCode);
        saveInfo(
          showHotels[index].hotelName,
          result.hotelInfoResult!.hotelDetails!.address,
          result.hotelInfoResult!.hotelDetails!.starRating!.toDouble(),
          showHotels[index].hotelCode,
          widget.cityId.toString(),
          result.hotelInfoResult!.hotelDetails!.longitude,
          result.hotelInfoResult!.hotelDetails!.latitude,
          result.hotelInfoResult!.hotelDetails!.hotelFacilities!,
          result.hotelInfoResult!.hotelDetails!.images!,
        );
        print("aaaaa: ${result.hotelInfoResult!.hotelDetails!.images!}");
        setState(() {
          imgList = result.hotelInfoResult!.hotelDetails!.images!;
          hotelFacilities =
              result.hotelInfoResult!.hotelDetails!.hotelFacilities!;
          categoryId = showHotels[index].supplierHotelCodes![0].categoryId!;
        });
        // Get.to(() =>
        //     SingleHotelPage(
        //   discription: result.hotelInfoResult!.hotelDetails!.description,
        //   picture: showHotels[index].hotelPicture,
        //   images: result.hotelInfoResult!.hotelDetails!.images,
        //   price: showHotels[index].price!.roomPrice,
        //   address: result.hotelInfoResult!.hotelDetails!.address,
        //   name: showHotels[index].hotelName,
        //   contact: result.hotelInfoResult!.hotelDetails!.hotelContactNo,
        //   rating:
        //   result.hotelInfoResult!.hotelDetails!.starRating!.toDouble(),
        //   hotelFacilities:
        //   result.hotelInfoResult!.hotelDetails!.hotelFacilities,
        //   night: widget.night,
        //   checkin: widget.checkinDate,
        //   checkout: widget.checkoutDate,
        //   latitude: result.hotelInfoResult!.hotelDetails!.latitude,
        //   longitude: result.hotelInfoResult!.hotelDetails!.longitude,
        //   tokenId: tokenId,
        //   traceId: traceId,
        //   categoryIndex:
        //   showHotels[index].supplierHotelCodes![0].categoryIndex,
        //   resultIndex: showHotels[index].resultIndex,
        //   hotelCode: showHotels[index].hotelCode,
        //   categoryId: showHotels[index].supplierHotelCodes![0].categoryId,
        //   Datein: widget.inDate,
        //   Dateout: widget.outdate,
        // )
        // );

        Get.to(() => SingleHotelPage(
                  discription:
                      result.hotelInfoResult!.hotelDetails!.description,
                  picture: showHotels[index].hotelPicture,
                  images: result.hotelInfoResult!.hotelDetails!.images,
                  price: showHotels[index].price!.roomPrice,
                  address: result.hotelInfoResult!.hotelDetails!.address,
                  name: showHotels[index].hotelName,
                  contact: result.hotelInfoResult!.hotelDetails!.hotelContactNo,
                  rating: result.hotelInfoResult!.hotelDetails!.starRating!
                      .toDouble(),
                  hotelFacilities:
                      result.hotelInfoResult!.hotelDetails!.hotelFacilities,
                  night: widget.night,
                  checkin: widget.checkinDate,
                  checkout: widget.checkoutDate,
                  latitude: result.hotelInfoResult!.hotelDetails!.latitude,
                  longitude: result.hotelInfoResult!.hotelDetails!.longitude,
                  tokenId: tokenId,
                  traceId: traceId,
                  categoryIndex:
                      showHotels[index].supplierHotelCodes![0].categoryIndex,
                  resultIndex: showHotels[index].resultIndex,
                  hotelCode: showHotels[index].hotelCode,
                  categoryId:
                      showHotels[index].supplierHotelCodes![0].categoryId,
                  Datein: widget.inDate,
                  Dateout: widget.outdate,
                ))!
            .then((value) {
          if (value != null && value) {
            // Only restore the scroll position if we're coming back from the detail page.
            _restoreScrollPosition();
          }
        });
      }
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
                    goToSingle(index);
                  },
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                        color: Color(0xff92278f),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
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
                        color: Color(0xffffffff),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: const Color(0xff92278f),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      setState(() {
        loading = true;
      });
      print('Something Wrong');
      print(response.statusCode);
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
            "OOPS!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'Metropolis',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "${result.hotelInfoResult!.error!.errorMessage}",
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
                    Get.off(Dashboard());
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                        color: Color(0xff92278f),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xff92278f),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }

  getSingleImg(String? hotelCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse('${api}api/hotels/static-data'),
      body: jsonEncode({
        "CityId": "${widget.cityId}",
        "HotelId": "$hotelCode",
        "ClientId": "tboprod",
        "EndUserIp": "$ips",
        "TokenId": "$tokenId",
        "IsCompactData": "true"
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    final imgresult = hotelStaticDataFromJson(response.body);

    if (response.statusCode == 200) {
      setState(() {
        SaveImg = imgresult.basicPropertyInfo!.vendorMessages!.vendorMessage!
            .subSection!.paragraph!.url!
            .toString();
      });
    }
  }

  void getMore() {
    pagenation();
  }

  void pagenation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');

    // setState(() {
    //   pullUp = false;
    // });

    if (searchResult.length < 20) {
      setState(() {
        hotelCount = searchResult.length;
        // pullUp = false;
      });
    }

    setState(() {
      sts = 200;
    });

    for (int i = 0; i < hotelCount; i++) {
      try {
        final response = await http.post(
          Uri.parse('${api}api/hotels/static-data'),
          body: jsonEncode({
            "CityId": "${widget.cityId}",
            "HotelId": "${searchResult[i].hotelCode}",
            "ClientId": "tboprod",
            "EndUserIp": "$ips",
            "TokenId": "$tokenId",
            "IsCompactData": "true"
          }),
          headers: {"content-type": "application/json"},
        );
        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          final imgresult = hotelStaticDataFromJson(response.body);

          if (searchResult[i].hotelCode ==
              imgresult.basicPropertyInfo!.tboHotelCode) {
            setState(() {
              searchResult[i].hotelPicture = imgresult.basicPropertyInfo!
                  .vendorMessages!.vendorMessage!.subSection!.paragraph!.url;
              searchResult[i].hotelAddress =
                  imgresult.basicPropertyInfo!.address!.addressLine;
              searchResult[i].hotelDescription =
                  imgresult.basicPropertyInfo!.address!.cityName;
              searchResult[i].hotelCategory =
                  imgresult.basicPropertyInfo!.hotelCategoryName;
              searchResult[i].hotelPromotion = imgresult
                  .basicPropertyInfo!.attributes!.attribute!.attributeName;
              searchResult[i].hotelName =
                  imgresult.basicPropertyInfo!.hotelName;

              //tempData.add(searchResult[i]);
              showHotels.add(searchResult[i]);
              print('img changed: $i');
            });
          }
        } else {
          print("static data error");
          print(response.statusCode);
        }
      } catch (e) {
        print('error.....');
        print(e);
      }
    }
    setState(() {
      //sts = 200;
      pullDown = true;
      pullUp = true;
      searchResult.removeRange(0, hotelCount);
      searchResult.length < 20
          ? hotelCount = searchResult.length
          : hotelCount = 10;
      searchResult.length < 20 ? pullUp = false : pullUp = true;
      _refreshController.loadComplete();
      print('finished loop');
    });
  }

  void _restoreScrollPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double? scrollPosition = PageStorage.of(context).readState(context);
      if (_scrollController.hasClients && scrollPosition != null) {
        _scrollController.jumpTo(scrollPosition);
      }
    });
  }

  void saveInfo(
    String? hotelName,
    String? hotelAddress,
    double starRating,
    String? hotelCode,
    var cityId,
    String? latitude,
    String? longitude,
    List facilities,
    List images,
  ) async {
    try {
      print("Save info");
      final response = await http.post(
        Uri.parse('${api}info/save'),
        body: jsonEncode({
          "hotelName": hotelName,
          "hotelAddress": hotelAddress,
          "starRating": starRating,
          "hotelCode": hotelCode,
          "cityid": cityId,
          "latitude": latitude,
          "longitude": longitude,
          "hotelFacilities": facilities,
          "images": images
        }),
        headers: {"content-type": "application/json"},
      );

      print("Save info");
      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
