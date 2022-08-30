import 'dart:async';
import 'dart:js';

import 'package:college_event_management/dashboardScreen.dart';
import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../addFaculty/components/body.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:college_event_management/emailVerification.dart';
import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../login/main.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/framework.dart';


class addFaculty extends StatefulWidget {
  const addFaculty({Key? key}) : super(key: key);

  @override
  State<addFaculty> createState() => _addFacultyState();

  Future addFacultyDetails(String name, String email) async {
    dynamic _password = "gnuConvergence@2022";
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: _password);

      var uid  =  FirebaseAuth.instance.currentUser!.uid;
      print(uid);
     insertUser(name, email);

      // await FirebaseFirestore;
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
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

    Fluttertoast.showToast(
        msg: messageToDisplay,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    // showDialog(
    //     context: body().createState().context,
    //     builder: (context) =>
    //         AlertDialog(
    //           title: Text('Registration up failed!'),
    //           content: Text(messageToDisplay),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Text('Ok'))
    //           ],
    //         ));
  }

  Future insertUser(String name, String email) async {
    var userId = FirebaseAuth.instance.currentUser?.uid.toString();
    print(userId);
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/insert_user.php";
      var res = await http.post(Uri.parse(uri), body: json.encode({
        "uid": userId,
        "email": email,
        "userName": name,
        "privilege": "faculty"
      }), headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      }, encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 200) {
        print("User added Successfully!!");
        //setState(() => isLoading = false);
        Fluttertoast.showToast(
            msg: "User added Successfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // showDialog(
        //     context: body().createState().context,
        //     builder: (context) =>
        //         AlertDialog(
        //           title: Text('Add Faculty!!'),
        //           content: Text("Faculty added Successfully!!"),
        //           actions: [
        //             TextButton(
        //                 onPressed: () {
        //                 //  Navigator.of(context).pop();
        //
        //                   Navigator.of(context).pushReplacement(
        //                       MaterialPageRoute(
        //                           builder: (context) =>
        //                               addFaculty()));
        //                 },
        //                 child: Text('Ok'))
        //           ],
        //         ));


      } else {
        print("some issue");
        //setState(() => isLoading = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }


}


class _addFacultyState extends State<addFaculty> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return body();
  }


}


