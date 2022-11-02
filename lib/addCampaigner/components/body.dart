import 'dart:convert';
import 'dart:math';

import 'package:college_event_management/addCampaigner/components/addCampaigner_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../../size_config.dart';
import 'package:http/http.dart' as http;

TextEditingController _coordiantorNameController = TextEditingController();
TextEditingController _coordiantorEmailController = TextEditingController();
TextEditingController _coordiantorPhoneController = TextEditingController();
TextEditingController _coordiantorEnrollmentController =
TextEditingController();

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  TextEditingController _addCampaignernameController = TextEditingController();
  TextEditingController _addCampaigneremailController = TextEditingController();
  bool isLoading = false;
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
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
                      left: 20, top: MediaQuery.of(context).size.height * 0.12),
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
                      addCampaigner_components().text("Add Campaigner",
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
                      top: MediaQuery.of(context).size.height * 0.06),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const addCampaigner_components().text(
                          '   Name', FontWeight.normal, Color(0xFF1D2A3A), 16),
                      const SizedBox(
                        height: 10,
                      ),
                      const addCampaigner_components().textField(
                          "Enter Your Name",
                          TextInputType.text,
                          _addCampaignernameController),
                      const SizedBox(
                        height: 30,
                      ),
                      const addCampaigner_components().text(
                          '   Email', FontWeight.normal, Color(0xFF1D2A3A), 16),
                      const SizedBox(
                        height: 10,
                      ),
                      const addCampaigner_components().textField(
                          "Enter Email",
                          TextInputType.emailAddress,
                          _addCampaigneremailController),
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
                              child: const Text('Add Campaigner'),
                              onPressed: () async {
                                if (isLoading) return;
                                setState(() => isLoading = true);

                                if (_addCampaigneremailController.text.isNotEmpty &&
                                    _addCampaignernameController.text.isNotEmpty) {
                                  addCampaignerStudent();
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
                        bottom: MediaQuery.of(context).viewInsets.bottom)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future addCampaignerStudent() async {
    var userId = uuid.v4();

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/addCampaigner.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "id": userId,
            "email": _addCampaigneremailController.text,
            "userName": _addCampaignernameController.text,
            "role": "campaigner",
            "password": "Convergence@uvpce"
          }),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("User Not Found Check the Email address!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
        setState(() => isLoading = false);
      } else if (res.statusCode == 442) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("Bed Request!!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
        setState(() => isLoading = false);
      } else if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Campaigner Added Successfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("campaigner added Successfully!!");
        setState(() => isLoading = false);

        _addCampaigneremailController.text = "";
        _addCampaignernameController.text = "";

        // print(response);
      } else {
        print("some issue");
        setState(() => isLoading = false);
      }
    } catch (e) {
      // print(e.toString());
    }
  }
}


