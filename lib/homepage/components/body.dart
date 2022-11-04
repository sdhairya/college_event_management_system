import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:college_event_management/homepage/components/components.dart';

import '../../eventsList/eventList.dart';
import '../../hms/event.dart';
import '../../hms/event_parser.dart';
import '../../size_config.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  List<EventDeptData> eventlist = [];
  String assetURL = 'https://convergence.uvpce.ac.in/register/assets/';



  List<Widget> navItems = [
    ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.transparent),onPressed: () {}, child: components().text("Home", FontWeight.normal, Colors.white, 16)),
    ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.transparent),onPressed: () {}, child: components().text("Events", FontWeight.normal, Colors.white, 16)),
    ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.transparent),onPressed: () {}, child: components().text("About", FontWeight.normal, Colors.white, 16)),
    Padding(padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 50),child:     ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.white, shape: StadiumBorder(),),onPressed: () {}, child: components().text("Login", FontWeight.bold, Color(0xFF01093a), 18)),),
  ];

  @override
  Widget build(BuildContext context) {
    bool narrow = MediaQuery.of(context).size.width>700 ? false : true;

    SizeConfig().init(context);
    final widthCount = (MediaQuery.of(context).size.width ~/ 250).toInt();

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF01093a),
        title: components().text("Event Management System", FontWeight.normal, Colors.white, 20),
        actions: narrow ? null : navItems,
      ),
      drawer: narrow ? Drawer(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: navItems,
        ),
      ) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          child:
          LayoutBuilder(builder: (context, constraints){
            return AnimatedContainer(duration: Duration(milliseconds: 500),
              padding: constraints.maxWidth<500 ? EdgeInsets.zero : const EdgeInsets.all(30),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: double.maxFinite),
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.868,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 100,bottom: 100),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/img.jpg"),
                                fit: BoxFit.cover),
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              components().text("Welcome,", FontWeight.bold, Colors.white, 80),
                              components().text("\nParticipate in any event of your choice,", FontWeight.w400, Colors.white, 25),
                              components().text("There are many different type and categories of events available", FontWeight.w400, Colors.white, 25)

                            ],
                          )
                      ),

                      Container(
                        decoration: const BoxDecoration(
                         color: Colors.black12
                             
                        ),
                        child: Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.2, right: MediaQuery.of(context).size.width*0.2),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: getWidth(30),
                    runSpacing: getHeight(20),
                    direction: Axis.horizontal,
                    children: eventlist.map((e) => buildC(e.name, e.logo)).toList(),
                  ),)

                      )],
                  ),
                ),
              ),
            );
          },),
        ),
      )

    );
  }

  Widget buildC(String categoryName, String logo) {
    return  InkWell(
      child: Column(
        children: [
          CircleAvatar(
            radius: kIsWeb
                ? SizeConfig.screenWidth! * 0.06
                : SizeConfig.screenWidth! * 0.16,
            child: ClipOval(
                child:
                // kIsWeb
                //     ?
                Image.network(
                  logo.isEmpty ? assetURL + 'assets/event1.png' : assetURL + logo,
                  fit: BoxFit.fill,
                  height: double.maxFinite,
                  width: double.maxFinite,
                )
              // : Image.asset(
              //     logo.isEmpty ? 'assets/event1.png' : logo,
              //     fit: BoxFit.fill,
              //     height: double.maxFinite,
              //     width: double.maxFinite,
              //   ),
            ),
          ),
          components().text(
            categoryName,
            FontWeight.w300,
            Color(0xFF1D2A3A),
            23,
          ),
        ],
      ),
      onTap: () {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => eventList(
        //       eventListData: eventListData,
        //       categoryName: categoryName,
        //       logo: logo.isEmpty ? 'assets/event1.png' : logo,
        //     ),
        //   ),
        // );
      },
    );
  }




}
