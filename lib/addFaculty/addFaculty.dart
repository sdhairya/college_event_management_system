import 'package:college_event_management/dashboardScreen.dart';
import 'package:college_event_management/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../addFaculty/components/body.dart';

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
