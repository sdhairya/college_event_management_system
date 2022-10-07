import 'dart:convert';

import 'package:college_event_management/coordinators/coordinators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../attendees/attendees.dart';
import '../../dashboard/dashboardScreen.dart';
import '../../hms/event.dart';
import '../../size_config.dart';
import 'eventDetails_components.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  final EventData eventDetails;
  final String deptName;

  const body({Key? key, required this.eventDetails, required this.deptName})
      : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool isLoading = false;

  String assetURL = 'https://convergence.uvpce.ac.in/register/assets/';


  var stuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Align(
                              alignment: Alignment(0, 0),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                child: ListTile(
                                  leading: IconButton(
                                      padding: const EdgeInsets.only(
                                          bottom: 3, right: 8),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                        //
                                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        //     builder: (context) => dashboardScreen()));
                                      },
                                      icon: Icon(
                                        color: Color(0xFF1D2A3A),
                                        Icons.arrow_back_ios_new_rounded,
                                        size: 30,
                                      )),
                                  title: const Text(
                                    'Event Details ',
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1D2A3A)),
                                  ),
                                )),
                            Container(
                              child: SizedBox(
                                height: 250, // card height
                                width: getWidth(kIsWeb ? 250 : double.infinity),
                                child: Image.network(assetURL + widget.eventDetails.logo),
                                // ListView.separated(
                                //     scrollDirection: Axis.horizontal,
                                //     padding: const EdgeInsets.all(12),
                                //     itemCount: 5,
                                //     itemBuilder: (context, index) {
                                //       return buildCard();
                                //     },
                                //     separatorBuilder: (context, index) {
                                //       return const SizedBox(width: 30);
                                //     }),
                              ),
                            ),
                            Container(
                              width: getWidth(kIsWeb ? 250 : double.infinity),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: eventDetails_components().text(
                                        widget.eventDetails.name,
                                        FontWeight.bold,
                                        const Color(0xFF1D2A3A),
                                        26),
                                    trailing: eventDetails_components().text(
                                        widget.eventDetails.type,
                                        FontWeight.bold,
                                        const Color(0xFF1D2A3A),
                                        24),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  eventDetails_components().text(
                                      widget.eventDetails.date +
                                          "\n" +
                                          widget.eventDetails.time,
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      18),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  eventDetails_components().text(
                                      "Time Slot : " +
                                          widget.eventDetails.getCategoryTime(),
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      18),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  eventDetails_components().text(
                                      "Description",
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      22),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  eventDetails_components().text(
                                      widget.eventDetails.description,
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      15),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  //           InkWell(
                                  //             child: Container(
                                  //               padding: EdgeInsets.all(10),
                                  //               decoration: BoxDecoration(
                                  //                   color: Color(0xFFD9D9D9),
                                  //                   borderRadius: BorderRadius.circular(20)),
                                  //               child: Row(
                                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //                 children: [
                                  //                   eventDetails_components().text("Show Attendees",
                                  //                       FontWeight.bold, const Color(0xFF1D2A3A), 22),
                                  //                   // SizedBox(width: 20,),
                                  //                   Icon(
                                  //                     Icons.arrow_circle_right,
                                  //                     color: Color(0xFF1D2A3A),
                                  //                     size: 30,
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             /*onTap: () {
                                  //   Navigator.of(context).pushReplacement(
                                  //       MaterialPageRoute(
                                  //           builder: (context) => attendees(previousScreen_data: widget.eventDetails,)));
                                  // },*/
                                  //           ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        eventDetails_components().text(
                                            "Show Faculty Coordinators",
                                            FontWeight.bold,
                                            const Color(0xFF1D2A3A),
                                            22),

                                        Container(
                                          child: buildListWithoutScroll(widget
                                              .eventDetails.facultyCoordinator),
                                        )
                                        // SizedBox(width: 20,),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        eventDetails_components().text(
                                            "Show Student Coordinators",
                                            FontWeight.bold,
                                            const Color(0xFF1D2A3A),
                                            22),
                                        // SizedBox(width: 20,),
                                        Container(
                                          child: buildListWithoutScrollStudent(
                                              widget.eventDetails
                                                  .studentCoordinator),
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  eventDetails_components().text(
                                      "Rules/Regulation of Event",
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      22),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  eventDetails_components().text(
                                      widget.eventDetails.getAllRules(),
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      15),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  eventDetails_components().text(
                                      "Evaluation Criteria",
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      22),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  eventDetails_components().text(
                                      widget.eventDetails
                                          .getAllEvaluationCriteria(),
                                      FontWeight.normal,
                                      const Color(0xFF1D2A3A),
                                      15),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: getWidth(
                                          kIsWeb ? 100 : double.infinity),
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
                                          child: isLoading
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                )
                                              : const Text('Book Event'),
                                          onPressed: () {
                                            setState(() => isLoading = true);

                                            bookEvent();
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }

  Widget buildCard() => Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
        width: getWidth(kIsWeb ? 100 : MediaQuery.of(context).size.width * 0.8),
        height: 250,
      );

  Future bookEvent() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    stuid = studata.getString("stuid");
    var eventName = widget.eventDetails.name;

    var deptName = widget.deptName;

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/bookEvent.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "sid": stuid,
            "event_name": eventName,
            "department_name": deptName
          }),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);
      var response = json.decode(res.body);
      print(response["message"]);
      if (res.statusCode == 404) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content: Text("User Not Found !!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
        setState(() => isLoading = false);
      } else if (res.statusCode == 442) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content: Text("Bed Request!!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
        setState(() => isLoading = false);
      } else if (res.statusCode == 200) {
        if (response["message"] == "Event booked successfully!!") {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Convergence Confirmation'),
                    content: Text(response["message"]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'))
                    ],
                  ));
          setState(() => isLoading = false);
        } else if (response["message"] ==
                "Another event is already booked in same time slots.." ||
            response["message"] ==
                "You can not register for more than 3 events!") {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text(response["message"]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'))
                    ],
                  ));
          setState(() => isLoading = false);
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text(response["message"]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'))
                    ],
                  ));
          setState(() => isLoading = false);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildListWithoutScroll(List<FacultyData> facultyCoordinator) {
    return Column(
      children: facultyCoordinator.map((e) => buildList(e)).toList(),
    );
  }

  Widget buildListWithoutScrollStudent(List<StudentData> StudentCoordinator) {
    return Column(
      children: StudentCoordinator.map((e) => buildListStudent(e)).toList(),
    );
  }

  Widget buildList(FacultyData e) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          eventDetails_components()
              .text(e.name, FontWeight.bold, Color(0xFF1D2A3A), 16),
          SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            children: [
              Icon(
                Icons.mail,
                size: 15,
              ),
              eventDetails_components()
                  .text(e.emailId, FontWeight.normal, Color(0xFF1D2A3A), 14),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            children: [
              Icon(
                Icons.phone,
                size: 15,
              ),
              eventDetails_components()
                  .text(e.mobileNo, FontWeight.normal, Color(0xFF1D2A3A), 14),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListStudent(StudentData e) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          eventDetails_components()
              .text(e.name, FontWeight.bold, Color(0xFF1D2A3A), 16),
          SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            children: [
              Icon(
                Icons.mail,
                size: 15,
              ),
              eventDetails_components()
                  .text(e.emailId, FontWeight.normal, Color(0xFF1D2A3A), 14),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            children: [
              Icon(
                Icons.phone,
                size: 15,
              ),
              eventDetails_components()
                  .text(e.mobileNo, FontWeight.normal, Color(0xFF1D2A3A), 14),
            ],
          ),
        ],
      ),
    );
  }
}
