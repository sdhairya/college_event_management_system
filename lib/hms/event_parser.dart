import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'event.dart';

class EventParser{
  List<String> getCategoryList(records){
    List<String> listEvent = [];
    if(records == null) return [];
    records.forEach((e)=>listEvent.add(e['category']));
    return listEvent;
  }
  List<FacultyData> getFacultyList(records){
    List<FacultyData> listEvent = [];
    if(records == null) return [];
    records.forEach((e)=>listEvent.add(FacultyData(name: e['name'], emailId: e['mail_id'], mobileNo: e['mobile_no'])));
    return listEvent;
  }
  List<StudentData> getStudentsList(records) {
    List<StudentData> listEvent = [];
    if(records == null) return [];
    records.forEach((e) =>
        listEvent.add(StudentData(
            name: e['name'],
            emailId: e['mail_id'],
            mobileNo: e['mobile_no'],
            branchSem: e['branch_sem'],
            enrollmentNo: e['enrollment_no'])));
    return listEvent;
  }
  List<String> getRulesList(records){
    List<String> listEvent = [];
    if(records == null) return [];
    records.forEach((e)=>listEvent.add(e['rule']));
    return listEvent;
  }
  List<String> getEvaluationCriteriaList(records){
    List<String> listEvent = [];
    if(records == null) return [];
    records.forEach((e)=>listEvent.add(e['rule']));
    return listEvent;
  }
  EventData getEventData(Map<String, dynamic> record) {
    EventData object = EventData(name: record['name'],
      type: record['type'],
      date: record['date'],
      time: record['time'],
      logo: record['logo_image'],
      description: record['description'],
      venue: record['venue_of_event'],);
    object.categoryTime = getCategoryList(record['category']);
    object.facultyCoordinator = getFacultyList(record['faculty_coordinator']);
    object.studentCoordinator = getStudentsList(record['student_coordinator']);
    object.rules = getRulesList(record['rules']);
    object.evaluation = getRulesList(record['evaluation_criteria']);
    return object;
  }
  List<EventData> getEventDataList(records){
    List<EventData> listEvent = [];
    if(records == null) return [];
    debugPrint("getEventDataList::Length of records ${(records as List).length.toString()}\n Records are ${records}");
    for (var e in records) {
      listEvent.add(getEventData(e));
    }
    return listEvent;
  }
  EventDeptData getDeptEventData(Map<String, dynamic> record){
    EventDeptData object = EventDeptData(name: record['name'],logo: record['logo'],poster: record['poster']);
    object.eventList = getEventDataList(record['events']);
    //debugPrint("getDeptEventData:: Object $object");
    return object;
  }
  Future<List<EventDeptData>> getDeptEventList() async{
    final String response = await rootBundle.loadString('assets/json/event_data.json');
    //debugPrint("Event Parser::Response:: $response");
    final dataList = await json.decode(response);
    List<EventDeptData> listEvent = [];
    dataList.forEach((e)=>listEvent.add(getDeptEventData(e)));
    //debugPrint("Event Parser::Response:: ${listEvent.toString()}");
    return listEvent;
  }
}