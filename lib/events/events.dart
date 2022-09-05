import 'package:flutter/material.dart';
import 'package:college_event_management/events/components/body.dart';

class events extends StatefulWidget {
  const events({Key? key}) : super(key: key);

  @override
  State<events> createState() => _eventsState();
}

class _eventsState extends State<events> {
  @override
  Widget build(BuildContext context) {
    return body();
  }
}
