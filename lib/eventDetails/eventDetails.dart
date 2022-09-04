import 'package:college_event_management/eventDetails/components/body.dart';
import 'package:flutter/material.dart';

class eventDetails extends StatefulWidget {
  const eventDetails({Key? key}) : super(key: key);

  @override
  State<eventDetails> createState() => _eventDetailsState();
}

class _eventDetailsState extends State<eventDetails> {
  @override
  Widget build(BuildContext context) {
    return body();
  }
}
