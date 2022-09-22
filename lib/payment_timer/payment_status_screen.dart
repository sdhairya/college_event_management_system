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
  var stuid;
  bool isPaymentDone = false;

  var isTimerActive = true;
  late final snackBar;
  var uid;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  int count = 300;
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

  Future checkPaymentStatus() async {
    SharedPreferences studata = await SharedPreferences.getInstance();

    stuid = studata.getString("stuid");
    print(stuid);
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/checkPayment.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({"id": stuid}),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      var temp = res.statusCode;
      print("paymentCode  $temp");
      var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404 || response["sid"] == "") {

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
        print(response["sid"]);


          print("Navigating to dashboard");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const dashboardScreen()));
          // setState(() => isLoading = false);

      }
    } catch (e) {
      print(e.toString());
    }
  }
}
