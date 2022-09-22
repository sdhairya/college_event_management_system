import 'dart:async';
import 'dart:convert';

import 'package:college_event_management/login/components/login_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../forgotPassword.dart';
import '../../size_config.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  bool _isobscure = true;
  bool isLoading = false;
  bool _ischecked = false;
  final activeColor = Color(0xFF0F151E);
  final inactiveColor = Color(0xFF1D2A3A);
  var resendOTPBtnColor;

  var isTimerActive = true;
  late final snackBar;
  var uid;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  int count = 120;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    resendOTPBtnColor = inactiveColor;
    snackBar = SnackBar(
      content: Text(
        'Please try again later.',
        style: TextStyle(
          color: activeColor,
        ),
      ),
      backgroundColor: (Colors.black12),
    );
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          count--;

          if (count == 0) {
            isTimerActive = false;
            resendOTPBtnColor = activeColor;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child:
            //Login Text Container
            LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500
                ? EdgeInsets.zero
                : const EdgeInsets.all(30.0),
            child: Center(
                child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 25.0,
              ),
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Verify OTP',
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2A3A)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'OTP\n',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1D2A3A),
                        ),
                      ),
                      login_components().textField("Enter OTP",
                          TextInputType.emailAddress, _emailController),
                      Align(
                        alignment: Alignment(1, 0),
                        child: TextButton(
                          onPressed: () {
                            if (isTimerActive) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              // Call here function to resend the OTP
                            }
                          },
                          child: Text(
                            isTimerActive
                                ? 'Resend OTP in $count'
                                : 'Resend OTP',
                            style: TextStyle(
                              fontSize: 15,
                              color:
                                  isTimerActive ? inactiveColor : activeColor,
                              fontWeight: isTimerActive
                                  ? FontWeight.w400
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF1D2A3A),
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
                              : const Text('Verify OTP'),
                          onPressed: () async {
                            if (isLoading) return;

                            setState(() => isLoading = true);

                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              userLogin();
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Error'),
                                        content:
                                            Text("All fields are required!!"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Ok'))
                                        ],
                                      ));
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
          );
        }))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future userLogin() async {
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/auth/login.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "email": _emailController.text,
            "password": _passwordController.text
          }),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);

      if (res.statusCode == 404) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("User Not Found Check your Email Or Password!"),
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
        var response = json.decode(res.body);
        uid = response["id"];
        print(uid);
        // print(response);

        if (uid != "") {
          SharedPreferences studata = await SharedPreferences.getInstance();

          studata.setString("stuid", uid);
          studata.setString("stuName", response["username"]);

          // checkProfile(uid);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => dashboardScreen()));
          Fluttertoast.showToast(
            msg: "Success!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // setState(() => isLoading = false);

        } else {
          print("some issue");
          setState(() => isLoading = false);
        }
      } else {
        print("some issue");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
