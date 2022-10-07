import 'dart:convert';

import 'package:college_event_management/registration/components/registration_components.dart';
import 'package:college_event_management/verify_otp/verify_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../size_config.dart';
import '../../terms.dart';
import '../registrtion.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

TextEditingController _signUpEmailController = TextEditingController();
TextEditingController _signUpPasswordController = TextEditingController();
TextEditingController _signUpConfrimPasswordController =
    TextEditingController();
TextEditingController _signUpNameController = TextEditingController();

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool isLoading = false;
  bool isChecked = false;
  bool _isobscure = true;
  bool _isobscure2 = true;

  var uuid = Uuid();
  void _toggle() {
    setState(() {
      _isobscure = !_isobscure;
    });
  }
  void _toggle2() {
    setState(() {
      _isobscure2 = !_isobscure2;
    });
  }
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 25.0),
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
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                icon: Icon(
                                  color: Color(0xFF1D2A3A),
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 30,
                                )),
                            title: const Text(
                              'Register ',
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
                              registration_components().text('   User Name',
                                  FontWeight.w600, Color(0xFF1D2A3A), 16),
                              // const Text('   User Name',
                              //     style: TextStyle(
                              //         fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const registration_components().textField(
                                  "Enter Your Name",
                                  TextInputType.text,
                                  _signUpNameController,
                                  ""),
                              // TextField(
                              //   controller: _signUpNameController,
                              //   decoration: InputDecoration(
                              //     border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(15)),
                              //     hintText: 'Enter Your Name',
                              //   ),
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                              registration_components().text(
                                  '   Registration Email',
                                  FontWeight.w600,
                                  Color(0xFF1D2A3A),
                                  16),

                              const SizedBox(
                                height: 10,
                              ),
                              const registration_components().textField(
                                  "Enter Email",
                                  TextInputType.emailAddress,
                                  _signUpEmailController,
                                  ""),

                              const SizedBox(
                                height: 30,
                              ),
                              registration_components().text('   Password',
                                  FontWeight.w600, Color(0xFF1D2A3A), 16),

                              const SizedBox(
                                height: 10,
                              ),
                              // const registration_components().textField(
                              //     "Enter Password",
                              //     TextInputType.visiblePassword,
                              //     _signUpPasswordController,
                              //     ""),
                          TextFormField(
                            obscureText: _isobscure,
                            controller: _signUpPasswordController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Enter Password',
                                suffixIcon: IconButton(
                                  icon: Icon(_isobscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: _toggle,
                                )),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                              const SizedBox(
                                height: 30,
                              ),


                              registration_components().text(
                                  '   Confirm Password',
                                  FontWeight.w600,
                                  Color(0xFF1D2A3A),
                                  16),

                              const SizedBox(
                                height: 10,
                              ),
                              // const registration_components().textField(
                              //     "Enter Confirm Password",
                              //     TextInputType.text,
                              //     _signUpConfrimPasswordController,
                              //     "confirmpassword"),
                              TextFormField(
                                obscureText: _isobscure2,
                                controller: _signUpConfrimPasswordController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    hintText: 'Enter Confirm Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(_isobscure2
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: _toggle2,
                                    )),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              CheckboxListTile(
                                title: const Text.rich(TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Terms & Conditions",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF1D2A3A),
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline))
                                  ],
                                  text: "I read and agree with",
                                )
                                    // Text("I read and agree with"),
                                    // TextButton(
                                    //     onPressed: () {
                                    //       terms();
                                    //     },
                                    //     child: const Text(
                                    //       "Terms & Conditions",
                                    //       style: TextStyle(
                                    //           fontSize: 15,
                                    //           color: Color(0xFF1D2A3A),
                                    //           fontWeight: FontWeight.bold,
                                    //           decoration: TextDecoration.underline),
                                    //     ))
                                    ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: this.isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    this.isChecked = value!;
                                  });
                                },
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              Container(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: isChecked
                                        ? Color(0xFF1D2A3A)
                                        : Color(0xFFFF7F7F7),
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
                                      : const Text('Register'),
                                  onPressed: isChecked
                                      ? () async {
                                          setState(() => isLoading = true);

                                          // if (isLoading) return;

                                          if (_signUpEmailController
                                              .text.isNotEmpty) {
                                            if (_signUpPasswordController
                                                    .text ==
                                                _signUpConfrimPasswordController
                                                    .text) {
                                              insertUser();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Confirm password don't match!!",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() => isLoading = false);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Any field can not be empty!!",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            setState(() => isLoading = false);
                                          }
                                        }
                                      : null,
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
          })),
    );
  }


  Future insertUser() async {
    var userId = uuid.v4();
    SharedPreferences studata = await SharedPreferences.getInstance();
    studata.setString("stuid", userId);
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/auth/signup.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "id": userId,
            "email": _signUpEmailController.text,
            "userName": _signUpNameController.text,
            "isStudent": 1,
            "password": _signUpPasswordController.text
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
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Success!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("User added Successfully!!");
        // setState(() => isLoading = false);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VerifyOTPScreen()));
      } else {
        print("some issue");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void terms() {
    showDialog(
      context: body().createState().context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            "Terms & Conditions",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF1D2A3A),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: const SingleChildScrollView(
          child: Text("1. Acknowledgment\n"
              "These are the Terms and Conditions governing the use of this Service and the agreement that operates"
              "between You and the Company. These Terms and Conditions set out the rights and obligations of all users"
              "regarding the use of the Service.\n\n"
              "2. User Accounts\n"
              "When You create an account with Us, You must provide Us information that is accurate, complete, and"
              "current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate"
              "termination of Your account on Our Service\n\n"
              "3. Termination\n"
              "We may terminate or suspend Your Account immediately, without prior notice or liability, for any reason"
              "whatsoever, including without limitation if You breach these Terms and Conditions.\n\n"
              "4. Payments\n"
              "Payment can be made through various payment methods we have available, such as Visa, MasterCard,"
              "Affinity Card, American Express cards or online payment methods (PayPal, for example)\n\n"
              "5. Content\n"
              "Our Service allows You to post Content. You are responsible for the Content that You post to the Service,"
              "including its legality, reliability, and appropriateness.\n\n"),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: Navigator.of(context).pop,
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF1D2A3A),
              onSurface: Color(0xFF1D2A3A),
              padding: EdgeInsets.all(1),
              textStyle: TextStyle(fontSize: 20),
              shape: StadiumBorder(),
              enableFeedback: true,
            ),
          )
        ],
      ),
    );
  }
}
