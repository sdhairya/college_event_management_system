import 'package:college_event_management/hms/event.dart';
import 'package:flutter/material.dart';

import 'package:college_event_management/coordinators/components/body.dart';

class coordinators extends StatelessWidget {

  final List l;
  final EventData previousScreen_data;
  const coordinators({Key? key, required this.l, required this.previousScreen_data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(l: l, previousScreen_data: previousScreen_data,);
  }
}
