import 'dart:convert';

import 'package:college_event_management/profileDetails/components/profile_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../hms/event.dart';
import '../../hms/event_parser.dart';
import '../../size_config.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  var responseData;
  var stuId;
  List<String?> profilelist = [];



  @override
  void initState() {
    fetchData();
    // if(profilelist.isEmpty){
    //   EventParser().getProfileData(stuId).then((value) {
    //     setState(() {
    //       profilelist=value;
    //     });
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    if(profilelist.isEmpty){
      getData().then((value) {
        setState(() {
          profilelist=value;
        });
      });
    }
    print(profilelist);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
            // padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            reverse: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: constraints.maxWidth < 500
                      ? EdgeInsets.zero
                      : const EdgeInsets.all(30.0),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment(0, 0),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: ListTile(
                                dense: true,
                                horizontalTitleGap: 0,
                                leading: IconButton(
                                    padding: const EdgeInsets.only(
                                        bottom: 3, right: 3),
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
                                      size: 25,
                                    )),
                                title: const Text(
                                  'Profile ',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1D2A3A)),
                                ),
                              )),
                          Container(
                              padding: EdgeInsets.only(
                                left: 5,
                                top: 40,
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundColor: Colors.cyan,
                                    child: Center(
                                      child: profile_components().text(profilelist[0]![0]+profilelist[1]![0],
                                          FontWeight.bold, Colors.white, 80),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  profile_components().text(profilelist[0]!+" "+profilelist[1]!,
                                      FontWeight.bold, Color(0xFF1D2A3A), 26),
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              children: [
                                buildDetails(Icons.location_on, profilelist[8]!),
                                buildDetails(Icons.mail, profilelist[2]!),
                                buildDetails(Icons.phone, profilelist[4]!),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              children: [
                                buildDetails(Icons.account_tree, profilelist[5]!),
                                buildDetails(Icons.category, profilelist[6]!),
                                buildDetails(Icons.account_balance, profilelist[7]!),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  Widget buildDetails(IconData icon, String text) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      leading: profile_components().icon(icon),
      title: profile_components()
          .text(text, FontWeight.normal, Color(0xFF1D2A3A), 20),
    );
  }

  Future getData() async{
    SharedPreferences studata = await SharedPreferences.getInstance();
    String? fname=studata.getString("fname");
    String? lname=studata.getString("lname");
    String? email=studata.getString("email");
    String? eno=studata.getString("eno");
    String? mobile=studata.getString("mobile");
    String? branch=studata.getString("branch");
    String? sem=studata.getString("sem");
    String? college=studata.getString("college");
    String? address= studata.getString("address");

    List<String?> data= [fname, lname, email, eno, mobile, branch, sem, college, address];
    return data;
  }

  Future fetchData() async {
    SharedPreferences studata = await SharedPreferences.getInstance();

    stuId = studata.getString("stuid");
    final url = Uri.parse(
        "https://convergence.uvpce.ac.in/C2K22/studentProfile.php?id=$stuId");
    final response = await http.get(url);
    responseData = json.decode(response.body);
    studata.setString("fname",responseData['firstName'].toString());
    studata.setString("lname",responseData['lastName'].toString());
    studata.setString("email",responseData['email'].toString());
    studata.setString("eno",responseData['er_no'].toString());
    studata.setString("mobile", responseData['mobile'].toString());
    studata.setString("branch", responseData['branch'].toString());
    studata.setString("sem", responseData['sem'].toString());
    studata.setString("college", responseData['college'].toString());
    studata.setString("address", responseData['address'].toString());

  }
}
