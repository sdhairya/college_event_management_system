import 'dart:ui';

import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  bool _isobscure = true;
  bool isLoading = false;
  bool isChecked = false;
  TextEditingController _signUpEmailController = TextEditingController();
  TextEditingController _signUpPasswordController = TextEditingController();
  TextEditingController _signUpConfrimPasswordController =
      TextEditingController();
  TextEditingController _signUpNameController = TextEditingController();

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
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2A3A)),
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
                      TextField(
                        controller: _signUpNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Your Name',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Registration Email',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _signUpEmailController,
                        validator: _requiredValidator,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Password',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _signUpPasswordController,
                        validator: _requiredValidator,
                        // keyboardType: kebordtype,
                        // obscureText: password,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Password',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Confirm Password',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _signUpConfrimPasswordController,
                        validator: _confirmPasswordValidator,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Confirm Password',
                        ),
                        keyboardType: TextInputType.number,
                      ),
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
                              onPressed: () => showDialog(
                                    context: context,
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
                                      content: Container(
                                        child: const Text("1. One\n\n"
                                            "2. Two\n\n"
                                            "3. Three \n\n"
                                            "4. Four \n\n"
                                            "5. Five\n\n"
                                            "6. Six\n\n"
                                            "7. Seven \n\n"
                                            "8. Eight\n\n"),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: Navigator.of(context).pop,
                                          child: const Text(
                                            'Ok',
                                            style:
                                                TextStyle(color: Colors.white),
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
                                  ),
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
                                
                                primary: isChecked ? Color(0xFF1D2A3A) : Color(0xFFFF7F7F7),
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
                              onPressed: isChecked ? ()
                              async {
                                if (isLoading) return;

                                if (_signUpEmailController.text.isNotEmpty) {
                                  if (_signUpPasswordController.text ==
                                      _signUpConfrimPasswordController.text) {
                                    signUp();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Confirm password don't match!!",
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
                                // User? user = await loginUsingEmailPassword(
                                //     email: _emailController.text,
                                //     password: _passwordController.text,
                                //     context: context);
                                // print(user);
                                // if (user != null) {
                                //   setState(() => isLoading = false);
                                //   Navigator.of(context).pushReplacement(
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               dashboardScreen()));
                                // } else {
                                //   Fluttertoast.showToast(
                                //       msg: "Enter Valid Email and Password",
                                //       toastLength: Toast.LENGTH_SHORT,
                                //       gravity: ToastGravity.BOTTOM,
                                //       timeInSecForIosWeb: 1,
                                //       backgroundColor: Colors.red,
                                //       textColor: Colors.white,
                                //       fontSize: 16.0);
                                //   setState(() => isLoading = false);
                                // }
                              } : null,
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

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This feild is required";
    }
    return null;
  }

  String? _confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return "This feild is required";
    }

    if (_signUpPasswordController.text != confirmPasswordText) {
      return "Passwords don't match";
    }
    return null;
  }

  Future signUp() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _signUpEmailController.text,
          password: _signUpPasswordController.text);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'name': _signUpNameController.text,
      });
      setState(() => isLoading = false);
      // await FirebaseFirestore.instance.collection("users").add({
      //   'uid': FirebaseAuth.instance.currentUser?.uid,
      //   'name': _signUpNameController.text,
      // });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
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
}
