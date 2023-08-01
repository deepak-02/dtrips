import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Shared/SharedPrefs.dart';
import '../../../login/login_page.dart';
import '../../constant.dart';
import '../dashboard.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  LiquidController controller = LiquidController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            liquidController: controller,
            onPageChangeCallback: (index) {
              setState(() {});
            },
            enableLoop: false,
            enableSideReveal: false,
            // slideIconWidget: controller.currentPage == 2 ? null : Icon(
            //   Icons.arrow_back_ios,
            //   color: controller.currentPage == 1 ? Colors.black : Colors.white,
            // ),
            pages: [
              SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(10),
                    color: Color(0xff3e154e),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/room.json',
                          height: 200,
                          width: screenSize.width,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Welcome to Dtrips Mobile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width / 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            "Best Deals @ Your Trips.\n\n"
                            "Means to Travel @ Multiple Locations.\n\n"
                            "Means to Shelter @ Multiple Options.",
                            style: TextStyle(
                              fontSize: screenSize.width / 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(10),
                    color: Color(0xff92278f),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/lottie/Travelers.json',
                            height: 200,
                            width: MediaQuery.of(context).size.width),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "We Will Take Care",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width / 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            "Of tickets, transfers and a cool place to stay.",
                            style: TextStyle(
                              fontSize: screenSize.width / 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(10),
                    color: Color(0xffffffff),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/lottie/world-map.json',
                            height: 200,
                            width: MediaQuery.of(context).size.width),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Now It's Time",
                          style: TextStyle(
                            fontSize: screenSize.width / 14,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "To explore the best deals and offers we got for you.",
                          style: TextStyle(
                            fontSize: screenSize.width / 20,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.offAll(LoginPage(
                                  page: 'login',
                                ));
                              },
                              child: Text(
                                "Join Our Club",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "- OR -",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.purple, width: 2),
                            ),
                            onPressed: () {
                              guestLogin();
                            },
                            child: Text(
                              "Explore as a guest",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.purple),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          controller.currentPage == 2
              ? Container()
              : Positioned(
                  top: 30,
                  right: 10,
                  child: TextButton(
                      onPressed: () {
                        controller.animateToPage(page: 2);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: controller.currentPage == 2
                              ? Colors.black
                              : Colors.white,
                          fontSize: screenSize.width / 25,
                        ),
                      )),
                ),
          Positioned(
              bottom: 30,
              left: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage,
                count: 3,
                effect: WormEffect(
                    dotColor: Colors.white54,
                    activeDotColor: Colors.white,
                    dotHeight: 10,
                    dotWidth: 10,
                    type: WormType.thin),
                onDotClicked: (index) {
                  controller.animateToPage(page: index);
                },
              )),
          controller.currentPage == 2
              ? Container()
              : Positioned(
                  bottom: 10,
                  right: 10,
                  child: TextButton(
                      onPressed: () {
                        final page = controller.currentPage + 1;
                        controller.animateToPage(
                            page: page > 3 ? 0 : page, duration: 400);
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: controller.currentPage == 2
                              ? Colors.black
                              : Colors.white,
                          fontSize: screenSize.width / 25,
                        ),
                      )))
        ],
      ),
    );
  }

  void guestLogin() async {
    setLogin('guest');
    setState(() {
      username = "Guest";
    });

    Get.offAll(
      () => Dashboard(),
      transition: Transition.circularReveal,
      duration: Duration(milliseconds: 500),
    );
  }
}
