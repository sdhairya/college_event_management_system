import 'package:college_event_management/coordinators/coordinators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../attendees/attendees.dart';
import '../../dashboard/dashboardScreen.dart';
import '../../size_config.dart';
import 'eventDetails_components.dart';

class body extends StatefulWidget {
  final List l;

  const body({Key? key, required this.l}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        reverse: false,
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment(0, 0),
                ),
                Container(
                  height: getHeight(50),
                  width: getWidth(kIsWeb ? 250 : double.infinity),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      left: 0, top: MediaQuery.of(context).size.height * 0.12),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          padding: EdgeInsets.only(bottom: 3, right: 8),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => dashboardScreen()));
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 30,
                          )),
                      Text(
                        'Event Details ',
                        style: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D2A3A)),
                      )
                    ],
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 250, // card height
                    width: getWidth(kIsWeb ? 250 : double.infinity),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(12),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return buildCard();
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 30);
                        }),
                  ),
                ),
                Container(
                  width: getWidth(kIsWeb ? 250 : double.infinity),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          eventDetails_components().text(widget.l[0],
                              FontWeight.bold, const Color(0xFF1D2A3A), 26),
                          eventDetails_components().text(widget.l[1],
                              FontWeight.bold, const Color(0xFF1D2A3A), 24),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      eventDetails_components().text(widget.l[2],
                          FontWeight.normal, const Color(0xFF1D2A3A), 18),
                      SizedBox(
                        height: 5,
                      ),
                      eventDetails_components().text(
                          "Time Slot : " + widget.l[3].toString(),
                          FontWeight.normal,
                          const Color(0xFF1D2A3A),
                          18),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              eventDetails_components().text("Show Attendees",
                                  FontWeight.bold, const Color(0xFF1D2A3A), 22),
                              // SizedBox(width: 20,),
                              Icon(
                                Icons.arrow_circle_right,
                                color: Color(0xFF1D2A3A),
                                size: 30,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => attendees()));
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              eventDetails_components().text("Show Faculty Coordinators",
                                  FontWeight.bold, const Color(0xFF1D2A3A), 22),
                              // SizedBox(width: 20,),
                              Icon(
                                Icons.arrow_circle_right,
                                color: Color(0xFF1D2A3A),
                                size: 30,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => coordinators(l: widget.l[4],)));
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              eventDetails_components().text("Show Student Coordinators",
                                  FontWeight.bold, const Color(0xFF1D2A3A), 22),
                              // SizedBox(width: 20,),
                              Icon(
                                Icons.arrow_circle_right,
                                color: Color(0xFF1D2A3A),
                                size: 30,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => coordinators(l: widget.l[5])));
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // eventDetails_components().text("Details",
                      //     FontWeight.normal, const Color(0xFF1D2A3A), 26),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 15, right: 5),
                      //   child: eventDetails_components().text(
                      //       "Starts \n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n Ends",
                      //       FontWeight.bold,
                      //       const Color(0xFF1D2A3A),
                      //       20),
                      // ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: getWidth(kIsWeb ? 100 : double.infinity),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF1D2A3A),
                                onSurface: Color(0xFF1D2A3A),
                                padding: EdgeInsets.all(3),
                                textStyle: TextStyle(fontSize: 20),
                                minimumSize: Size.fromHeight(50),
                                shape: StadiumBorder(),
                                enableFeedback: true,
                              ),
                              child: const Text('Book Event'),
                              onPressed: () {}),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard() => Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
        width: getWidth(kIsWeb ? 100 : MediaQuery.of(context).size.width * 0.8),
        height: 250,
      );
}
