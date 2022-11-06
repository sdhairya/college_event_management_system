import 'dart:core';

class FacultyData {
  String name = "";
  String emailId = "";
  String mobileNo = "";

  FacultyData(
      {required this.name, required this.emailId, required this.mobileNo});

  @override
  String toString() {
    return "$name\n$mobileNo\n$emailId";
  }
}

class CampaignerData{
  String campaigner_id="";
  String name="";
  String email="";
  String campaigner_token="";

  CampaignerData(
      {required this.campaigner_id, required this.name, required this.email, required this.campaigner_token}
      );
  @override
  String toString(){
    return "$campaigner_id\n$name\n$email\n$campaigner_token";
  }
}

class ProfileData{
  String? firstName="";
  String? lastName="";
  String? email="";
  String? er_no="";
  String? mobile="";
  String? branch="";
  String? sem="";
  String? college="";
  String? address="";

  ProfileData(
      {required this.firstName, required this.lastName, required this.email, required this.er_no, required this.mobile, required this.branch, required this.sem, required this.college, required this.address}
      );
  @override
  String toString(){
    return "$firstName\n$lastName\n$email\n$er_no\n$mobile\n$branch\n$sem\n$college\n$address";
  }
}

class StudentData {
  String name = "";
  String emailId = "";
  String mobileNo = "";
  String branchSem = "";
  String enrollmentNo = "";

  StudentData(
      {required this.name,
      required this.emailId,
      required this.mobileNo,
      required this.branchSem,
      required this.enrollmentNo});

  @override
  String toString() {
    return "$name\n$mobileNo\n$emailId\n$branchSem\n$enrollmentNo";
  }
}

class EventData {
  String name = "";
  String type = "";
  String date = "";
  String time = "";
  List<String> categoryTime = [];
  String venue = "";
  String logo = "";
  String description = "";
  List<String> rules = [];
  List<String> evaluation = [];
  List<FacultyData> facultyCoordinator = [];
  List<StudentData> studentCoordinator = [];

  String getCategoryTime() {
    return categoryTime.join('-');
  }

  String getAllRules() {
    return rules.join("\n");
  }

  String getAllEvaluationCriteria() {
    return evaluation.join("\n");
  }

  EventData({
    required this.name,
    required this.type,
    required this.date,
    required this.time,
    required this.venue,
    required this.logo,
    required this.description,
  });

  @override
  String toString() {
    return "$name\n$type\n$date\n$time\n${categoryTime.toString()}\n$venue\n$logo\n$description\n${rules.toString()}\n${evaluation.toString()}\n${facultyCoordinator.toString()}\n${studentCoordinator.toString()}";
  }
}

class EventDeptData {
  String name = "";
  String logo = "";
  String poster = "";
  List<EventData> eventList = [];

  EventDeptData({
    required this.name,
    required this.logo,
    required this.poster,
  });

  @override
  String toString() {
    return "$name\n$logo\n$poster\n${eventList.toString()}";
  }

  factory EventDeptData.fromJson(List<dynamic> json){
    print(json.length);
    return EventDeptData(name: "name", logo: "logo", poster: "poster");
    // return EventDeptData(name: json['name'], logo: json['logo'], poster: json['poster']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['poster'] = this.logo;
    data['eventList'] = this.eventList;

    return data;
  }

}
