import 'dart:convert';

import 'package:college_event_management/createEventDept/createEventDept.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'event.dart';
import 'package:http/http.dart' as http;


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
    // debugPrint("getEventDataList::Length of records ${(records as List).length.toString()}\n Records are ${records}");
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

  CampaignerData getCampaignerData(Map<String, dynamic> record){
    CampaignerData object = CampaignerData(campaigner_id: record['campaigner_id'], name: record['name'], email: record['email'], campaigner_token: record['campaigner_token']);
    return object;
  }

  Future<List<CampaignerData>> getCampaignerDataList() async{
    final url = Uri.parse("https://convergence.uvpce.ac.in/C2K22/addCampaigner.php");
    final response = await http.get(url);

    final responseData = await json.decode(response.body);
    List<CampaignerData> listCampaigner = [];
    responseData.forEach((e)=> listCampaigner.add(getCampaignerData(e)));
    print(listCampaigner);
    return listCampaigner;


  }

  Future<List<ProfileData>> getProfileData(String stuid) async{
    final url = Uri.parse(
        "https://convergence.uvpce.ac.in/C2K22/studentProfile.php?id=$stuid");
    final response = await http.get(url);
    final responseData = json.decode(response.body);

    List<ProfileData> listProfile = [];
    listProfile.add(ProfileData(firstName: responseData['firstName'], lastName: responseData['lastName'], email: responseData['email'], er_no: responseData['er_no'], mobile: responseData['mobile'], branch: responseData['branch'], sem: responseData['sem'], college: responseData['college'], address: responseData['address']));

    return listProfile;
    print(responseData);
  }

  Future<EventDeptData> createEventDepart(String name, String logo, String poster) async{
    final http.Response response = await http.post(Uri.parse('https://convergence.uvpce.ac.in/register/assets/assets/json/event_data.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'logo': logo,
      'poster': poster,
    }),

    );
    if (response.statusCode == 200) {
      print(response);
      return EventDeptData.fromJson(json.decode( "[" + response.body + "]"));
    } else {
      print(response.statusCode);
      throw Exception('Failed to create Event Department.');
    }
  }
}