import 'dart:async';

import 'package:flutter/material.dart';

import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dashboard/dashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class emailVerification extends StatefulWidget {
  const emailVerification({Key? key}) : super(key: key);

  @override
  State<emailVerification> createState() => _emailVerificationState();
}

class _emailVerificationState extends State<emailVerification> {
  final user = FirebaseAuth.instance;
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void intState() {


    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => SnackBar(content: Text("Email Sent")));
    if (!isEmailVerified) {

      WidgetsBinding.instance.addPostFrameCallback((_) => SnackBar(content: Text("Email Sent")));

      sendVerificationEmail();
    // WidgetsBinding.instance.addPostFrameCallback((_) => SnackBar(content: Text("Email Sent")));
    //   print("Email send");
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    //call after email verification!

    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {

      await user.currentUser!.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));

      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
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
              title: const Text('Email Verification failed!'),
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

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? dashboardScreen()
      : Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A verification email has been sent to your',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 26),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.email, size: 32),
                  label: Text(
                    'Reset Email',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: canResendEmail ? sendVerificationEmail: null,
                ),
              ],
            ),
          ),
        );
// {
//
// return Container();
// }

}
