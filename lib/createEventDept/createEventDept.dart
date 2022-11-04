import 'package:flutter/cupertino.dart';
import 'package:college_event_management/createEventDept/components/body.dart';

class createEventDept extends StatefulWidget {
  const createEventDept({Key? key}) : super(key: key);

  @override
  State<createEventDept> createState() => _createEventDeptState();
}

class _createEventDeptState extends State<createEventDept> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return body();
  }
}