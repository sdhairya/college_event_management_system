import 'dart:convert';

import 'package:college_event_management/login/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:college_event_management/size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../addFaculty.dart';
import 'addFaculty_components.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
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

                            signOut();

                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 30,
                          )),
                      Text(
                        'Add Faculty',
                        style: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D2A3A)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: getHeight(555),
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
                      const addFaculty_components().text("    Name"),
                      const SizedBox(
                        height: 10,
                      ),
                      const addFaculty_components().textField(
                          "Enter Name", TextInputType.text, _nameController),
                      const SizedBox(
                        height: 30,
                      ),
                      const addFaculty_components().text("    Email"),
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
            )
          ],
        ),
      ),
    );
  }

  Future addFaculty() async {
    dynamic _password = "gnuconvergence@2022";
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _password);

      insertUser();

      // await FirebaseFirestore;
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
      setState(() => isLoading = false);
    }
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;

    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'This email is already in use!';
        break;
      case 'invalid-email':
        messageToDisplay = 'This email you entered is invalid!';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'This operation is not allowed!';
        break;
      case 'weak-password':
        messageToDisplay = 'This password you entered is too weak!';
        break;
      default:
        messageToDisplay = 'An unknown error occurred!';
        break;
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Registration up failed!'),
              content: Text(messageToDisplay),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  Future insertUser() async {
    var userId = FirebaseAuth.instance.currentUser?.uid.toString();
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/insert_user.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "uid": userId,
            "email": _emailController.text,
            "userName": _nameController.text,
            "privilege": "faculty"
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
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Faculty added Successfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("User added Successfully!!");
        setState(() => isLoading = false);
        _nameController.text = "";
        _emailController.text = "";

        print("User added Successfully!!");

        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        print("some issue");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomePage()));
  }

// Future addFacultyDetails(String name, String email) async {
//   dynamic _password = "gnuConvergence@2022";
//   try {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: _password);
//
//     var uid  =  FirebaseAuth.instance.currentUser!.uid;
//     print(uid);
//     insertUser(name, email);
//
//     // await FirebaseFirestore;
//   } on FirebaseAuthException catch (e) {
//     _handleSignUpError(e);
//   }
// }
//
// void _handleSignUpError(FirebaseAuthException e) {
//   String messageToDisplay;
//
//   switch (e.code) {
//     case 'email-already-in-use':
//       messageToDisplay = 'This email is already in use!';
//       break;
//     case 'invalid-email':
//       messageToDisplay = 'This email you entered is invalid!';
//       break;
//     case 'operation-not-allowed':
//       messageToDisplay = 'This operation is not allowed!';
//       break;
//     case 'weak-password':
//       messageToDisplay = 'This password you entered is too weak!';
//       break;
//     default:
//       messageToDisplay = 'An unknown error occurred!';
//       break;
//   }
//
//   Fluttertoast.showToast(
//       msg: messageToDisplay,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0);
//
//   // showDialog(
//   //     context: body().createState().context,
//   //     builder: (context) =>
//   //         AlertDialog(
//   //           title: Text('Registration up failed!'),
//   //           content: Text(messageToDisplay),
//   //           actions: [
//   //             TextButton(
//   //                 onPressed: () {
//   //                   Navigator.of(context).pop();
//   //                 },
//   //                 child: Text('Ok'))
//   //           ],
//   //         ));
// }
//
// Future insertUser(String name, String email) async {
//   var userId = FirebaseAuth.instance.currentUser?.uid.toString();
//   print(userId);
//   try {
//     String uri = "https://convergence.uvpce.ac.in/C2K22/insert_user.php";
//     var res = await http.post(Uri.parse(uri), body: json.encode({
//       "uid": userId,
//       "email": email,
//       "userName": name,
//       "privilege": "faculty"
//     }), headers: {
//       "Accept": "application/json",
//       "Access-Control-Allow-Origin": "*"
//     }, encoding: Encoding.getByName('utf-8'));
//     print(res.statusCode);
//     //  var response = json.decode(res.body);
//
//     //print(response["firebaseId"]);
//     //print(response);
//     if (res.statusCode == 200) {
//       print("User added Successfully!!");
//       //setState(() => isLoading = false);
//       Fluttertoast.showToast(
//           msg: "User added Successfully!!",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//       // showDialog(
//       //     context: body().createState().context,
//       //     builder: (context) =>
//       //         AlertDialog(
//       //           title: Text('Add Faculty!!'),
//       //           content: Text("Faculty added Successfully!!"),
//       //           actions: [
//       //             TextButton(
//       //                 onPressed: () {
//       //                 //  Navigator.of(context).pop();
//       //
//       //                   Navigator.of(context).pushReplacement(
//       //                       MaterialPageRoute(
//       //                           builder: (context) =>
//       //                               addFaculty()));
//       //                 },
//       //                 child: Text('Ok'))
//       //           ],
//       //         ));
//
//
//     } else {
//       print("some issue");
//       //setState(() => isLoading = false);
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }

// void get() async{
//
//   setState(() => isLoading=temp);
// }
}
