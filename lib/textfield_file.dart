import 'package:college_event_management/dashboardScreen.dart';
import 'package:college_event_management/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class textfield_file extends StatelessWidget {

  final String hint;
  final TextInputType inputtype;
  // final String controller;


  const textfield_file({Key? key, required this.hint, required this.inputtype}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)),
          hintText: hint,
        ),
        keyboardType: inputtype,
      ),
    );
  }
}

