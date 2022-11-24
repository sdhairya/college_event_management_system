import 'dart:convert';

import 'package:college_event_management/showStudentCoordinator/components/showStudentCoordinator_components.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import '../../dashboard/dashboardScreen.dart';
import '../../hms/event.dart';
import '../../hms/event_parser.dart';
import '../showStudentCoordinator.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  var responseData;
  List<ProfileData> liststudent = [];

  @override
  Widget build(BuildContext context) {
    if(liststudent.isEmpty){
      EventParser().getFacultyCoordinatorList().then((value) {
        setState(() {
          liststudent=value;
        });
      });
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
                        child: showStudentCoordinator_components().text("Show Student Coordinators", FontWeight.bold, Color(0xFF1D2A3A), 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: buildListWithoutScroll(liststudent),
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

  Widget buildListWithoutScroll(List<ProfileData> list) {
    return Column(
      children: list.map((e) => buildList(e)).toList(),
    );

  }

  Widget buildList(ProfileData element) {
    return  Container(
      padding: EdgeInsets.only(left: 0, top: 5,bottom: 5, right: 0),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFD9D9D9)),
      child: ListTile(
        title:
        ListTile(horizontalTitleGap: 15,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: CircleAvatar(
              // radius: SizeConfig.screenWidth! * 0.05,
              backgroundColor: Color(0xFF1D2A3A),
              child: showStudentCoordinator_components().text(element.firstName[0], FontWeight.bold, Colors.white, 25),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showStudentCoordinator_components().text(element.firstName +" "+ element.lastName, FontWeight.bold, Color(0xFF1D2A3A), 20),
                SizedBox(height: 5,),
                showStudentCoordinator_components().text(element.email, FontWeight.normal, Color(0xFF1D2A3A), 14),
                SizedBox(height: 5,),
                showStudentCoordinator_components().text(element.mobile, FontWeight.normal, Color(0xFF1D2A3A), 14),
              ],
            ),
            trailing: InkWell(
              child: Icon(Icons.delete,size: 30,color: Color(0xFF1D2A3A),),
              onTap: () {
                deleteStudentCoordinator(element.sid);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            showStudentCoordinator()));

              },
            )
        ),


      ),

    );
  }

  Future getStudentCoordinatorList() async {
    final url =
    Uri.parse("https://convergence.uvpce.ac.in/C2K22/addStudentCoordinator.php");
    final response = await http.get(url);
    responseData = json.decode(response.body);
    print(responseData);

  }

  Future deleteStudentCoordinator(String id) async {

    var id;
    try {
      final url =
      Uri.parse("https://convergence.uvpce.ac.in/C2K22/addStudentCoordinator.php?id=$id");
      final res = await http.delete(url);

      responseData = json.decode(res.body);
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
      } else if (res.statusCode == 200) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Status'),
              content: Text("Student Coordinator deleted successfully!!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

