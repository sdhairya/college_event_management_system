import 'package:college_event_management/dashboard/dashboardScreen.dart';
import 'package:college_event_management/createEvent/components/body.dart';
import 'package:college_event_management/size_config.dart';
import 'package:college_event_management/textfield_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class createEvent extends StatefulWidget {
  const createEvent({Key? key}) : super(key: key);

  @override
  State<createEvent> createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return body();
  }
}
