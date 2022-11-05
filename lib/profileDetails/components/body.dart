import 'dart:convert';

import 'package:college_event_management/profileDetails/components/profile_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboardScreen.dart';
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

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List<String> list = <String>[
    'Tech',
    'Talk',
    'Funny',
    'Sports',
    "Logical",
    "Coding"
  ];

  @override
  Widget build(BuildContext context) {
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
                                      child: profile_components().text("T",
                                          FontWeight.bold, Colors.white, 80),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  profile_components().text("test",
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
                                buildDetails(Icons.location_on, "Address"),
                                buildDetails(Icons.mail, "abc@gmail.com"),
                                buildDetails(Icons.phone, "1234567890"),
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
                                buildDetails(Icons.account_tree, "IT"),
                                buildDetails(Icons.category, "7"),
                                buildDetails(Icons.account_balance, "UVPCE"),
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

  Future fetchData() async {
    SharedPreferences studata = await SharedPreferences.getInstance();

    stuId = studata.getString("stuid");
    final url = Uri.parse(
        "https://convergence.uvpce.ac.in/C2K22/studentProfile.php?id=$stuId");
    final response = await http.get(url);
    responseData = json.decode(response.body);

    print(responseData);
  }
}
