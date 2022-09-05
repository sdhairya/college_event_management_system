import 'package:flutter/material.dart';
import 'package:college_event_management/profileDetails/components/body.dart';

class profileDetails extends StatelessWidget {
  final String name;
  const profileDetails({Key? key, required this.name}) : super(key: key);

//   @override
//   State<profileDetails> createState() => _profileDetailsState();
// }
//
// class _profileDetailsState extends State<profileDetails> {
  @override
  Widget build(BuildContext context) {
    return body(name: name);
  }
}
