import 'dart:convert';

import 'package:college_event_management/registration/components/registration_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';
import '../../size_config.dart';
import '../../terms.dart';
import '../registrtion.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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
  var uuid = Uuid();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child:LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(duration: Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500 ? EdgeInsets.zero : const EdgeInsets.all(30.0),
          child: Center(
            child: Container(
              padding:  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              child:  Column(
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
                    icon: const Icon(
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
                  registration_components().text('   User Name', FontWeight.w600, Color(0xFF1D2A3A), 16),
                  // const Text('   User Name',
                  //     style: TextStyle(
                  //         fontSize: 16, color: Color(0xFF1D2A3A))),
                  const SizedBox(
                    height: 10,
                  ),
                  const registration_components().textField("Enter Your Name", TextInputType.text, _signUpNameController,""),
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
                  registration_components().text('   Registration Email', FontWeight.w600, Color(0xFF1D2A3A), 16),

                  const SizedBox(
                    height: 10,
                  ),
                  const registration_components().textField("Enter Email", TextInputType.emailAddress, _signUpEmailController,""),

                  const SizedBox(
                    height: 30,
                  ),
                  registration_components().text('   Password', FontWeight.w600, Color(0xFF1D2A3A), 16),

                  const SizedBox(
                    height: 10,
                  ),
                  const registration_components().textField("Enter Password", TextInputType.visiblePassword, _signUpPasswordController,""),

                  const SizedBox(
                    height: 30,
                  ),
                  registration_components().text('   Confirm Password', FontWeight.w600, Color(0xFF1D2A3A), 16),

                  const SizedBox(
                    height: 10,
                  ),
                  const registration_components().textField("Enter Confirm Password", TextInputType.text, _signUpConfrimPasswordController, "confirmpassword"),
                CheckboxListTile(
                  title:  const Text.rich(
                      TextSpan(
                        children: [

                          TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF1D2A3A),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline)
                          )
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
                  controlAffinity: ListTileControlAffinity.leading,
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
                            if (isLoading) return;

                            if (_signUpEmailController
                                .text.isNotEmpty) {
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
                      ),
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
            )),
          );
        })),
    );
  }

  Future signUp() async {
    setState(() => isLoading = false);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _signUpEmailController.text,
          password: _signUpPasswordController.text);

      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(FirebaseAuth.instance.currentUser?.uid)
      //     .set({
      //   'uid': FirebaseAuth.instance.currentUser?.uid,
      //   'name': _signUpNameController.text,
      // });
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
      String uri = "https://convergence.uvpce.ac.in/C2K22/auth/signup.php";
      var res = await http.post(Uri.parse(uri), body: json.encode({
        "id": uuid.v4(),
        "email": _signUpEmailController.text,
        "userName": _signUpNameController.text,
        "isStudent": 1,
        "password": _signUpPasswordController.text
      }), headers: {
        "Accept":"application/json",
        "Access-Control-Allow-Origin": "*"
      }, encoding:Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg:
            "Success!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("User added Successfully!!");
        // setState(() => isLoading = false);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
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
