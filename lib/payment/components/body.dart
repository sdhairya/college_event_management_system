import 'dart:convert';

import 'package:college_event_management/createProfile/createProfile.dart';
import 'package:college_event_management/payment/components/payment_components.dart';
import 'package:college_event_management/timerScreen/timer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../dashboard/dashboardScreen.dart';
import '../payment.dart';

enum SingingCharacter { Yes, No }

int amt = 0;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  // void initState() {
  //   super.initState();
  //   getGstAmt();
  // }

  bool isLoading = false;
  bool isChecked = false;
  int certificate = 0;
  int lunch = 0;
  int islunch = 0;
  var stuid;
  var type;

  SingingCharacter? _certificate = null;
  SingingCharacter? _lunch = null;

  @override
  Widget build(BuildContext context) {
    getGstAmt();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500
                ? EdgeInsets.zero
                : const EdgeInsets.all(30.0),
            child: Center(
                child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment(0, 0),
                      ),
                      Container(
                        child: ListTile(
                          leading: IconButton(
                              padding: EdgeInsets.only(bottom: 3, right: 8),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Convergence2K22'),
                                          content: Text(
                                              "You can not go futher untill you done your payment!!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Ok'))
                                          ],
                                        ));
                                //   Navigator.of(context).pushReplacement(
                                //       MaterialPageRoute(
                                //           builder: (context) => createProfile()));
                              },
                              icon: Icon(
                                color: Color(0xFF1D2A3A),
                                Icons.arrow_back_ios_new_rounded,
                                size: 30,
                              )),
                          title: const Text(
                            'Payment ',
                            style: TextStyle(
                                fontSize: 35,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1D2A3A)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            payment_components().text(
                                'Do you want to have hardcopy of certificate ?',
                                FontWeight.w600,
                                Color(0xFF1D2A3A),
                                16),
                            // const Text('   User Name',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Color(0xFF1D2A3A))),
                            const SizedBox(
                              height: 10,
                            ),

                            Column(
                              children: [
                                RadioListTile(
                                    title: Text("Yes"),
                                    value: SingingCharacter.Yes,
                                    groupValue: _certificate,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _certificate = value;
                                        certificate = 1;
                                        // print(_certificate);
                                        // amount(certificate, lunch);
                                      });
                                    }),
                                RadioListTile(
                                    title: Text("No"),
                                    value: SingingCharacter.No,
                                    groupValue: _certificate,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _certificate = value;
                                        certificate = 0;
                                        // print(_certificate);
                                        // amount(certificate, lunch);
                                      });
                                    }),
                              ],
                            ),

                            payment_components().text(
                                'Do you want to include lunch ?',
                                FontWeight.w600,
                                Color(0xFF1D2A3A),
                                16),

                            const SizedBox(
                              height: 10,
                            ),

                            Column(
                              children: [
                                RadioListTile(
                                    title: Text("Yes"),
                                    value: SingingCharacter.Yes,
                                    groupValue: _lunch,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _lunch = value;
                                        islunch = 1;
                                        lunch = 150;
                                        // print(_lunch);
                                        amount(certificate, lunch);
                                      });
                                    }),
                                RadioListTile(
                                    title: Text("No"),
                                    value: SingingCharacter.No,
                                    groupValue: _lunch,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _lunch = value;
                                        islunch = 0;
                                        lunch = 0;
                                        // print(_lunch);
                                        amount(certificate, lunch);
                                      });
                                    }),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            Text(
                              "Amount : $amt",
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            Container(
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
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        backgroundColor: Colors.transparent,
                                      )
                                    : const Text('Make Payment'),
                                onPressed: () {
                                  if (_lunch == null || _certificate == null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  "All fields are required!!"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            ));
                                  } else {
                                    updateCpoy();

                                    // Navigator.of(context).pushReplacement(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => timer()));
                                    //makePayment();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  )
                ],
              ),
            )),
          );
        }),
      ),
    );
  }

  Future getGstAmt() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    stuid = studata.getString("stuid");

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/countGst.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({"id": stuid}),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      // print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content: Text("User Not Found!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
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
                        child: Text('Ok'))
                  ],
                ));
        setState(() => isLoading = false);
      } else if (res.statusCode == 200) {
        var response = json.decode(res.body);
        type = response["studentType"];
        // print(type);
        // print(response);
      } else {
        // print("some issue");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future amount(int certificate, int lunch) async {
    int fixed = 100;
    setState(() {
      amt = fixed + lunch;
    });

    if (type == "nongnu") {
      if (lunch == 0) {
        amt = 118;
      } else if (lunch == 150) {
        amt = 295;
      } else {
        print("Somthing Worng");
      }
    } else {
      print("Student Type Was Not Found!!");
    }
    // if (type == "gnu") {
    //
    // } else if (type == "nongnu") {
    //   setState(() {
    //     amt = fixed + lunch;
    //     amt = (amt + (amt * 0.18)) as int;
    //   });
    // } else {
    //   print("some issue");
    //   setState(() => isLoading = false);
    // }
  }

  Future updateCpoy() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    stuid = studata.getString("stuid");
    var _lunchState;
    var _certificateType;
    // print(stuid);
    if (_lunch == SingingCharacter.Yes) {
      _lunchState = "Yes";
      // print(_lunchState);
    } else if (_lunch == SingingCharacter.No) {
      _lunchState = "No";
      // print(_lunchState);
    } else {
      print("Something Wrong");
    }

    if (_certificate == SingingCharacter.Yes) {
      _certificateType = 1;
      // print(_certificateType);
    } else if (_certificate == SingingCharacter.No) {
      _certificateType = 0;
      // print(_certificateType);
    } else {
      print("Something Wrong");
    }

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/lunchAndcopy.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "sid": stuid,
            "certificateType": _certificateType,
            "lunch": _lunchState
          }),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      // print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content: Text("User Not Found !!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
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
                        child: Text('Ok'))
                  ],
                ));
        setState(() => isLoading = false);
      } else if (res.statusCode == 200) {
        makePayment();
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  Future makePayment() async {
    try {
      String uri =
          "https://convergence.uvpce.ac.in/C2K22/payment.php?sid=$stuid&isLunchIncluded=$islunch";

      final Uri url = Uri.parse(uri);

      if (await canLaunchUrl(url))
        await launchUrl(url);
      else
        // can't launch url, there is some error
        throw "Could not launch $url";
    } catch (e) {
      // print(e.toString());
    }
  }
}
