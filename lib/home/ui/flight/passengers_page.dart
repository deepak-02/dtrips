import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../global.dart';
import '../dashboard.dart';

class PassengerSelectionPage extends StatefulWidget {
  const PassengerSelectionPage({Key? key}) : super(key: key);

  @override
  State<PassengerSelectionPage> createState() => _PassengerSelectionPageState();
}

class _PassengerSelectionPageState extends State<PassengerSelectionPage> {
  String _selectedCabinClass = planeClassName;
  int _selectedCabinClassValue = planeClassType;

  List<String> _cabinClassOptions = [
    'All',
    'Economy',
    'Premium economy',
    'Business',
    'Premium Business',
    'First class',
  ];
  List<int> _cabinClassValues = [1, 2, 3, 4, 5, 6];

  // List Segments = [SegmentsModel("DEL","BOM","$planeClassType","$returnDate","$departureDate").toJson()];
  var childage = 0;
  // late SegmentsModel segmentsModel = SegmentsModel("DEL","BOM","$planeClassType","$returnDate","$departureDate");

  @override
  void initState() {
    // Segments = StoredPassenger;
    super.initState();
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
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leadingWidth: 40,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () => Get.to(Dashboard()),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              title: const Text(
                "Passengers & Class",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: screenSize.width / 2,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0)
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
                          // StoredPassenger = Segments;
                          Get.off(Dashboard());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Metropolis',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Travellers",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ListTile(
                        title: const Text(
                          "Adults",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    noOfAdult == 1
                                        ? noOfAdult = 1
                                        : noOfAdult--;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.minus,
                                  size: 16,
                                  color: noOfAdult == 1
                                      ? Colors.black38
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "${noOfAdult}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    noOfAdult < 9
                                        ? noOfAdult++
                                        : noOfAdult = noOfAdult;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 16,
                                  color: noOfAdult < 9
                                      ? Colors.purple
                                      : Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          "Children",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    noOfChild == 0
                                        ? noOfChild = 0
                                        : noOfChild--;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.minus,
                                  size: 16,
                                  color: noOfChild == 0
                                      ? Colors.black38
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "${noOfChild}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    noOfChild < 9
                                        ? noOfChild++
                                        : noOfChild = noOfChild;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 16,
                                  color: noOfChild < 9
                                      ? Colors.purple
                                      : Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          "Infants",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    noOfInfant == 0
                                        ? noOfInfant = 0
                                        : noOfInfant--;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.minus,
                                  size: 16,
                                  color: noOfInfant == 0
                                      ? Colors.black38
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "${noOfInfant}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    noOfInfant < 9
                                        ? noOfInfant++
                                        : noOfInfant = noOfInfant;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 16,
                                  color: noOfInfant < 9
                                      ? Colors.purple
                                      : Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      // ListView.separated(
                      //     shrinkWrap: true,
                      //     // reverse: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     padding: const EdgeInsets.all(10),
                      //     itemCount: noOfChild,
                      //     itemBuilder: (BuildContext context, int index) {
                      //
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "${index+1}. Child's age",
                      //             style: TextStyle(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: GestureDetector(
                      //               onTap: (){
                      //                             showMaterialNumberPicker(
                      //                                 context: context,
                      //                                 title: "Pick Child's Age",
                      //                                 maxNumber: 12,
                      //                                 minNumber: 0,
                      //                                 selectedNumber: Passenger[0]['ChildAge']
                      //                                 [index],
                      //                                 onChanged: (value) {
                      //                                   setState(() {
                      //                                     childage = value;
                      //                                   });
                      //                                 },
                      //                                 onConfirmed: () {
                      //                                   setState(() {
                      //                                     Passenger[0]['ChildAge'][index] =
                      //                                         childage;
                      //                                   });
                      //                                 });
                      //               },
                      //               child: Container(
                      //                 alignment: Alignment.center,
                      //                 height: 45,
                      //                 width: double.infinity,
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.white,
                      //                     border: Border.all(
                      //                         width: 1,
                      //                         color: Colors.black
                      //                     ),
                      //                     borderRadius: const BorderRadius.all(Radius.circular(5))),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(left: 8,right: 8),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       Text(
                      //                         "${Passenger[0]['ChildAge'][index]}",
                      //                         style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 16
                      //                         ),
                      //                       ),
                      //                       Icon(
                      //                         Icons.arrow_drop_down
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.only(left: 8,right: 8),
                      //             child: Text(
                      //               "Select the age this child will be on the date of your final flight",
                      //               style: TextStyle(
                      //                   fontSize: 14
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     }, separatorBuilder: (BuildContext context, int index) {
                      //       return SizedBox(height: 30,);
                      //       },),
                      //
                      // const SizedBox(
                      //   height: 40,
                      // ),

                      Row(
                        children: const [
                          Text(
                            "Cabin class",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black54,
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: _buildCabinClassRadioButtons(),
                        // Wrap(
                        //   spacing: 10,
                        //   children: List.generate(_choicesList.length, (index) {
                        //     return Container(
                        //       height: 50,
                        //       child: ChoiceChip(
                        //         shape: const RoundedRectangleBorder(
                        //             borderRadius:
                        //                 BorderRadius.all(Radius.circular(16))),
                        //         labelPadding: const EdgeInsets.all(2.0),
                        //         label: Text(
                        //           _choicesList[index],
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .bodyMedium!
                        //               .copyWith(
                        //                 color: Colors.white,
                        //                 fontSize: orientation == "portrait"
                        //                     ? screenSize.width / 26
                        //                     : screenSize.height / 26,
                        //               ),
                        //         ),
                        //         selected: defaultChoiceIndex == index,
                        //         selectedColor: const Color(0xff92278f),
                        //         onSelected: (value) {
                        //           setState(() {
                        //             defaultChoiceIndex =
                        //                 value ? index : defaultChoiceIndex;
                        //             print(_choicesList[index]);
                        //             print(index);
                        //             defaultChoiceIndex = index;
                        //             planeClassName = _choicesList[index];
                        //           });
                        //         },
                        //         elevation: 0,
                        //         padding: const EdgeInsets.symmetric(horizontal: 50),
                        //       ),
                        //     );
                        //   }),
                        // ),
                      ),

                      const SizedBox(
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

  Widget _buildCabinClassRadioButtons() {
    return Column(
      children: _cabinClassOptions.asMap().entries.map((entry) {
        int index = entry.key;
        String cabinClass = entry.value;

        return RadioListTile(
          title: Text(cabinClass),
          value: _cabinClassValues[index],
          groupValue: _selectedCabinClassValue,
          onChanged: (value) {
            setState(() {
              _selectedCabinClassValue = value as int;
              _selectedCabinClass = cabinClass;
              planeClassName = cabinClass;
              planeClassType = _selectedCabinClassValue;
            });
            print(planeClassName);
            print(planeClassType);
          },
        );
      }).toList(),
    );
  }

  // Widget _buildCabinClassRadioButtons() {
  //   return Column(
  //     children: _cabinClassOptions
  //         .map((cabinClass) => RadioListTile(
  //       title: Text(cabinClass),
  //       value: cabinClass,
  //       groupValue: _selectedCabinClass,
  //       onChanged: (value) {
  //         setState(() {
  //           _selectedCabinClass = value!;
  //           planeClassName = value!;
  //
  //         });
  //       },
  //     ))
  //         .toList(),
  //   );
  // }
}
