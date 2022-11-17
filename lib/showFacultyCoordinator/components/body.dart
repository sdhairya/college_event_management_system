import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  var responseData;

  @override
  Widget build(BuildContext context) {
    getFacultyCoordinatorList();
    deleteFacultyCoordinator();
    return Container();
  }

  Future getFacultyCoordinatorList() async {

    final url =
        Uri.parse("https://convergence.uvpce.ac.in/C2K22/addFaculty.php");
    final response = await http.get(url);
    responseData = json.decode(response.body);
    print(responseData);

  }

  Future deleteFacultyCoordinator() async {
    var id;
    try {
      final url =
          Uri.parse("https://convergence.uvpce.ac.in/C2K22/addFaculty.php?id=$id");
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
                  content: Text("Faculty Coordinator deleted successfully!!"),
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
