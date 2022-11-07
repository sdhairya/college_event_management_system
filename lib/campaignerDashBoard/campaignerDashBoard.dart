import 'package:flutter/material.dart';
import 'package:college_event_management/campaignerDashBoard/components/body.dart';

class campaignerDashBoard extends StatefulWidget {
  const campaignerDashBoard({Key? key}) : super(key: key);

  @override
  State<campaignerDashBoard> createState() => _campaignerDashBoardState();
}

class _campaignerDashBoardState extends State<campaignerDashBoard> {
  @override
  Widget build(BuildContext context) {
    return body();
  }
}
