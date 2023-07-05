// import 'package:flutter/material.dart';
//
// var fromPlace = "Bengaluru";
// var fromPort = "Bengaluru International Airport";
// var toPlace = "New Delhi";
// var toPort = "Indra Gandhi International Airport";
//
//
// class BoxDestination extends StatefulWidget {
//    BoxDestination({Key? key}) : super(key: key);
//
//   @override
//   State<BoxDestination> createState() => _BoxDestinationState();
// }
//
// class _BoxDestinationState extends State<BoxDestination> {
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//      // height: MediaQuery.of(context).size.height * 0.20,
//       width: MediaQuery.of(context).size.width * 0.85,
//       decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 220, 223, 224),
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(width: 10),
//               Container(
//                 child: Column(
//                   children: const [
//                     Icon(Icons.location_on,
//                         color: Color.fromARGB(255, 231, 49, 17), size: 30),
//                     Icon(Icons.fiber_manual_record,
//                         color: Color.fromARGB(255, 224, 91, 68), size: 12),
//                     Icon(Icons.fiber_manual_record,
//                         color: Color.fromARGB(255, 218, 118, 101), size: 12),
//                     Icon(Icons.fiber_manual_record,
//                         color: Color.fromARGB(255, 224, 150, 137), size: 12),
//                     Icon(Icons.fiber_manual_record,
//                         color: Color.fromARGB(255, 107, 180, 98), size: 12),
//                     Icon(Icons.fiber_manual_record,
//                         color: Color.fromARGB(255, 69, 158, 74), size: 12),
//                     Icon(Icons.fiber_manual_record,
//                         color: Color.fromARGB(255, 43, 165, 43), size: 12),
//                     Icon(Icons.airplanemode_active,
//                         color: Color.fromARGB(255, 29, 192, 7), size: 30),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 16,
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10,bottom: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     GestureDetector(
//                         onTap: () {
//                           print("to tap");
//                         },
//                         child: Container(
//                           width: 160,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("To"),
//                               Text(toPlace,
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold
//                                 ),),
//                               Text(
//                                 toPort,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: TextStyle(
//
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                     ),
//                     const SizedBox(height: 65),
//                     GestureDetector(
//                         onTap: () {
//                           print("from tap");
//                         },
//                         child: Container(
//                           width: 160,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("From"),
//                               Text(fromPlace,
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold
//                                 ),),
//                               Text(
//                                 fromPort,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: TextStyle(
//
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 40),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children:  [
//                   // Text("UK", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   // SizedBox(height: 15),
//
//                   IconButton(
//                       onPressed: () {
//                         print("swap click");
//                         var temp;
//                         var port;
//                         temp = toPlace;
//                         toPlace = fromPlace;
//                         fromPlace = temp;
//
//                         port = toPort;
//                         toPort = fromPort;
//                         fromPort = port;
//
//                       },
//                       icon: Icon(Icons.swap_vert_outlined)
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// Widget _originAndDestionationIcon() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children:  [
//       // Text("UK", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//       // SizedBox(height: 15),
//
//           IconButton(
//               onPressed: () {
//                 print("swap click");
//                   var temp;
//                   var port;
//                   temp = toPlace;
//                   toPlace = fromPlace;
//                   fromPlace = temp;
//
//                   port = toPort;
//                   toPort = fromPort;
//                  fromPort = port;
//
//               },
//               icon: Icon(Icons.swap_vert_outlined)
//           ),
//         ],
//       );
//
//       // SizedBox(height: 15),
//       // Text("KTM", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//
// }
//
// Widget _originAndDestionation() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 10,bottom: 10),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         GestureDetector(
//           onTap: () {
//             print("to tap");
//           },
//           child: Container(
//             width: 160,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("To"),
//                 Text(toPlace,
//                 style: TextStyle(
//                   fontSize: 18, fontWeight: FontWeight.bold
//                 ),),
//                 Text(
//                   toPort,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                   style: TextStyle(
//
//                   ),
//                 )
//               ],
//             ),
//           )
//         ),
//         const SizedBox(height: 65),
//         GestureDetector(
//             onTap: () {
//               print("from tap");
//             },
//             child: Container(
//               width: 160,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("From"),
//                   Text(fromPlace,
//                     style: TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold
//                     ),),
//                   Text(
//                     fromPort,
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                     style: TextStyle(
//
//                     ),
//                   )
//                 ],
//               ),
//             )
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _iconDestination() {
//   return Container(
//     child: Column(
//       children: const [
//         Icon(Icons.location_on,
//             color: Color.fromARGB(255, 231, 49, 17), size: 30),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 224, 91, 68), size: 12),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 218, 118, 101), size: 12),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 224, 150, 137), size: 12),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 107, 180, 98), size: 12),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 69, 158, 74), size: 12),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 43, 165, 43), size: 12),
//         Icon(Icons.airplanemode_active,
//             color: Color.fromARGB(255, 29, 192, 7), size: 30),
//       ],
//     ),
//   );
// }
