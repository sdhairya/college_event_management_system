import 'dart:convert';
/// sid : "695c01ca-01de-4fab-a2fe-dd1204a1097f"

MyEventsReqBody myEventsReqBodyFromJson(String str) => MyEventsReqBody.fromJson(json.decode(str));
String myEventsReqBodyToJson(MyEventsReqBody data) => json.encode(data.toJson());
class MyEventsReqBody {
  MyEventsReqBody({
      String? sid,}){
    _sid = sid;
}

  MyEventsReqBody.fromJson(dynamic json) {
    _sid = json['sid'];
  }
  String? _sid;
MyEventsReqBody copyWith({  String? sid,
}) => MyEventsReqBody(  sid: sid ?? _sid,
);
  String? get sid => _sid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sid'] = _sid;
    return map;
  }

}