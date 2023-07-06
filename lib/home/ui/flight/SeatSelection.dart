import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global.dart';

class SeatSelectionPage extends StatefulWidget {
  const SeatSelectionPage({Key? key, this.origin, this.destination, this.index})
      : super(key: key);

  final origin;
  final destination;
  final index;

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          tooltip: 'back',
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: [
            Text(
              "${widget.origin}",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_right_alt,color: Colors.white,),
            ),
            Text(
              "${widget.destination}",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "0 of 2 seats selected",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                      "2 travellers"
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your next button logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.purple),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Available seat (Rs. 1,800 - Rs. 9,100)",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 10,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       height: 20,
                          //       width: 20,
                          //       alignment: Alignment.center,
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(4),
                          //           border: Border.all(color: Color(0xFF4A4A4A)),
                          //           color: Color(0xFFD9D9D9)
                          //       ),
                          //       child: Icon(
                          //         Icons.close,
                          //         size: 16,
                          //         color: Color(0xFF4A4A4A),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.only(left: 10),
                          //       child: Text(
                          //         "Unavailable seat",
                          //         style: TextStyle(
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //     ),
                          //
                          //   ],
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border:
                                        Border.all(color: Color(0xFF14741B)),
                                    color: Color(0xFFE7FCE9)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Selected seat",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Flight : "),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${FlightSeats[widget.index]['RowSeats'][0]['Seats'][0]['Origin']} - ${FlightSeats[widget.index]['RowSeats'][0]['Seats'][0]['Destination']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (var rowSeats in FlightSeats[widget.index]['RowSeats'])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var seat in rowSeats['Seats'])
                          seat['SeatNo'] == null
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    // color: Colors.purple
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.purple),
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                          '${seat['Code']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      ],
                    ),
                ],
              ),

              // Column(
              //   children: [
              //     Center(
              //       child: ListView.separated(
              //         itemCount: FlightSeats.length,
              //         shrinkWrap: true,
              //         physics: NeverScrollableScrollPhysics(),
              //         // scrollDirection: Axis.horizontal,
              //         itemBuilder: (BuildContext context, int index) {
              //           var items = FlightSeats[index]['RowSeats'];
              //           return Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text("Flight : "),
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(4),
              //                           border: Border.all(width: 1, color: Colors.grey)
              //                       ),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "${items[0]['Seats'][0]['Origin']} - ${items[0]['Seats'][0]['Destination']}",
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 18
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               for (var rowSeats in items)
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     for (var seat in rowSeats['Seats'])
              //                       seat['SeatNo'] == null
              //                           ? Container(
              //                         width: 30,
              //                         height: 30,
              //                         decoration: BoxDecoration(
              //                           borderRadius:
              //                           BorderRadius.circular(4),
              //                           // color: Colors.purple
              //                         ),
              //                       )
              //                           : Padding(
              //                         padding:
              //                         const EdgeInsets.all(2),
              //                         child: Container(
              //                           width: 35,
              //                           height: 35,
              //                           decoration: BoxDecoration(
              //                               borderRadius:
              //                               BorderRadius.circular(
              //                                   4),
              //                               color: Colors.purple),
              //                           child: Center(
              //                             child: FittedBox(
              //                               child: Text(
              //                                 '${seat['Code']}',
              //                                 style: TextStyle(
              //                                     color:
              //                                     Colors.white),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                   ],
              //                 ),
              //             ],
              //           );
              //         },
              //         separatorBuilder: (BuildContext context, int index) {
              //           return Padding(
              //             padding: const EdgeInsets.only(top: 50,bottom: 50),
              //             child: Divider(thickness: 4,),
              //           );
              //         },
              //       ),
              //     ),
              //   ],
              // ),

              // Column(
              //   children: [
              //     InteractiveViewer(
              //       minScale: 0.5,
              //       maxScale: 5,
              //       child: Container(
              //         // color: Colors.red,
              //         width: MediaQuery.of(context).size.width,
              //         height: MediaQuery.of(context).size.height * 2,
              //         child: Center(
              //           child: ListView.separated(
              //             itemCount: FlightSeats.length,
              //             shrinkWrap: true,
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (BuildContext context, int index) {
              //               var items = FlightSeats[index]['RowSeats'];
              //               return Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   for (var rowSeats in items)
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         for (var seat in rowSeats['Seats'])
              //                           seat['SeatNo'] == null
              //                               ? Container(
              //                             width: 20,
              //                             height: 20,
              //                             decoration: BoxDecoration(
              //                               borderRadius:
              //                               BorderRadius.circular(4),
              //                               // color: Colors.purple
              //                             ),
              //                           )
              //                               : Padding(
              //                             padding:
              //                             const EdgeInsets.all(2),
              //                             child: Container(
              //                               width: 25,
              //                               height: 25,
              //                               decoration: BoxDecoration(
              //                                   borderRadius:
              //                                   BorderRadius.circular(
              //                                       4),
              //                                   color: Colors.purple),
              //                               child: Center(
              //                                 child: FittedBox(
              //                                   child: Text(
              //                                     '${seat['Code']}',
              //                                     style: TextStyle(
              //                                         color:
              //                                         Colors.white),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                       ],
              //                     ),
              //                 ],
              //               );
              //             },
              //             separatorBuilder: (BuildContext context, int index) {
              //               return SizedBox(
              //                 width: 50,
              //               );
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
