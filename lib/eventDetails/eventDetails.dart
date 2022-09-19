import 'package:college_event_management/eventDetails/components/body.dart';
import 'package:flutter/material.dart';

import '../hms/event.dart';

class eventDetails extends StatelessWidget {
  final EventData inputList;
  final String deptName;

  const eventDetails({Key? key, required this.inputList, required this.deptName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(eventDetails: inputList, deptName: deptName,);
  }
}


// class eventDetails extends StatefulWidget {
//   final String l;
//   const eventDetails({Key? key, required this.l}) : super(key: key);
//
//   @override
//   State<eventDetails> createState() => _eventDetailsState();
// }
//
// class _eventDetailsState extends State<eventDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return body(l: l,);
//   }
// }
