// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../db/Flight/fareQuoteModel.dart';
// import '../../../db/api.dart';
// import '../../global.dart';
// import 'flightCustomise.dart';
//
// class FarePage extends StatefulWidget {
//   const FarePage({Key? key, this.ResultIndex, this.TraceId, this.Token}) : super(key: key);
//   final ResultIndex;
//   final TraceId;
//   final Token;
//
//   @override
//   State<FarePage> createState() => _FarePageState();
// }
//
// class _FarePageState extends State<FarePage> {
//
//   List<Results?> fareQuoteResult = [];
//
//   @override
//   void initState() {
//     getFareQuote(widget.ResultIndex,widget.TraceId,widget.Token);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         leading: IconButton(
//           tooltip: 'back',
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: Text(
//           "Choose your fare",
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 60,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Rs. 39,805.91",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(width: 5,),
//                           Icon(
//                               Icons.info_outline
//                           ),
//                         ],
//                       ),
//                       Text(
//                           "Rs. 79,025.93 for 2 travellers"
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.black26,
//                           offset: Offset(0, 4),
//                           blurRadius: 5.0)
//                     ],
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       stops: [0.0, 1.0],
//                       colors: [
//                         Color(0xff92278f),
//                         Color(0xff92278f),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => FlightCustomisePage(ResultIndex: widget.ResultIndex,TraceId: widget.TraceId,Token: widget.Token,)),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 40.0, vertical: 20.0),
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       shape: const StadiumBorder(),
//                     ),
//                     child: Text(
//                       "Next",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Metropolis',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.purple, width: 2)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 20, bottom: 20, left: 10, right: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Eco Saver",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "+ Rs. 0 (Rs. 100,802.05 per traveller)",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Radio(
//                               value: 0,
//                               groupValue: 0,
//                               onChanged: (value){
//                                 print(value);
//                               },
//                               activeColor: Colors.purple,
//
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 cabin bags (7 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 checked bags (25 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black12, width: 1)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 20, bottom: 20, left: 10, right: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Eco Flex",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "+ Rs. 0 (Rs. 13,802.05 per traveller)",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Radio(
//                               value: "value",
//                               groupValue: "group",
//                               onChanged: null,
//                               activeColor: Colors.purple,
//
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 cabin bags (7 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 checked bags (30 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black12, width: 1)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 20, bottom: 20, left: 10, right: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Eco Flexplus",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "+ Rs. 70,872.70 (Rs. 110,802.05 per traveller)",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Radio(
//                               value: "value",
//                               groupValue: "group",
//                               onChanged: null,
//                               activeColor: Colors.purple,
//
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 cabin bags (7 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 checked bags (35 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black12, width: 1)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 20, bottom: 20, left: 10, right: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Business Saver",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "+ Rs. 170,872.70 (Rs. 201,802.05 per traveller)",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Radio(
//                               value: "value",
//                               groupValue: "group",
//                               onChanged: null,
//                               activeColor: Colors.purple,
//
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "4 cabin bags (7 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 checked bags (40 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.airline_seat_recline_normal,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Choose your own seats",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.flight_class,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Airport lounge access",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_sharp,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Priority baggage collection",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.double_arrow,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Priority check-in",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.double_arrow,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Fast track through airports",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.double_arrow,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Priority boarding",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black12, width: 1)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 20, bottom: 20, left: 10, right: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Business Flex",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "+ Rs. 170,872.70 (Rs. 201,802.05 per traveller)",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Radio(
//                               value: "value",
//                               groupValue: "group",
//                               onChanged: null,
//                               activeColor: Colors.purple,
//
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "4 cabin bags (7 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_outlined,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "2 checked bags (40 kg each)",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.airline_seat_recline_normal,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Choose your own seats",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.flight_class,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Airport lounge access",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.luggage_sharp,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Priority baggage collection",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.double_arrow,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Priority check-in",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.double_arrow,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Fast track through airports",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 5,),
//                             Icon(
//                               Icons.double_arrow,
//                             ),
//                             SizedBox(width: 5,),
//                             Text(
//                               "Priority boarding",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//               Divider(
//                 color: Colors.black12,
//                 thickness: 10,
//               ),
//               Container(
//                 width: double.infinity,
//                 alignment: Alignment.center,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 10, right: 10, top: 20, bottom: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Tell us how we're doing and what could be better",
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Give feedback",
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Divider(
//                 color: Colors.black12,
//                 thickness: 10,
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void getFareQuote(resultIndex, traceId, token) async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var ips = prefs.getString('ip');
//
//     final response = await http.post(
//       Uri.parse(api + 'api/flight/fare-quote'),
//
//       body: jsonEncode({
//         "EndUserIp": "$ips",
//         "TokenId": "$token",
//         "TraceId": "$traceId",
//         "ResultIndex": "$resultIndex"
//       }),
//       headers: {"content-type": "application/json"},
//     );
//
//     print(response.body);
//     print(response.statusCode);
//
//     if(response.statusCode == 200){
//       final result = fareQuoteModelFromJson(response.body);
//
//       fareQuoteResult.add(result.response!.results);
//
//         setState(() {
//           lcc = result.response!.results!.isLcc!.toString();
//         });
//
//
//     }
//
//   }
// }
