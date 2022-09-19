import 'dart:developer';
import 'dart:math';

import 'package:college_event_management/addCoordinator/components/body.dart';
import 'package:college_event_management/createProfile/createProfile.dart';
import 'package:college_event_management/hms/event_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../addFaculty/addFaculty.dart';
import '../../createEvent/createEvent.dart';
import '../../eventDetails/eventDetails.dart';
import '../../events/events.dart';
import '../../hms/event.dart';
import '../../size_config.dart';
import '../../timerScreen/timer.dart';
import '../dashboardScreen.dart';
import 'dashboard_components.dart';
import 'package:college_event_management/eventsList/eventList.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:college_event_management/eventData.dart' as data;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<EventDeptData> eventlist = [];

  @override
  void initState() {
    eventlist.clear();
    super.initState();
  }

  List<String> eventsCategories = <String>[
    'Infocrats',
    'Mech-Mechato',
    'MATHMAGIX',
    'PetroX',
    "Biotechnical",
    "CIVESTA",
    "Electabuzz",
    "MARITECH"
  ];
  final List<String> elements = [
    "Zero",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "A Million Billion Trillion",
    "A much, much longer text that will still fit"
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var i;
    final widthCount = (MediaQuery
        .of(context)
        .size
        .width ~/ 250).toInt();

    final minCount = 2;

    if (eventlist.isEmpty) {
      EventParser().getDeptEventList().then((value) {
        // debugPrint(":::HMS:::Event_Data:::$value");
        setState(() {
          eventlist = value;
        });
      });
    }
    return Scaffold(
        appBar: AppBar(backgroundColor: Color(0xFF1D2A3A)),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Align(
                alignment: Alignment(0, 0),
              ),
              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    dashboard_components().text("Welcome Dhairya,",
                        FontWeight.bold, const Color(0xFF1D2A3A), 25),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                  width: getWidth(kIsWeb ? 250 : double.infinity),
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dashboard_components().text("",
                          FontWeight.normal, const Color(0xFF1D2A3A), 16),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
              /*Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: getWidth(kIsWeb
                          ? 225
                          : MediaQuery.of(context).size.width * 0.7),
                      child: dashboard_components().textFormField("Search"),
                    ),
                    SizedBox(
                      width: getWidth(3),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary: Color(0xFF1D2A3A),
                          onSurface: Color(0xFF1D2A3A),
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 20, right: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: StadiumBorder(),
                          enableFeedback: true,
                        ),
                        child: IconButton(
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => createEvent()));
                            },
                            icon: Icon(
                              Icons.filter_list_rounded,
                              size: 30,
                            )),
                        onPressed: () {})
                  ],
                ),
              ),*/
              SizedBox(
                height: 40,
              ),
              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: dashboard_components()
                    .text("Categories", FontWeight.w300, Color(0xFF1D2A3A), 23),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (i in eventlist)
                        dashboard_components()
                            .elevatedButton(true, i.name.toString()),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              // Container(
              //   width: getWidth(kIsWeb ? 250 : double.infinity),
              //   child: dashboard_components()
              //       .text("Infocrafts", FontWeight.w300, Color(0xFF1D2A3A), 23),
              // ),
              // Container(
              //   child: SizedBox(
              //     height: 320, // card height
              //     width: getWidth(kIsWeb ? 250 : double.infinity),
              //     child: ListView.separated(
              //         scrollDirection: Axis.horizontal,
              //         padding: const EdgeInsets.all(12),
              //         itemCount: data.Infocrafts.length,
              //         itemBuilder: (context, index) {
              //           return buildCard(index, list: data.Infocrafts);
              //         },
              //         separatorBuilder: (context, index) {
              //           return const SizedBox(width: 30);
              //         }),
              //   ),
              // ),


              Container(
                  width: getWidth(kIsWeb ? 250 : double.infinity),
                  child:
                  buildCategoriesListWithoutScroll(
                      eventlist, max(widthCount, minCount))


              ),

              // Container(
              //   width: getWidth(kIsWeb ? 250 : double.infinity),
              //   child: LayoutBuilder(builder: (context, constraints) {
              //     return GridView.builder(
              //       itemCount: 1,
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) => Column(
              //         children: [
              //           CircleAvatar(
              //             child: Image.asset("assets/event1.png"),
              //           ),
              //           dashboard_components()
              //               .text(categoryName, FontWeight.w300, Color(0xFF1D2A3A), 23),
              //         ],
              //       ),
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: cols,
              //         childAspectRatio: 2,),);
              //   })
              // )


            ],
          ),
        ));
  }

  // Widget buildWrapProductList(List<EventData> eventListData) {
  //   return
  //     Flexible(
  //         child:
  //         SingleChildScrollView(
  //             scrollDirection: Axis.vertical,
  //             child: Wrap(
  //               alignment: WrapAlignment.spaceEvenly,
  //               spacing: getWidth(20),
  //               runSpacing: getHeight(20),
  //               direction: Axis.horizontal,
  //               children: eventListData.map((e) {
  //                 return buildCard(e);
  //               }).toList(),
  //             )
  //         )
  //     )
  //   ;
  // }

  buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery
            .of(context)
            .padding
            .top,
      ),
    );
  }

  buildMenuItems(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.home_filled),
          title: const Text('Home'),
          onTap: () {
            const dashboardScreen();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.event_note),
          title: const Text('Create Event'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => createEvent()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle),
          title: const Text('Add Faculty'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => addFaculty()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Timer'),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => timer()));
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.settings),
        //   title: const Text('Profile'),
        //   onTap: () {
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => profileDetails()));
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Create Profile'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => createProfile()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('My Events'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => events()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Add Coordinator'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => addCoordinator()));
          },
        ),
      ],
    );
  }

  Widget buildCategoriesListWithoutScroll(List<EventDeptData> list, int cols) {
    return
      Flexible(
          child:
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: getWidth(20),
                  runSpacing: getHeight(20),
                  direction: Axis.horizontal,
                  children: list.map((e) => buildC(e.name, e.eventList, e.logo))
                      .toList()
                // eventListData.map((e) {
                //   return buildCard(e);
                // }).toList(),
              )
          )
      );
    Column(
        children: list.map((e) => buildView(e.name, e.eventList, cols)).toList()
    )
    ;
  }

  Widget buildC(String categoryName, List<EventData> eventListData,
      String logo,) =>
      InkWell(
        child: Column(
          children: [
            CircleAvatar(
              radius: kIsWeb ? SizeConfig.screenWidth! * 0.05 : SizeConfig.screenWidth! * 0.16,
              child: ClipOval(
                child: Image.asset(
                  logo.isEmpty ? 'assets/event1.png' : logo, fit: BoxFit.fill,
                  height: double.maxFinite,
                  width: double.maxFinite,),
              ),

            ),
            dashboard_components()
                .text(
                categoryName, FontWeight.w300, Color(0xFF1D2A3A),
                23),
          ],
        ),

        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => eventList(eventListData: eventListData,categoryName: categoryName,logo: logo.isEmpty ? 'assets/event1.png' : logo,)));
        },
      );

  Widget buildView(String categoryName, List<EventData> eventListData,
      int cols) {
    final widthCount = (MediaQuery
        .of(context)
        .size
        .width ~/ 250).toInt();

    final minCount = 1;

    return Container(
      width: getWidth(kIsWeb ? 250 : double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
              width: getWidth(kIsWeb ? 250 : double.infinity),
              child: LayoutBuilder(builder: (context, constraints) {
                return GridView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      Column(
                        children: [
                          CircleAvatar(
                            child: Image.asset("assets/event1.png"),
                          ),
                          dashboard_components()
                              .text(
                              categoryName, FontWeight.w300, Color(0xFF1D2A3A),
                              23),
                        ],
                      ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: max(widthCount, minCount),
                    childAspectRatio: 2,),);
              })
            // dashboard_components()
            //     .text(categoryName, FontWeight.w300, Color(0xFF1D2A3A), 23),
          ),
          // Container(
          //   child:
          //   /*SizedBox(
          //     height: 320, // card height
          //     width: getWidth(kIsWeb ? 250 : double.infinity),
          //     child:*/
          //     buildWrapProductList(eventListData)
          //     /*ListView.separated(
          //         scrollDirection: Axis.horizontal,
          //         padding: const EdgeInsets.all(12),
          //         itemCount: eventListData.length,
          //         itemBuilder: (context, index1) {
          //           return buildCard(eventListData[index1]);
          //         },
          //         separatorBuilder: (context, index) {
          //           return const SizedBox(width: 30);
          //         }),*/
          //   //),
          // ),
        ],
      ),
    );
  }

  // Widget buildCard(EventData element) =>
  //     Container(
  //         decoration: BoxDecoration(
  //             color: Colors.black12, borderRadius: BorderRadius.circular(20)),
  //         width: 250,
  //         height: 320,
  //         child: InkWell(
  //           child: Column(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: Colors.black45,
  //                     borderRadius: BorderRadius.circular(20)),
  //                 child: SizedBox(
  //                   child: Image.asset(
  //                       element.logo.isEmpty ? 'assets/event1.png' : element
  //                           .logo),
  //                   height: 170,
  //                   width: 250,
  //                 ),
  //               ),
  //               Container(
  //                 padding: EdgeInsets.only(
  //                     right: 15, left: 15, top: 10, bottom: 5),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         // Text("29 Nov, 2022"),
  //                         // SizedBox(
  //                         //   width: 5,
  //                         // ),
  //                         Text(element.date + "\n" + element.time),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(element.name,
  //                         style: TextStyle(fontWeight: FontWeight.bold)),
  //                     SizedBox(
  //                       height: 3,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 5,
  //               ),
  //               SizedBox(
  //                 width: 120,
  //                 height: 30,
  //                 child: ElevatedButton(
  //                     onPressed: () {
  //                       createEvent();
  //                     },
  //                     child: Text("Register"),
  //                     style: ElevatedButton.styleFrom(
  //                       primary: Color(0xFF1D2A3A),
  //                       onSurface: Color(0xFF1D2A3A),
  //                       textStyle: TextStyle(fontSize: 20),
  //                       shape: StadiumBorder(),
  //                     )),
  //               )
  //             ],
  //           ),
  //           onTap: () {
  //             Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                 builder: (context) =>
  //                     eventDetails(
  //                       inputList: element, deptName: ,
  //                     )));
  //           },
  //         ));
}
