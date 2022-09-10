import 'package:flutter/material.dart';
import 'package:college_event_management/attendees/components/body.dart';

class attendees extends StatefulWidget {
  final List previousScreen_data;
  const attendees({Key? key, required this.previousScreen_data}) : super(key: key);

  @override
  State<attendees> createState() => _attendeesState();
}

class _attendeesState extends State<attendees> {
  @override
  Widget build(BuildContext context) {
    return body(previousScreen_data: widget.previousScreen_data,);
  }
}
