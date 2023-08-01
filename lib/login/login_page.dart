import 'dart:convert';
import 'dart:ui';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:dtrips/login/signUp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:http/http.dart' as http;

import '../Shared/SharedPrefs.dart';
import '../db/Login/fbLoginModel.dart';
import '../db/Login/google_login_model.dart';
import '../db/api.dart';
import '../home/constant.dart';
import '../home/global.dart';
import '../home/ui/dashboard.dart';
import 'forgot_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.page,
  });
  final page;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getIp();
  }

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
            top: Get.height * 0.15,
            child: Container(
              height: 180,
              width: 180,
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startTop,
              floatingActionButton: IconButton(
                onPressed: () {
                  //Get.back();
                  // widget.page == 'login' ? guestLogin() : Get.back();
                  guestLogin();
                },
                icon: Icon(Icons.close),
                iconSize: 30,
                tooltip: 'Close',
              ),
              body: GestureDetector(
                onTap: () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 200,
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
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white10.withAlpha(80)),
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
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Log In",
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
                                        left: 50, right: 50),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Metropolis',
                                          ),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.emailAddress,
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
                                        left: 50, right: 10),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: passwordController,
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
                                              color: Colors.black26,
                                              size: 30,
                                            ),
                                          ),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(ForgotPage());
                                      },
                                      child: Text(
                                        'Forgot ?',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Metropolis',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
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
                                      login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 20.0),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                GoogleSignIn().signOut();
                              },
                              child: Text(
                                '- OR -',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInButton.mini(
                                  buttonType: ButtonType.google,
                                  buttonSize: ButtonSize.large,
                                  onPressed: () {
                                    GsignIn();
                                    print('click');
                                  }),
                              SignInButton.mini(
                                  buttonType: ButtonType.facebook,
                                  buttonSize: ButtonSize.large,
                                  onPressed: () {
                                    // setEmail('test@gmail.com');
                                    // Get.offAll(Dashboard());
                                    facebookLogin();
                                    print('click');
                                  }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New here?',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => SignUpPage(),
                                  transition: Transition.circularReveal,
                                  duration: Duration(milliseconds: 500),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Metropolis',
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text("Or Login as a ",style: TextStyle(
                          //     fontSize: 16,
                          //     fontFamily: 'Metropolis',
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w400),),

                          // InkWell(
                          //   onTap: () {
                          //     guestLogin();
                          //   },
                          //   child: Text(
                          //     "Guest",
                          //     style: TextStyle(
                          //         fontSize: 18,
                          //         fontFamily: 'Metropolis',
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
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
        ],
      ),
    );
  }

  Future GsignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      // late dynamic user ;
      _googleSignIn.signIn().then((value) {
        var email = value!.email;
        var username = value.displayName;
        var id = value.id;
        var img = value.photoUrl;
        // setState(() {
        //   user = value;
        // });

        print("ggggggggggggg");
        print(value);
        googleLogin(value);
      });

      // final user = await GoogleSignInApi.login();
      //  print(user);
    } catch (e) {
      print(e);
      _googleSignIn.disconnect();
      // await GoogleSignInApi.logout();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

  facebookLogin() async {
    try {
      final result = await FacebookAuth.instance.login(permissions: [
        'email',
        'public_profile',
      ]);

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        print('facebook_login_data:-');
        print(userData);
        print(userData['email']);
        print('${userData['name']}');
        print('${userData['picture']['data']['url']}');
        print('${userData['id']}');
        setState(() {
          username = userData['name'];
          userimg = userData['picture']['data']['url'];
        });

        final response = await http.post(
          Uri.parse(api + 'api/auth/fb-signin'),
          body: jsonEncode({
            "imageurl": userData['picture']['data']['url'],
            "password": userData['id'],
            "username": userData['name'],
            "name": userData['name'],
            "email": userData['id'],
            "identity": userData['id'],
          }),
          headers: {"content-type": "application/json"},
        );
        print(response.body);
        print(response.statusCode);
        final res = fbLoginFromJson(response.body);
        if (response.statusCode == 200) {
          setState(() {
            setLogin('facebook');
            setName(res.username.toString());
            setEmail(userData['id']);
            setFb(userData['email']);
            setJwt(res.jwtCookie!.value.toString());
          });
          print(res.email);
          print('fb login success');
          Get.offAll(Dashboard());
        } else if (response.statusCode == 202) {
          setState(() {
            setLogin('facebook');
            setName(res.username.toString());
            setEmail(userData['id']);
            setFb(userData['email']);
            setJwt(res.jwtCookie!.value.toString());
          });

          print('face book signup success');
          Get.offAll(Dashboard());
        } else {
          print('Something wrong');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Something wrong')));
        }
        return FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Facebook Login Failed')));
      }
    } catch (error) {
      print(error);
    }
  }

  void login() async {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
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
            "Enter Email And Password",
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
    } else if (emailController.text.isEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
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
            "Enter a valid email",
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
    } else if (passwordController.text.isEmpty ||
        passwordController.text.length < 8) {
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
            "Enter a valid password",
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
      print("Validation Success");
      final response = await http.post(
        Uri.parse(api + 'api/auth/signin'),
        body: jsonEncode({
          "username": emailController.text,
          "password": passwordController.text,
        }),
        headers: {"content-type": "application/json"},
      );
      print("body: ${response.body}");
      print(response.statusCode);
      print(response.headers);
      print(response.request);

      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> data =
              new Map<String, dynamic>.from(json.decode(response.body));
          String u_name = data['name'];
          String u_email = data['email'];
          String u_phone = data['phone'];
          //String u_image = data['img'];
          String tok = data['jwtCookie']['value'];
          print(u_phone);
          print("token = $tok");
          token = tok;
          username = u_name;
          // userimg = u_image;
          setLogin('email');
          setName(u_name);
          setEmail(u_email);
          setJwt(tok);
        });
        Get.offAll(Dashboard());
      } else if (response.statusCode == 401) {
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
              "Email or password is wrong",
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
      } else if (response.statusCode == 403) {
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
              "Email or password is wrong",
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
        print("Failed to signup");
      }
    }
  }

  void guestLogin() async {
    setLogin('guest');
    setState(() {
      username = "Guest";
      name = "Guest";
    });

    Get.offAll(
      () => Dashboard(),
      transition: Transition.circularReveal,
      duration: Duration(milliseconds: 500),
    );
  }

  void getIp() async {
    final ipv4 = await Ipify.ipv4();
    print(ipv4); // 98.207.254.136
    ip = ipv4;
    // setState(() {
    //
    //   print(ip);
    // });
    // The response type can be text, json or jsonp  117.193.168.171
  }

  void googleLogin(dynamic user) async {
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed')));
    } else {
      print(user);
      print(user.displayName);
      print(user.email);
      print(user.id);
      // Get.to(Dashboard());
      setState(() {
        username = user.displayName.toString();
        user.photoUrl == null
            ? userimg = ''
            : userimg = user.photoUrl.toString();
      });

      final response = await http.post(
        Uri.parse(api + 'api/auth/google-signin'),
        body: jsonEncode({
          "imageurl": user.photoUrl,
          "email": user.email,
          "name": user.displayName.toString(),
          "username": user.email,
          "password": user.id,
          // "id": user.id,
        }),
        headers: {"content-type": "application/json"},
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 500) {
        removeLogin();
        removeEmail();
        removeName();
        removeJwt();
        GoogleSignIn().disconnect();
        // await GoogleSignInApi.logout();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('500 :  Internal server error')));
      }

      final result = googleLoginFromJson(response.body);

      if (response.statusCode == 202) {
        setLogin('google');
        // setName(result.name!);
        setName(user.displayName!);
        setEmail(result.email!);
        setJwt(result.jwtCookie!.value!);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Account Created')));
        Get.to(Dashboard());
        setState(() {
          username = result.username!;
        });
      } else if (response.statusCode == 200) {
        setLogin('google');
        setName(result.name!);
        setEmail(result.email!);
        setJwt(result.jwtCookie!.value!);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login')));
        print(result.jwtCookie!.value);
        print(",,,,,,,,,,,,,,,,");
        Get.to(Dashboard());
        setState(() {
          username = user.displayName.toString();
        });
      } else {
        removeLogin();
        removeEmail();
        removeName();
        removeJwt();
        GoogleSignIn().disconnect();
        // await GoogleSignInApi.logout();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went wrong')));
      }
    }
  }
}
