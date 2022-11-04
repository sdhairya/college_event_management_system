import 'dart:convert';

import 'package:college_event_management/login/components/login_components.dart';
import 'package:college_event_management/payment/payment.dart';
import 'package:college_event_management/profileDetails/profileDetails.dart';
import 'package:college_event_management/verify_otp/verify_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../createProfile/createProfile.dart';
import '../../dashboard/dashboardScreen.dart';
import '../../forgotPassword.dart';
import '../../homepage/homepage.dart';
import '../../registration/registrtion.dart';
import '../../size_config.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool _isobscure = true;
  bool isLoading = false;
  bool _ischecked = false;
  var uid;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Found For this Email");
      }
    }
    return user;
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  void _toggle() {
    setState(() {
      _isobscure = !_isobscure;
    });
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
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Convergence 2022_cropped_mini.png',
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Login',
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2A3A)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Email\n',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      login_components().textField("Enter Email Address",
                          TextInputType.emailAddress, _emailController),

                      // TextField(
                      //   keyboardType: TextInputType.emailAddress,
                      //   controller: _emailController,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15)),
                      //     hintText: 'Enter Email Address',
                      //   ),
                      // ),
                      SizedBox(
                        height: getPercentHeight(1),
                      ),

                      const Text('Password\n',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      // const login_components().textField_pass("Enter Password", TextInputType.visiblePassword,_passwordController),
                      TextFormField(
                        obscureText: _isobscure,
                        controller: _passwordController,
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

                      Align(
                          alignment: Alignment(1, 0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => forgotPassword()));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF1D2A3A)),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),

                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Remember Me",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff646464),
                              fontSize: 16,
                            )),
                        value: _ischecked,
                        onChanged: (value) {
                          _handleRememeberme(value!);
                        },
                      ),

                      // Checkbox(value: _ischecked, onChanged: _handleRememeberme(_ischecked)),

                      // const SizedBox(
                      //   height: 30,
                      // ),

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
                              : const Text('LogIn'),
                          onPressed:() {
                            Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => homepage()));
                          },
                          // onPressed: () async {
                          //   if (isLoading) return;
                          //
                          //   setState(() => isLoading = true);
                          //
                          //   if (_emailController.text.isNotEmpty &&
                          //       _passwordController.text.isNotEmpty) {
                          //     userLogin();
                          //   } else {
                          //     showDialog(
                          //         context: context,
                          //         builder: (context) => AlertDialog(
                          //               title: Text('Error'),
                          //               content:
                          //                   Text("All fields are required!!"),
                          //               actions: [
                          //                 TextButton(
                          //                     onPressed: () {
                          //                       Navigator.of(context).pop();
                          //                     },
                          //                     child: Text('Ok'))
                          //               ],
                          //             ));
                          //   }
                          //   //dashboardScreen();
                          //   // User? user = await loginUsingEmailPassword(
                          //   //     email: _emailController.text,
                          //   //     password: _passwordController.text,
                          //   //     context: context);
                          //   // print(user);
                          //   // if (user != null) {
                          //   //   setState(() => isLoading = false);
                          //   //   Navigator.of(context).pushReplacement(
                          //   //       MaterialPageRoute(
                          //   //           builder: (context) => dashboardScreen()));
                          //   // } else {
                          //   //   Fluttertoast.showToast(
                          //   //       msg: "Enter Valid Email and Password",
                          //   //       toastLength: Toast.LENGTH_SHORT,
                          //   //       gravity: ToastGravity.BOTTOM,
                          //   //       timeInSecForIosWeb: 1,
                          //   //       backgroundColor: Colors.red,
                          //   //       textColor: Colors.white,
                          //   //       fontSize: 16.0);
                          //   //   setState(() => isLoading = false);
                          //   // }
                          // },
                        ),
                      ),

                      // alignment: Alignment(0, 0.5),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => registration()));
                          },
                          child: const Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Register",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF1D2A3A)),
                                  )
                                ],
                                text: "Don't have an account? ",
                                style: TextStyle(color: Color(0xFF1D2A3A)),
                              ),
                            ),
                            // child: const Text(
                            //   "Register",
                            //   style: TextStyle(
                            //       decoration: TextDecoration.underline,
                            //       fontSize: 15,
                            //       color: Color(0xFF1D2A3A),
                            //       fontWeight: FontWeight.w600,),
                            // ),
                          )),
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

  Future<void> _handleRememeberme(bool value) async {
    _ischecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _ischecked = value;
    });
  }

  _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _rememberMe = _prefs.getBool("remember_me") ?? false;

      if (_rememberMe) {
        setState(() {
          _ischecked = true;
        });
        _emailController.text = _email;
        _passwordController.text = _password;
      }
    } catch (e) {
      print(e);
    }
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
        print(response);
        // print(response);

        if (uid != "") {
          SharedPreferences studata = await SharedPreferences.getInstance();

          studata.setString("stuid", uid);
          studata.setString("stuName", response["username"]);
          studata.setString("role", response["role"]);

          if (response["isVerified"] == "0") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => VerifyOTPScreen()));
          } else if (response["isVerified"] == "1") {
            checkProfile(uid);
            // Navigator.of(context).pushReplacement(
            //                 MaterialPageRoute(
            //                     builder: (context) => dashboardScreen()));
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
          }
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

  Future checkProfile(uid) async {
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/checkProfile.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({"id": uid}),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*",
            'Accept': '*/*'
          },
          encoding: Encoding.getByName('utf-8'));

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
      } else if (res.statusCode == 200) {
        var response = json.decode(res.body);
        var flag = response["profileFlag"];
        print(response);

        if (flag == "0") {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => createProfile()));
        } else if (flag == "1") {
          checkPayment();
        } else {
          print("somthing wrong");
        }
      } else {
        print("some issue");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future checkPayment() async {
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/checkPayment.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({"id": uid}),
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
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => payment()));

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
        print(response["sid"]);

        if (response["sid"] == uid) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => dashboardScreen()));
          setState(() => isLoading = false);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
