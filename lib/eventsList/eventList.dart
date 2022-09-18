import 'package:college_event_management/hms/event.dart';
import 'package:flutter/material.dart';
import 'package:college_event_management/eventsList/components/body.dart';

class eventList extends StatelessWidget {
  final List<EventData> eventListData;
  final String categoryName, logo;
  const eventList({Key? key, required this.eventListData, required this.categoryName, required this.logo,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(eventListData: eventListData, categoryName: categoryName, logo: logo);
  }
}
