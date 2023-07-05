import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../db/api.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    this.email,
  });
  final email;
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController passwordController1 = new TextEditingController();
  TextEditingController passwordController2 = new TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1.0),
            Color.fromRGBO(181, 151, 246, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -50,
            top: Get.height * 0.1,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(62, 21, 78, 1.0),
                    Color.fromRGBO(240, 78, 110, 1.0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 100,
            bottom: Get.height * 0.35,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(146, 39, 143, 1.0),
                    Color.fromRGBO(240, 78, 110, 1.0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -50,
            bottom: Get.height * 0.075,
            child: Container(
              height: 225,
              width: 225,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(146, 39, 143, 1.0),
                    Color.fromRGBO(240, 78, 110, 1.0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                },
                child: SafeArea(
                  bottom: false,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: AssetImage(
                                  "assets/images/dtrips_logo_dark.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width / 1.2,
                        //   height: MediaQuery.of(context).size.height / 2.8,
                        //   decoration: BoxDecoration(
                        //     image: new DecorationImage(
                        //       image: AssetImage("assets/images/login1.png"),
                        //       fit: BoxFit.contain,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white10.withAlpha(80)),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withAlpha(100),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                              color: Color(0xffffffff).withOpacity(0.1),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Reset Password",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xccffffff),
                                          Color(0xccffffff)
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 10),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        // validator: (value) {
                                        //
                                        //   if (value == null || value.isEmpty) {
                                        //     return 'Please enter Card Number';
                                        //   } return null;
                                        // },
                                        controller: passwordController1,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Metropolis',
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(
                                                _obscureText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            ),
                                            border: InputBorder.none),
                                        // keyboardType:
                                        // TextInputType.emailAddress,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xccffffff),
                                          Color(0xccffffff)
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 50),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        // validator: (value) {
                                        //
                                        //   if (value == null || value.isEmpty) {
                                        //     return 'Please enter Card Number';
                                        //   } return null;
                                        // },
                                        controller: passwordController2,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                            hintText: 'Confirm Password',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Metropolis',
                                            ),
                                            border: InputBorder.none),
                                        // keyboardType:
                                        //     TextInputType.emailAddress,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 4),
                                            blurRadius: 5.0)
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
                                        resetPassword();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0, vertical: 20.0),
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: StadiumBorder(),
                                      ),
                                      child: Text(
                                        "Reset",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  resetPassword() async {
    if (passwordController1.text.length < 8) {
      print("length is small");
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: Container(
            height: 100,
            child:
                Lottie.asset('assets/lottie/warning.json', fit: BoxFit.contain),
          ),
          title: Text(
            "At-least 8 characters required",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontFamily: 'Metropolis',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          // content: Text(
          //   "Login or Create an account to get more features and access our exclusive deals and offers.",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //       fontSize: screenSize.width/24,
          //       fontFamily: 'Metropolis',
          //       color: Colors.black,
          //       fontWeight: FontWeight.w500),
          // ),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Color(0xff92278f),
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: Color(0xff92278f),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      if (passwordController1.text == passwordController2.text) {
        print(passwordController1.text);
        final response = await http.get(
          Uri.parse(api +
              'api/aws/reset-password?newpassword=${passwordController1.text}&email=${widget.email}'),
          headers: {"content-type": "application/json"},
        );
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Password reset",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0x23000000),
              textColor: Colors.white,
              fontSize: 16.0);
          Get.off(LoginPage());
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              icon: Container(
                height: 100,
                child: Lottie.asset('assets/lottie/error-x.json',
                    fit: BoxFit.contain),
              ),
              title: Text(
                "OOPS...!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Sorry, something went wrong",
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
                      onPressed: () => Get.back(),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Color(0xff92278f),
                            width: 1.0,
                          ),
                        ),
                        backgroundColor: Color(0xff92278f),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      } else {
        print('password miss match');
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            icon: Container(
              height: 100,
              child: Lottie.asset('assets/lottie/warning.json',
                  fit: BoxFit.contain),
            ),
            title: Text(
              "Both passwords must be same",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontFamily: 'Metropolis',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            // content: Text(
            //   "Login or Create an account to get more features and access our exclusive deals and offers.",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       fontSize: screenSize.width/24,
            //       fontFamily: 'Metropolis',
            //       color: Colors.black,
            //       fontWeight: FontWeight.w500),
            // ),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Color(0xff92278f),
                          width: 1.0,
                        ),
                      ),
                      backgroundColor: Color(0xff92278f),
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
}
