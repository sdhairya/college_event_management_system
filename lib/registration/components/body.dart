import 'dart:convert';

import 'package:college_event_management/registration/components/registration_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../login/main.dart';
import '../../size_config.dart';
import '../../terms.dart';
import '../registrtion.dart';
import 'package:http/http.dart' as http;

TextEditingController _signUpEmailController = TextEditingController();
TextEditingController _signUpPasswordController = TextEditingController();
TextEditingController _signUpConfrimPasswordController = TextEditingController();
TextEditingController _signUpNameController = TextEditingController();

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  bool isLoading = false;
  bool isChecked = false;


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
                      Text(
                        'Register ',
                        style: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D2A3A)),
                      )
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
                      const Text('   User Name',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      const registration_components().textField("Enter Your Name", TextInputType.text, _signUpNameController,""),

                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Registration Email',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      const registration_components().textField("Enter Email", TextInputType.emailAddress, _signUpEmailController,""),

                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Password',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      const registration_components().textField("Enter Password", TextInputType.visiblePassword, _signUpPasswordController,""),

                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Confirm Password',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      const registration_components().textField("Enter Confirm Password", TextInputType.text, _signUpConfrimPasswordController, "confirmpassword"),

                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this.isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                this.isChecked = value!;
                              });
                            },
                          ),
                          Text("I read and agree with"),
                          TextButton(
                              onPressed: () {
                                terms();
                              },
                              child: const Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF1D2A3A),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
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
                                if (isLoading) return;

                                setState(() => isLoading = true);


                                if (_signUpEmailController
                                    .text.isNotEmpty && _signUpNameController.text.isNotEmpty) {
                                  if (_signUpPasswordController.text ==
                                      _signUpConfrimPasswordController
                                          .text) {
                                    signUp();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                        "Confirm password don't match!!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    setState(() => isLoading = false);
                                  }
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
                              }
                                  : null,
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




  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _signUpEmailController.text,
          password: _signUpPasswordController.text);

      insertUser();

      // await FirebaseFirestore;
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
      setState(() => isLoading = false);
    }
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;

    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'This email is already in use!';
        break;
      case 'invalid-email':
        messageToDisplay = 'This email you entered is invalid!';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'This operation is not allowed!';
        break;
      case 'weak-password':
        messageToDisplay = 'This password you entered is too weak!';
        break;
      default:
        messageToDisplay = 'An unknown error occurred!';
        break;
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration up failed!'),
          content: Text(messageToDisplay),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'))
          ],
        ));
  }

  Future insertUser() async {
    var userId = FirebaseAuth.instance.currentUser?.uid.toString();
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/insert_user.php";
      var res = await http.post(Uri.parse(uri), body: json.encode({
        "uid": userId,
        "email": _signUpEmailController.text,
        "userName": _signUpNameController.text,
        "privilege": "student"
      }), headers: {
        "Accept":"application/json",
        "Access-Control-Allow-Origin": "*"
      }, encoding:Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 200) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Registration'),
              content: const Text("Registration Successful!!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text('Ok'))
              ],
            ));
        print("User added Successfully!!");
        // setState(() => isLoading = false);


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