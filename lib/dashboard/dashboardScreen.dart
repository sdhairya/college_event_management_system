import 'package:college_event_management/addFaculty/addFaculty.dart';
import 'package:college_event_management/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/body.dart';
import '../createEvent/createEvent.dart';
import 'package:college_event_management/dashboard/components/dashboard_components.dart';

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({Key? key}) : super(key: key);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return body();

  }


}
