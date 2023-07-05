import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/api.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../dashboard.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController(text: name);
  TextEditingController addressController =
      TextEditingController(text: paddress);
  TextEditingController emailController = TextEditingController(text: pemail);
  TextEditingController phoneController = TextEditingController(text: pphone);
  bool btnVisible = true;
  String dropdownValue = 'Male';
  @override
  void initState() {
    super.initState();
    getData();
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startTop,
              floatingActionButton: btnVisible
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: InkWell(
                        onTap: () {
                          Get.back();
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
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Color(0xfff4e9f4),
                                  child: CircleAvatar(
                                    radius: 64,
                                    //Color of membership
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Color(0xfff4e9f4),
                                      child: Text(
                                        "${name[0].toString().toUpperCase()}",
                                        style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // Image.asset(
                                    //   'assets/images/avatar.png',
                                    //   fit: BoxFit.contain,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Basic Info",
                                  style: TextStyle(
                                      fontSize: screenSize.width / 24,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 22
                                          : screenSize.height / 22,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(backgroundColor: Color(0xff92278f)),
                              child: TextField(
                                controller: nameController,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff92278f)),
                                  ),
                                  hintText: 'Enter Your Name',
                                  hintStyle: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 20
                                          : screenSize.height / 20,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 22
                                          : screenSize.height / 22,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Theme(
                                data: Theme.of(context).copyWith(
                                    backgroundColor: Color(0xff92278f)),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff92278f)),
                                    ),
                                    hintText: 'Gender',
                                    hintStyle: TextStyle(
                                        fontSize: orientation == "portrait"
                                            ? screenSize.width / 20
                                            : screenSize.height / 20,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  dropdownColor: Colors.white,
                                  value: dropdownValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      print(dropdownValue);
                                    });
                                  },
                                  items: <String>['Male', 'Female', 'Other']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                )

                                // TextField(
                                //   maxLines: 1,
                                //   style: TextStyle(
                                //       fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                //       fontFamily: 'Metropolis',
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.bold),
                                //   decoration: InputDecoration(
                                //     focusedBorder: UnderlineInputBorder(
                                //       borderSide:
                                //           BorderSide(color: Color(0xff92278f)),
                                //     ),
                                //     hintText: 'gender',
                                //     hintStyle: TextStyle(
                                //         fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                //         fontFamily: 'Metropolis',
                                //         color: Colors.black54,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                ),

                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 22
                                          : screenSize.height / 22,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(backgroundColor: Color(0xff92278f)),
                              child: TextField(
                                maxLines: 6,
                                controller: addressController,
                                style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 20
                                        : screenSize.height / 20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff92278f)),
                                  ),
                                  hintText: 'Enter Your Address',
                                  hintStyle: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 20
                                          : screenSize.height / 20,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Login Details",
                                  style: TextStyle(
                                      fontSize: screenSize.width / 24,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 22
                                          : screenSize.height / 22,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(backgroundColor: Color(0xff92278f)),
                              child:
                                  // IntlPhoneField(
                                  //   // controller: phoneController,
                                  //   textAlign: TextAlign.justify,
                                  //   style: TextStyle(
                                  //       fontSize: orientation == "portrait"
                                  //           ? screenSize.width / 20
                                  //           : screenSize.height / 20,
                                  //       fontFamily: 'Metropolis',
                                  //       color: Colors.black54,
                                  //       fontWeight: FontWeight.bold),
                                  //   autovalidateMode: AutovalidateMode.disabled,
                                  //   disableLengthCheck: true,
                                  //   showCountryFlag: true,
                                  //   showDropdownIcon: false,
                                  //   decoration: InputDecoration(
                                  //     focusedBorder: UnderlineInputBorder(
                                  //       borderSide:
                                  //           BorderSide(color: Color(0xff92278f)),
                                  //     ),
                                  //     hintText: 'Enter Your Mobile Number',
                                  //     hintStyle: TextStyle(
                                  //         fontSize: orientation == "portrait"
                                  //             ? screenSize.width / 20
                                  //             : screenSize.height / 20,
                                  //         fontFamily: 'Metropolis',
                                  //         color: Colors.black54,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  //   keyboardType: TextInputType.phone,
                                  //   inputFormatters: <TextInputFormatter>[
                                  //     FilteringTextInputFormatter.digitsOnly
                                  //   ],
                                  //   initialCountryCode: 'IN',
                                  //   onChanged: (phone) {
                                  //     // print(phone.completeNumber);
                                  //   },
                                  // ),

                                  TextField(
                                maxLines: 1,
                                controller: phoneController,
                                style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 20
                                        : screenSize.height / 20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff92278f)),
                                  ),
                                  hintText: 'Enter Your Mobile Number',
                                  hintStyle: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 20
                                          : screenSize.height / 20,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 22
                                          : screenSize.height / 22,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(backgroundColor: Color(0xff92278f)),
                              child: TextField(
                                maxLines: 1,
                                readOnly: true,
                                controller: emailController,
                                style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 20
                                        : screenSize.height / 20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff92278f)),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontSize: orientation == "portrait"
                                          ? screenSize.width / 20
                                          : screenSize.height / 20,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
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
                                      saveProfile();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 20.0),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: orientation == "portrait"
                                            ? screenSize.width / 22
                                            : screenSize.height / 22,
                                        fontFamily: 'Metropolis',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 50,
                            // ),
                            // Container(
                            //   height: 50,
                            //   decoration: BoxDecoration(
                            //       gradient: LinearGradient(
                            //         colors: [
                            //           Color(0xffffffff),
                            //           Color(0xffffffff)
                            //         ],
                            //       ),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Color(0x1D000000),
                            //           blurRadius: 5.0,
                            //           spreadRadius: 3,
                            //           offset: Offset(
                            //             2,
                            //             3,
                            //           ),
                            //         )
                            //       ],
                            //       borderRadius: BorderRadius.circular(16)),
                            //   child: InkWell(
                            //     onTap: () {
                            //       // print('Change Password');
                            //      // Get.to(EditProfilePage());
                            //     },
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Row(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.all(8.0),
                            //               child: CircleAvatar(
                            //                 backgroundColor: Colors.transparent,
                            //                 child: Image.asset(
                            //                     'assets/images/icons/key.png'),
                            //                 radius: 15,
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               width: 20,
                            //             ),
                            //             Text(
                            //               "Change Password",
                            //               style: TextStyle(
                            //                   fontSize:
                            //                       orientation == "portrait"
                            //                           ? screenSize.width / 20
                            //                           : screenSize.height / 20,
                            //                   fontFamily: 'Metropolis',
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ],
                            //         ),
                            //         Icon(
                            //           Icons.keyboard_arrow_right,
                            //           size: 30,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            // Container(
                            //   height: 50,
                            //   decoration: BoxDecoration(
                            //       gradient: LinearGradient(
                            //         colors: [
                            //           Color(0xffffffff),
                            //           Color(0xffffffff)
                            //         ],
                            //       ),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Color(0x1D000000),
                            //           blurRadius: 5.0,
                            //           spreadRadius: 3,
                            //           offset: Offset(
                            //             2,
                            //             3,
                            //           ),
                            //         )
                            //       ],
                            //       borderRadius: BorderRadius.circular(16)),
                            //   child: InkWell(
                            //     onTap: () {
                            //       // print('Delete Account');
                            //       Get.to(EditProfilePage());
                            //     },
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Row(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //           children: [
                            //             CircleAvatar(
                            //               backgroundColor: Colors.transparent,
                            //               child: Image.asset(
                            //                   'assets/images/icons/delete.png'),
                            //               radius: 15,
                            //             ),
                            //             SizedBox(
                            //               width: 20,
                            //             ),
                            //             Text(
                            //               "Delete Account",
                            //               style: TextStyle(
                            //                   fontSize:
                            //                       orientation == "portrait"
                            //                           ? screenSize.width / 20
                            //                           : screenSize.height / 20,
                            //                   fontFamily: 'Metropolis',
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ],
                            //         ),
                            //         Icon(
                            //           Icons.keyboard_arrow_right,
                            //           size: 30,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 50,
                            // ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  saveProfile() async {
    final response = await http.post(
      Uri.parse(api + 'api/auth/update-profile'),
      body: jsonEncode({
        'email': pemail,
        'name': nameController.text,
        'gender': dropdownValue,
        'address': addressController.text,
        'phone': phoneController.text,
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.off(Dashboard());
      Fluttertoast.showToast(
          msg: "Profile updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0x23000000),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0x23000000),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var gender = prefs.getString('gender');
    if (gender == null) {
      setState(() {
        gender = 'Male';
      });
    }
    setState(() {
      dropdownValue = gender!;
    });
  }
}
