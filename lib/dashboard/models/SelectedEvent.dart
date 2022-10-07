import 'dart:convert';
/// eventName : "One Day Workshop on Basics of 3D Printing"
/// departmentName : "MechMechato"

SelectedEvent selectedEventFromJson(String str) => SelectedEvent.fromJson(json.decode(str));
String selectedEventToJson(SelectedEvent data) => json.encode(data.toJson());
class SelectedEvent {
  SelectedEvent({
      String? eventName, 
      String? departmentName,}){
    _eventName = eventName;
    _departmentName = departmentName;
}

  SelectedEvent.fromJson(dynamic json) {
    _eventName = json['eventName'];
    _departmentName = json['departmentName'];
  }
  String? _eventName;
  String? _departmentName;
SelectedEvent copyWith({  String? eventName,
  String? departmentName,
}) => SelectedEvent(  eventName: eventName ?? _eventName,
  departmentName: departmentName ?? _departmentName,
);
  String? get eventName => _eventName;
  String? get departmentName => _departmentName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventName'] = _eventName;
    map['departmentName'] = _departmentName;
    return map;
  }

}