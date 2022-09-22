import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../size_config.dart';

class PaymentStatusScreen extends StatefulWidget {
  const PaymentStatusScreen({Key? key}) : super(key: key);

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  bool _isobscure = true;
  bool isLoading = false;
  bool _ischecked = false;
  final activeColor = Color(0xFF0F151E);
  final inactiveColor = Color(0xFF1D2A3A);
  var resendOTPBtnColor;
  bool isPaymentDone = false;

  var isTimerActive = true;
  late final snackBar;
  var uid;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  int count = 10;
  Timer? timer;
  Timer? callbackTimer;

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
            timer.cancel();
          }
        });
      },
    );

    callbackTimer = Timer.periodic(
      Duration(seconds: 15),
      (Timer t) => checkPaymentStatus(),
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
                    'Payment Status',
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2A3A)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    color: Color(0xFF1D2A3A),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Payment processing your payment.\nPlease wait for $count seconds.",
                  ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Color(0xFF1D2A3A),
                  //   ),
                  //   height: 150,
                  //   width: 150,
                  //   child: Center(
                  //     child: Text(
                  //       "$count seconds",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // )
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
    callbackTimer?.cancel();
  }

  checkPaymentStatus() async {
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
