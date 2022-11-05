import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:college_event_management/size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../main.dart';
import '../addFaculty.dart';
import 'addFaculty_components.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../dashboard/dashboardScreen.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints){
          return AnimatedContainer(duration: const Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500 ? EdgeInsets.zero : const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
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
                      child: addFaculty_components().text("Add Faculty", FontWeight.bold, Color(0xFF1D2A3A), 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // width: kIsWeb ? 600 : double.infinity,
                      // constraints: BoxConstraints(maxWidth: 1000),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: MediaQuery.of(context).size.height * 0.06),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const addFaculty_components().text("    Name",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          const addFaculty_components().textField(
                              "Enter Name", TextInputType.text, _nameController),
                          const SizedBox(
                            height: 30,
                          ),
                          const addFaculty_components().text("    Email",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          const addFaculty_components().textField("Enter Email",
                              TextInputType.emailAddress, _emailController),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 5),
                              child: Container(
                                alignment: Alignment.center,
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
                                    backgroundColor: Colors.transparent,
                                  )
                                      : const Text('Add Faculty'),
                                  onPressed: () async {
                                    if (isLoading) return;
                                    setState(() => isLoading = true);

                                    if (_emailController.text.isNotEmpty &&
                                        _nameController.text.isNotEmpty) {
                                      addFaculty();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Any field can not be empty!!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() => isLoading = false);
                                    }
                                  },
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },)
      ),
    );
  }

  Future addFaculty() async {
    var userId = uuid.v4();
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/auth/signup.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "id": userId,
            "email": _emailController.text,
            "userName": _nameController.text,
            "role": "faculty",
            "password": "Convergence@uvpce"
          }),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("User Not Found Check your Email Or Password!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
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
                child: Text('Ok'),
              )
            ],
          ),
        );
        setState(() => isLoading = false);
      } else if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Faculty Added Successfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("faculty added Successfully!!");
        setState(() => isLoading = false);

        _emailController.text = "";
        _nameController.text = "";

        // print(response);
      } else {
        print("some issue");
        setState(() => isLoading = false);
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  }
