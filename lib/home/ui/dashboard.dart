import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account/profile_page.dart';
import 'home/home_page.dart';
import 'myBookings/myBookings_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);
List<Widget> _buildScreens() {
  return [
    MyHomePage(restorationId: 'main'),
    //DealsPage(),
    MyBookings(),
    UserProfilePage(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      // icon: Image.asset('assets/images/icons/house.png'),
      icon: Icon(Icons.home_outlined),

      iconSize: 24,
      textStyle: TextStyle(fontSize: 12, fontFamily: "Metropolis"),
      title: ("Home"),
      activeColorPrimary: Color(0xff92278f),
      inactiveColorPrimary: Color(0xffd3a9d2),
    ),
    // PersistentBottomNavBarItem(
    //   icon: ImageIcon(AssetImage('assets/images/icons/deals.png')),
    //   // icon: Icon(Ionicons.bed_outline),
    //   iconSize: 24,
    //   textStyle: TextStyle(
    //       fontSize: 12,
    //       fontFamily: "Metropolis"
    //   ),
    //   title: ("Deals"),
    //   activeColorPrimary: Color(0xff92278f),
    //   inactiveColorPrimary: Color(0xffd3a9d2),
    // ),
    PersistentBottomNavBarItem(
      icon: ImageIcon(AssetImage('assets/images/icons/luggage.png')),
      // icon: Icon(Icons.wallet_travel_outlined),
      iconSize: 24,
      textStyle: TextStyle(fontSize: 12, fontFamily: "Metropolis"),
      title: ("Bookings"),
      activeColorPrimary: Color(0xff92278f),
      inactiveColorPrimary: Color(0xffd3a9d2),
    ),
    PersistentBottomNavBarItem(
      // icon: Image.asset('assets/images/icons/user.png'),
      icon: Icon(Icons.person_outline),
      iconSize: 24,
      textStyle: TextStyle(fontSize: 12, fontFamily: "Metropolis"),
      title: ("Account"),
      activeColorPrimary: Color(0xff92278f),
      inactiveColorPrimary: Color(0xffd3a9d2),
    ),
  ];
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xffffffff),
      // backgroundColor: Color(0xffc993c7), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(20.0),
      //   colorBehindNavBar: Colors.white,
      // ),
      padding: NavBarPadding.all(5),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarHeight: 56,
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  @override
  void initState() {
    super.initState();
    _networkConnectivity.initialise();
    //_networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      print('source $_source');
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.none:
          {
            // string = 'connection unavailable';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  // string,
                  'connection unavailable',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                backgroundColor: Colors.purple,
                duration: Duration(milliseconds: 10000),
              ),
            );
          }
          break;
        case ConnectivityResult.mobile:
          {
            // string = 'connection available';
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
          break;
        case ConnectivityResult.wifi:
          {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // string = 'connection available';
          }
      }
    });
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();

    super.dispose();
  }
}

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);

    _networkConnectivity.onConnectivityChanged.listen((result) {
      print(result);
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    try {
      _controller.sink.add({result: isOnline});
    } catch (e){
      print(e);
    }
    getIp();
  }

  void disposeStream() => _controller.close();

  void getIp() async {
    try {
      final ipv4 = await Ipify.ipv4();
      print(ipv4); // 98.207.254.136
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('ip', ipv4);
    } catch(e){
      print(e);
    }
  }
}
