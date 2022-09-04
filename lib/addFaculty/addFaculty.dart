import 'dart:async';




import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../addFaculty/components/body.dart';


import 'package:flutter/src/widgets/framework.dart';



class addFaculty extends StatefulWidget {
  const addFaculty({Key? key}) : super(key: key);

  @override
  State<addFaculty> createState() => _addFacultyState();
}


class _addFacultyState extends State<addFaculty> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return body();
  }


}


