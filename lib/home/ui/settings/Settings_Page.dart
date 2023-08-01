import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Shared/SharedPrefs.dart';
import '../dashboard.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? pickedCountryCode = 'INR';
  String? pickedCountry = 'IN';

  // final Uri _url = Uri.parse('https://flutter.dev');
  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;
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
      child: Stack(
        children: [
          // Positioned(
          //   top: -250,
          //   left: -40,
          //   child: topWidget(screenSize.width),
          // ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.purple,
              automaticallyImplyLeading: false,
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              leading: InkWell(
                onTap: () {
                  Get.off(Dashboard());
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "App settings",
                              style: TextStyle(
                                  fontSize: orientation == "portrait"
                                      ? screenSize.width / 17
                                      : screenSize.height / 17,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            showCurrencyPicker(
                              context: context,
                              showFlag: true,
                              showSearchField: true,
                              showCurrencyName: true,
                              showCurrencyCode: true,
                              onSelect: (Currency currency) {
                                if (kDebugMode) {
                                  print('Select currency: ${currency.code}');
                                  print('Select country: $currency');
                                }

                                setState(() {
                                  pickedCountryCode = currency.code.toString();
                                  setCurrency(currency.code);
                                });
                              },
                              favorite: ['INR'],
                            );
                          },
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Currency",
                                  style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 25
                                        : screenSize.height / 25,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black87,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(pickedCountryCode.toString()),
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                flagSize: 25,
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.blueGrey),
                                bottomSheetHeight: MediaQuery.of(context)
                                        .size
                                        .height /
                                    1.5, // Optional. Country list modal height
                                //Optional. Sets the border radius for the bottomsheet.
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                //Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                              onSelect: (Country country) {
                                if (kDebugMode) {
                                  print('Select code: ${country.countryCode}');
                                  print(
                                      'Select country: ${country.displayName}');
                                }
                                setState(() {
                                  pickedCountry =
                                      country.countryCode.toString();
                                  setCountry(country.countryCode);
                                });
                              },
                              favorite: ['IN'],
                            );
                          },
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Country",
                                  style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 25
                                        : screenSize.height / 25,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black87,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(pickedCountry.toString()),
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "About",
                              style: TextStyle(
                                  fontSize: orientation == "portrait"
                                      ? screenSize.width / 17
                                      : screenSize.height / 17,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrlStart(
                                url:
                                    "https://www.freeprivacypolicy.com/live/d76894e4-219a-46d6-89ae-d5d8b8647101");
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "Privacy policy",
                                  style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 25
                                        : screenSize.height / 25,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrlStart(
                                url:
                                    "https://www.freeprivacypolicy.com/live/d76894e4-219a-46d6-89ae-d5d8b8647101");
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "Terms and Conditions",
                                  style: TextStyle(
                                    fontSize: orientation == "portrait"
                                        ? screenSize.width / 25
                                        : screenSize.height / 25,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "v 1.0.0",
                              style: TextStyle(
                                fontSize: orientation == "portrait"
                                    ? screenSize.width / 25
                                    : screenSize.height / 25,
                                fontFamily: 'Metropolis',
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 100,
                      width: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/dtrips_logo_dark.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currency = prefs.getString('currency');
    var country = prefs.getString('country');
    setState(() {
      currency!.isEmpty ? null : pickedCountryCode = currency.toString();
      country!.isEmpty ? null : pickedCountry = country.toString();
    });
  }
}
