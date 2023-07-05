import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/global.dart';
import 'home/ui/dashboard.dart';
import 'home/ui/onboarding/onboarding.dart';

String? login = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  login = prefs.getString('login');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    getIp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dtrips',
      theme: ThemeData(
        fontFamily: 'Metropolis',
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
            surfaceTintColor: Colors.white
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0xff92278f)),
          ),
        ),
        useMaterial3: true,
      ),
      home: login == null || login == '' ? const OnboardingPage() : Dashboard(),
    );
  }

  void getIp() async {
    try {
      final ipv4 = await Ipify.ipv4();
      // print(ipv4); // 98.207.254.136

      //test
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        setIp(ipv4);
        ip = ipv4;
        // print(ip);
      });
      // The response type can be text, json or jsonp  117.193.168.171
    }catch(e){
      print(e);
    }
  }

  void setIp(String ipv4) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('ip', ipv4);
  }

}


