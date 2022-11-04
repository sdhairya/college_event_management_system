import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../hms/event.dart';
import '../../hms/event_parser.dart';
import '../../main.dart';
import '../../size_config.dart';
import 'createEventDept_components.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  TextEditingController _eventDeptnameController = TextEditingController();
  bool isLoading = false;
  var uuid = Uuid();
  List<EventDeptData> eventlist = [];

  @override
  void initState() {
    eventlist.clear();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(duration: Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500
                ? EdgeInsets.zero
                : const EdgeInsets.all(30),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600,
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment(0, 0),
                        ),
                        Container(
                          height: getHeight(50),
                          width: getWidth(kIsWeb ? 100 : double.infinity),
                          margin: EdgeInsets.only(
                              left: 20, top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.12),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  padding: EdgeInsets.only(bottom: 3, right: 8),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 30,
                                  )),
                              createEventDept_components().text(
                                  "Create Department",
                                  FontWeight.w600, Color(0xFF1D2A3A), 35),
                              // Text(
                              //   'Add Coordinator ',
                              //   style: TextStyle(
                              //       fontSize: 35,
                              //       fontStyle: FontStyle.normal,
                              //       fontWeight: FontWeight.w600,
                              //       color: Color(0xFF1D2A3A)),
                              // )
                            ],
                          ),
                        ),
                        Container(
                          // height: getHeight(555),
                          width: getWidth(kIsWeb ? 100 : double.infinity),
                          // width: kIsWeb ? 600 : double.infinity,
                          // constraints: BoxConstraints(maxWidth: 1000),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.06),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const createEventDept_components().text(
                                  '   Name', FontWeight.normal,
                                  Color(0xFF1D2A3A), 16),
                              const SizedBox(
                                height: 10,
                              ),
                              const createEventDept_components().textField(
                                  "Enter Department Name",
                                  TextInputType.text,
                                  _eventDeptnameController),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF1D2A3A),
                                        onSurface: Color(0xFF1D2A3A),
                                        padding: EdgeInsets.all(3),
                                        textStyle: TextStyle(fontSize: 20),
                                        minimumSize: Size.fromHeight(50),
                                        shape: StadiumBorder(),
                                        enableFeedback: true,
                                      ),
                                      child: const Text('Create Department'),
                                      onPressed: () async {
                                        if (isLoading) return;
                                        setState(() => isLoading = true);

                                        if (_eventDeptnameController.text
                                            .isNotEmpty) {
                                          // EventParser().createEventDepart(_eventDeptnameController.text, "", "");
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Any field can not be empty!!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          setState(() => isLoading = false);
                                        }
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery
                                    .of(context)
                                    .viewInsets
                                    .bottom)),
                      ],
                    )
                  ],
                ),
              ),
            ),);
        },)
        ,
      ),
    );
  }

  void addEventDept() async {
    print("addEventDept");
    File file = File("assets/json/event_data.json");
    EventDeptData newEventDept = EventDeptData(name: _eventDeptnameController.text, logo: "", poster: "");
    eventlist.add(newEventDept);
    eventlist.map((event) => event.toJson());
    file.writeAsString(json.encode(eventlist));
    print("addEventDept");

  }

}