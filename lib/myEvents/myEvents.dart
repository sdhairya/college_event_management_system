import 'package:flutter/material.dart';

import '';
import '../myEvents/components/body.dart';

class myEvents extends StatefulWidget {
  const myEvents({Key? key}) : super(key: key);

  @override
  State<myEvents> createState() => _myEventsState();
}

class _myEventsState extends State<myEvents> {
  @override
  Widget build(BuildContext context) {
    return body();
  }
}
