import 'package:college_event_management/createProfile//components/body.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class createProfile extends StatefulWidget {
  final String? role;
  const createProfile({Key? key, required this.role}) : super(key: key);

  @override
  State<createProfile> createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {


  @override
  Widget build(BuildContext context) {
    return body(role: widget.role);

  }


}
