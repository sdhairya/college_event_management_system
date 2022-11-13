import 'dart:convert';

import 'package:college_event_management/campaignerDashBoard/components/campaignerDashBoard_components.dart';
import 'package:college_event_management/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hms/event.dart';
import '../../hms/event_parser.dart';
import '../../homepage/homepage.dart';
import '../../profileDetails/profileDetails.dart';
import '../campaignerDashBoard.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  var campId;
  var campaignerToken;

  List<ParticipantData> myparticipants = [];
  List<ParticipantData> totalparticipants = [];
  List<VisitedCollege> visitedcollege = [];


  @override
  void initState() {
    getcampData();
    myparticipants.clear();
    totalparticipants.clear();
    visitedcollege.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (myparticipants.isEmpty) {
      EventParser().getMyParticipants().then((value) {
        setState(() {
          myparticipants = value;
        });
      });
    }
    if (totalparticipants.isEmpty) {
      EventParser().getTotalParticipantsList().then((value) {
        setState(() {
          totalparticipants = value;
        });
      });
    }
    if (visitedcollege.isEmpty) {
      EventParser().getVisitedCollegeList().then((value) {
        setState(() {
         visitedcollege=value;
        });
      });
    }
    print(campaignerToken);

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF1D2A3A),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: campaignerDashBoard_components().icon(Icons.people, 40),
                  text: "My Participants",
                ),
                Tab(
                  icon: campaignerDashBoard_components().icon(Icons.people, 40),
                  text: "Total Participants",
                ),
                Tab(
                  icon: campaignerDashBoard_components()
                      .icon(Icons.account_balance, 40),
                  text: "Visited Colleges",
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildMenuItems(context),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                  // padding: EdgeInsets.all(50),
                  // margin: EdgeInsets.only(left: 200, right: 200, top: 50),
                  padding: MediaQuery.of(context).size.width < 1200 ? EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20) : const EdgeInsets.only(left: 200, right: 200, top: 50,bottom: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        campaignerDashBoard_components().text(
                            "My Participants = " +
                                myparticipants.length.toString(),
                            FontWeight.w500,
                            Color(0xFF1D2A3A),
                            28),
                        SizedBox(
                          height: 20,
                        ),
                        buildListWithoutScroll(myparticipants),
                      ],
                    ),
                  )
                  ),
              Container(
                  // padding: EdgeInsets.all(50),
                  margin: EdgeInsets.only(left: 200, right: 200, top: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        campaignerDashBoard_components().text(
                            "Total Participants = " +
                                totalparticipants.length.toString(),
                            FontWeight.w500,
                            Color(0xFF1D2A3A),
                            28),
                        SizedBox(
                          height: 20,
                        ),
                        buildListWithoutScroll(totalparticipants),
                      ],
                    ) ,
                  )
                  ),
              Container(
                // padding: EdgeInsets.all(50),
                  margin: EdgeInsets.only(left: 200, right: 200, top: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        campaignerDashBoard_components().text(
                            "Total Visited Colleges = " +
                                visitedcollege.length.toString(),
                            FontWeight.w500,
                            Color(0xFF1D2A3A),
                            28),
                        SizedBox(
                          height: 20,
                        ),
                        buildVisitedCollegeList(visitedcollege),
                      ],
                    ),
                  )
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildC(IconData icon, String text) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 3, color: Colors.grey),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * 0.2,
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              campaignerDashBoard_components().icon(icon, 50),
              SizedBox(
                height: 20,
              ),
              campaignerDashBoard_components()
                  .text(text, FontWeight.w700, Colors.black, 22),
              SizedBox(
                height: 10,
              ),
            ],
          )),
      onTap: () {
        setState(() {});
      },
    );
  }

  Widget buildListWithoutScroll(List<ParticipantData> list) {
    return Column(
        children: list.map((e) => buildList(e)).toList(),
    );
  }

  Widget buildList(ParticipantData element) {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 5, bottom: 5, right: 0),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFD9D9D9)),
      child: ListTile(
        title: ListTile(
            horizontalTitleGap: 15,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: CircleAvatar(
              // radius: SizeConfig.screenWidth! * 0.05,
              backgroundColor: Color(0xFF1D2A3A),
              child: campaignerDashBoard_components().text(
                  element.firstName[0], FontWeight.bold, Colors.white, 25),
            ),
            title: Wrap(
              spacing: getWidth(20),
              direction: Axis.horizontal,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      campaignerDashBoard_components().text(
                          element.firstName + " " + element.lastName,
                          FontWeight.bold,
                          Color(0xFF1D2A3A),
                          20),
                      SizedBox(
                        height: 5,
                      ),
                      campaignerDashBoard_components().text(element.email,
                          FontWeight.w500, Color(0xFF1D2A3A), 16),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      campaignerDashBoard_components().text(element.er_no,
                          FontWeight.w600, Color(0xFF1D2A3A), 16),
                      SizedBox(
                        height: 5,
                      ),
                      campaignerDashBoard_components().text(element.branch,
                          FontWeight.w500, Color(0xFF1D2A3A), 16),
                      SizedBox(
                        height: 5,
                      ),
                      campaignerDashBoard_components().text(element.college,
                          FontWeight.w500, Color(0xFF1D2A3A), 16),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget buildVisitedCollegeList(List<VisitedCollege> list){
    return Column(
      children: list.map((e) => buildVisited(e)).toList(),
    );
  }

  Widget buildVisited(VisitedCollege element) {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 5, bottom: 5, right: 0),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFD9D9D9)),
      child: ListTile(
        title: ListTile(
            horizontalTitleGap: 15,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: CircleAvatar(
              // radius: SizeConfig.screenWidth! * 0.05,
              backgroundColor: Color(0xFF1D2A3A),
              child: campaignerDashBoard_components().text(
                  element.college[0], FontWeight.bold, Colors.white, 25),
            ),
            title:  Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  campaignerDashBoard_components().text(
                      element.college,
                      FontWeight.bold,
                      Color(0xFF1D2A3A),
                      20),
                ],
              ),
            ),
          ),
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
            const campaignerDashBoard();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('My Profile'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => profileDetails()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Logout'),
          onTap: () async {
            SharedPreferences studata = await SharedPreferences.getInstance();
            SharedPreferences data = await SharedPreferences.getInstance();
            data.clear();
            studata.clear();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => homepage()));
          },
        ),
      ],
    );
  }

  Future getcampData() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    campId = studata.getString("stuid");
    var url = Uri.parse(
        "https://convergence.uvpce.ac.in/C2K22/CampaignerDashboard/campaignerPaticipants.php?id=$campId");
    var res = await http.get(url);
    var response = json.decode(res.body);
    setState(() {
      campaignerToken = response["campaigner_token"];
    });

    SharedPreferences camp = await SharedPreferences.getInstance();
    camp.setString("campaignerToken", campaignerToken);
  }

}
