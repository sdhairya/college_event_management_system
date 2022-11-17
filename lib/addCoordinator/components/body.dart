import 'dart:convert';

import 'package:college_event_management/addCoordinator/components/addCoordinator_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../../size_config.dart';
import 'package:http/http.dart' as http;

TextEditingController _coordiantorNameController = TextEditingController();
TextEditingController _coordiantorEmailController = TextEditingController();
TextEditingController _coordiantorPhoneController = TextEditingController();
TextEditingController _coordiantorEnrollmentController =
    TextEditingController();

class addCoordinator extends StatefulWidget {
  const addCoordinator({Key? key}) : super(key: key);

  @override
  State<addCoordinator> createState() => _addCoordinatorState();
}

class _addCoordinatorState extends State<addCoordinator> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  var uuid = Uuid();
  var userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            Column(
              children: [
                const Align(
                  alignment: Alignment(0, 0),
                ),
                Container(
                  height: getHeight(50),
                  width: getWidth(kIsWeb ? 100 : double.infinity),
                  margin: EdgeInsets.only(
                      left: 20, top: MediaQuery.of(context).size.height * 0.12),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          padding: EdgeInsets.only(bottom: 3, right: 8),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 30,
                          )),
                      addCoordinator_components().text("Add Coordinator",
                          FontWeight.w600, Color(0xFF1D2A3A), 35),
                      // Text(
                      //   'Add Coordinator ',
                      //   style: TextStyle(
                      //       fontSize: 35,
                      //       fontStyle: FontStyle.normal,
                      //       fontWeight: FontWeight.w600,
                      //       color: Color(0xFF1D2A3A)),
                      // )
                    ],
                  ),
                ),
                Container(
                  // height: getHeight(555),
                  width: getWidth(kIsWeb ? 100 : double.infinity),
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
                      const addCoordinator_components().text(
                          '   Name', FontWeight.normal, Color(0xFF1D2A3A), 16),
                      const SizedBox(
                        height: 10,
                      ),
                      const addCoordinator_components().textField(
                          "Enter Your Name",
                          TextInputType.text,
                          _coordiantorNameController),
                      const SizedBox(
                        height: 30,
                      ),
                      const addCoordinator_components().text(
                          '   Email', FontWeight.normal, Color(0xFF1D2A3A), 16),
                      const SizedBox(
                        height: 10,
                      ),
                      const addCoordinator_components().textField(
                          "Enter Email",
                          TextInputType.emailAddress,
                          _coordiantorEmailController),
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
                              child: const Text('Add Coordinator'),
                              onPressed: () async {
                                if (isLoading) return;
                                setState(() => isLoading = true);

                                bool emailValid = RegExp(
                                        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(_emailController.text);
                                print ("addCoordinatorEmail: $emailValid");                                if (_emailController.text.isNotEmpty &&
                                    _nameController.text.isNotEmpty) {
                                  if (emailValid) {
                                    addCoordinator();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  "Please enter valid email!!"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            ));
                                    setState(() => isLoading = false);
                                  }
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
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future addCoordinator() async {
    userId = uuid.v4();
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

        addStuCoordinator();
        // Fluttertoast.showToast(
        //     msg: "Faculty Added Successfully!!",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        // print("faculty added Successfully!!");
        // setState(() => isLoading = false);
        //
        // _emailController.text = "";
        // _nameController.text = "";

        // print(response);
      } else {
        print("some issue");
        Fluttertoast.showToast(
          msg: "Some issue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() => isLoading = false);
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
      setState(() => isLoading = false);
    }
  }

  Future addStuCoordinator() async{

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/addStudentCoordinator.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "id": userId,
            "email": _emailController.text,
            "userName": _nameController.text

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
            msg: "Student Coordinator Added Successfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Student Coordinator added Successfully!!");
        setState(() => isLoading = false);

        _emailController.text = "";
        _nameController.text = "";


      } else {
        print("some issue");
        setState(() => isLoading = false);
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
      setState(() => isLoading = false);
    }

  }
}
