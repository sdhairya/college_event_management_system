import 'package:flutter/material.dart';

import 'package:college_event_management/coordinators/components/body.dart';

class coordinators extends StatelessWidget {

  final List l;
  const coordinators({Key? key, required this.l}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(l: l);
  }
}
