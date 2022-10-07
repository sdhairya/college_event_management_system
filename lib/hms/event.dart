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
}
