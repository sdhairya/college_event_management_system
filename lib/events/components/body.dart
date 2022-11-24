import 'dart:collection';

import 'package:college_event_management/hms/event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../eventDetails/eventDetails.dart';
import '../../hms/event_parser.dart';
import '../../size_config.dart';
import 'events_components.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<myEventsData> myeventlist = [];
  List<String> list1 = <String>['Infocrats', 'Mech-Mechato', 'MATHMAGIX', 'PetroX',"Biotechnical", "CIVESTA","Electabuzz","General Events","MARITECH"];

  @override
  void initState() {
    myeventlist.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    if (myeventlist.isEmpty) {
      EventParser().myEvents().then((value) {
        // debugPrint(":::HMS:::Event_Data:::$value");
        setState(() {
          myeventlist = value;
        });
      });
      print(myeventlist);
    }


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: constraints.maxWidth < 500
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(30.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment(0, 0),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: ListTile(
                            dense: true,
                            horizontalTitleGap: 0,
                            leading: IconButton(
                                padding:
                                const EdgeInsets.only(bottom: 3, right: 3),
                                onPressed: () {
                                  //
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              dashboardScreen()));
                                },
                                icon: Icon(
                                  color: Color(0xFF1D2A3A),
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 20,
                                )),
                            title: const Text(
                              'Dashboard ',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1D2A3A)),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: events_components().text("My Events", FontWeight.bold, Color(0xFF1D2A3A), 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: buildListWithoutScroll(myeventlist),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildListWithoutScroll(List<myEventsData> list) {
    return
      Column(children:list.map((e) => buildCard(e)).toList()
      )
    ;
  }
  Widget buildCard(myEventsData e) =>
      Container(
        padding: EdgeInsets.only(left: 30, top: 5,bottom: 0, right: 30),
          margin: EdgeInsets.only(bottom: 10),
        // margin: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFD9D9D9)),
        child:
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              events_components().text(e.eventName, FontWeight.bold, Color(0xFF1D2A3A), 20),
              SizedBox(height: 5,),
              events_components().text(e.departmentName, FontWeight.normal, Color(0xFF1D2A3A), 14),
              SizedBox(height:5,),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 0,
                leading: events_components().icon(Icons.location_on),
                title: events_components().text(e.eventLocation, FontWeight.normal, Color(0xFF1D2A3A), 14),

              )
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              events_components().text(e.eventDate, FontWeight.normal, Color(0xFF1D2A3A), 14),
              SizedBox(height: 5,),
              events_components().text(e.eventTime+ "   "+e.timeslot, FontWeight.normal, Color(0xFF1D2A3A), 14),
              SizedBox(height:5,),
              // events_components().text(e.timeslot, FontWeight.normal, Color(0xFF1D2A3A), 14),

            ],
          ),
        )

      );
}
