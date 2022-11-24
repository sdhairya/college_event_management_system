import 'dart:convert';

import 'package:college_event_management/createEventDept/createEventDept.dart';
import 'package:college_event_management/myEvents/myEvents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'event.dart';
import 'package:http/http.dart' as http;

class EventParser {
  List<String> getCategoryList(records) {
    List<String> listEvent = [];
    if (records == null) return [];
    records.forEach((e) => listEvent.add(e['category']));
    return listEvent;
  }

  List<FacultyData> getFacultyList(records) {
    List<FacultyData> listEvent = [];
    if (records == null) return [];
    records.forEach((e) => listEvent.add(FacultyData(
        name: e['name'], emailId: e['mail_id'], mobileNo: e['mobile_no'])));
    return listEvent;
  }

  List<StudentData> getStudentsList(records) {
    List<StudentData> listEvent = [];
    if (records == null) return [];
    records.forEach((e) => listEvent.add(StudentData(
        name: e['name'],
        emailId: e['mail_id'],
        mobileNo: e['mobile_no'],
        branchSem: e['branch_sem'],
        enrollmentNo: e['enrollment_no'])));
    return listEvent;
  }

  List<String> getRulesList(records) {
    List<String> listEvent = [];
    if (records == null) return [];
    records.forEach((e) => listEvent.add(e['rule']));
    return listEvent;
  }

  List<String> getEvaluationCriteriaList(records) {
    List<String> listEvent = [];
    if (records == null) return [];
    records.forEach((e) => listEvent.add(e['rule']));
    return listEvent;
  }

  EventData getEventData(Map<String, dynamic> record) {
    EventData object = EventData(
      name: record['name'],
      type: record['type'],
      date: record['date'],
      time: record['time'],
      logo: record['logo_image'],
      description: record['description'],
      venue: record['venue_of_event'],
    );
    object.categoryTime = getCategoryList(record['category']);
    object.facultyCoordinator = getFacultyList(record['faculty_coordinator']);
    object.studentCoordinator = getStudentsList(record['student_coordinator']);
    object.rules = getRulesList(record['rules']);
    object.evaluation = getRulesList(record['evaluation_criteria']);
    return object;
  }

  List<EventData> getEventDataList(records) {
    List<EventData> listEvent = [];
    if (records == null) return [];
    // debugPrint("getEventDataList::Length of records ${(records as List).length.toString()}\n Records are ${records}");
    for (var e in records) {
      listEvent.add(getEventData(e));
    }
    return listEvent;
  }

  EventDeptData getDeptEventData(Map<String, dynamic> record) {
    EventDeptData object = EventDeptData(
        name: record['name'], logo: record['logo'], poster: record['poster']);
    object.eventList = getEventDataList(record['events']);
    //debugPrint("getDeptEventData:: Object $object");
    return object;
  }

  Future<List<EventDeptData>> getDeptEventList() async {
    final String response =
        await rootBundle.loadString('assets/json/event_data.json');
    //debugPrint("Event Parser::Response:: $response");
    final dataList = await json.decode(response);
    List<EventDeptData> listEvent = [];
    dataList.forEach((e) => listEvent.add(getDeptEventData(e)));
    //debugPrint("Event Parser::Response:: ${listEvent.toString()}");
    return listEvent;
  }

  CampaignerData getCampaignerData(Map<String, dynamic> record) {
    CampaignerData object = CampaignerData(
        campaigner_id: record['campaigner_id'],
        name: record['name'],
        email: record['email'],
        campaigner_token: record['campaigner_token']);
    return object;
  }

  Future<List<CampaignerData>> getCampaignerDataList() async {
    final url =
        Uri.parse("https://convergence.uvpce.ac.in/C2K22/addCampaigner.php");
    final response = await http.get(url);

    final responseData = await json.decode(response.body);
    List<CampaignerData> listCampaigner = [];
    responseData.forEach((e) => listCampaigner.add(getCampaignerData(e)));
    print(listCampaigner);
    return listCampaigner;
  }

  VisitedCollege getCollegeData(Map<String, dynamic> record) {
    VisitedCollege object = VisitedCollege(college: record['college']);
    return object;
  }

  Future getVisitedCollegeList() async {
    try {
      SharedPreferences camp = await SharedPreferences.getInstance();
      var campaignerToken = camp.getString("campaignerToken");
      var url = Uri.parse(
          "https://convergence.uvpce.ac.in/C2K22/CampaignerDashboard/visitedColleges.php?campaignerToken=$campaignerToken");
      var response = await http.get(url);
      final visitedColleges = json.decode(response.body);
      List<VisitedCollege> listCollege = [];
      visitedColleges.forEach((e) => listCollege.add(getCollegeData(e)));
      return listCollege;
      print(visitedColleges);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  ParticipantData getParticipantsData(Map<String, dynamic> record) {
    ParticipantData object = ParticipantData(
        firstName: record['firstName'],
        lastName: record['lastName'],
        email: record['email'],
        er_no: record['er_no'],
        branch: record['branch'],
        college: record['college']);
    return object;
  }

  Future getTotalParticipantsList() async {
    try {
      SharedPreferences camp = await SharedPreferences.getInstance();
      var campaignerToken = camp.getString("campaignerToken");
      var url = Uri.parse(
          "https://convergence.uvpce.ac.in/C2K22/totalParticipants.php?campaignerToken=$campaignerToken");
      var response = await http.get(url);
      final totalParticipants = json.decode(response.body);
      List<ParticipantData> listParticipant = [];
      totalParticipants
          .forEach((e) => listParticipant.add(getParticipantsData(e)));

      print(totalParticipants);
      return listParticipant;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future getMyParticipants() async {
    try {
      SharedPreferences camp = await SharedPreferences.getInstance();
      var campaignerToken = camp.getString("campaignerToken");
      String uri =
          "https://convergence.uvpce.ac.in/C2K22/CampaignerDashboard/campaignerPaticipants.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({"campaignerToken": campaignerToken}),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 200) {
        final myParticipants = json.decode(res.body);

        print("getMyParticipants function work!!");
        print(myParticipants);
        List<ParticipantData> listMyParticipant = [];
        myParticipants
            .forEach((e) => listMyParticipant.add(getParticipantsData(e)));

        return listMyParticipant;
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List<ProfileData>> getProfileData() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    var stuid = studata.getString("stuid");

    final url = Uri.parse(
        "https://convergence.uvpce.ac.in/C2K22/studentProfile.php?id=$stuid");
    final response = await http.get(url);
    final responseData = json.decode(response.body);

    List<ProfileData> listProfile = [];
    listProfile.add(ProfileData(
        firstName: responseData['firstName'],
        lastName: responseData['lastName'],
        email: responseData['email'],
        er_no: responseData['er_no'],
        mobile: responseData['mobile'],
        branch: responseData['branch'],
        sem: responseData['sem'],
        college: responseData['college'],
        address: responseData['address'],
        campToken: responseData['campaigner_token']));

    return listProfile;
    print(responseData);
  }

  Future<List<ProfileData>> myEvents() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    var stuid = studata.getString("stuid");

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/myEvents.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({"sid": stuid.toString()}),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 200) {
        final myParticipants = json.decode(res.body);

        print("getMyParticipants function work!!");
        print(myParticipants);
        List<ParticipantData> listMyParticipant = [];
        myParticipants
            .forEach((e) => listMyParticipant.add(getParticipantsData(e)));

        return listMyParticipant;
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
