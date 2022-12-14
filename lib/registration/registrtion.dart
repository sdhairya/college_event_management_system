import 'dart:convert';
import 'dart:ui';

import 'package:college_event_management/emailVerification.dart';
import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../registration/components/body.dart';
import '../dashboard/dashboardScreen.dart';
import 'package:college_event_management/registration/components/registration_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

// bool isChecked = false;
// bool isLoading = false;
// TextEditingController _signUpEmailController = TextEditingController();
// TextEditingController _signUpPasswordController = TextEditingController();
// TextEditingController _signUpConfrimPasswordController = TextEditingController();
// TextEditingController _signUpNameController = TextEditingController();

class registration extends StatelessWidget {
  const registration({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return body();
  }
}

// class registration extends StatefulWidget {
//   const registration({Key? key}) : super(key: key);
//
//   @override
//   State<registration> createState() => _registrationState();
//
//
//
//
// }
//
// class _registrationState extends State<registration> {
//   bool _isobscure = true;
//   bool isChecked = false;
//   bool isLoading = false;
//   TextEditingController _signUpEmailController = TextEditingController();
//   TextEditingController _signUpPasswordController = TextEditingController();
//   TextEditingController _signUpConfrimPasswordController = TextEditingController();
//   TextEditingController _signUpNameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return body();
//   }
//
//   String? _requiredValidator(String? text) {
//     if (text == null || text.trim().isEmpty) {
//       return "This feild is required";
//     }
//     return null;
//   }
//
//   String? _confirmPasswordValidator(String? confirmPasswordText) {
//     if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
//       return "This feild is required";
//     }
//
//     if (_signUpPasswordController.text != confirmPasswordText) {
//       return "Passwords don't match";
//     }
//     return null;
//   }
//
//   Future signUp() async {
//     setState(() => isLoading = false);
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _signUpEmailController.text,
//           password: _signUpPasswordController.text);
//
//       // await FirebaseFirestore.instance
//       //     .collection("users")
//       //     .doc(FirebaseAuth.instance.currentUser?.uid)
//       //     .set({
//       //   'uid': FirebaseAuth.instance.currentUser?.uid,
//       //   'name': _signUpNameController.text,
//       // });
//       insertUser();
//
//       // await FirebaseFirestore;
//     } on FirebaseAuthException catch (e) {
//       _handleSignUpError(e);
//       setState(() => isLoading = false);
//     }
//   }
//
//   void _handleSignUpError(FirebaseAuthException e) {
//     String messageToDisplay;
//
//     switch (e.code) {
//       case 'email-already-in-use':
//         messageToDisplay = 'This email is already in use!';
//         break;
//       case 'invalid-email':
//         messageToDisplay = 'This email you entered is invalid!';
//         break;
//       case 'operation-not-allowed':
//         messageToDisplay = 'This operation is not allowed!';
//         break;
//       case 'weak-password':
//         messageToDisplay = 'This password you entered is too weak!';
//         break;
//       default:
//         messageToDisplay = 'An unknown error occurred!';
//         break;
//     }
//
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text('Registration up failed!'),
//               content: Text(messageToDisplay),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Ok'))
//               ],
//             ));
//   }
//
//   Future insertUser() async {
//     var userId = FirebaseAuth.instance.currentUser?.uid.toString();
//     try {
//       String uri = "https://convergence.uvpce.ac.in/C2K22/insert_user.php";
//         var res = await http.post(Uri.parse(uri), body: json.encode({
//         "firebaseId": userId,
//         "email": _signUpEmailController.text,
//         "userName": _signUpNameController.text,
//         "privilege": "student"
//       }), headers: {
//           "Accept":"application/json",
//         "Access-Control-Allow-Origin": "*"
//       }, encoding:Encoding.getByName('utf-8'));
//       print(res.statusCode);
//     //  var response = json.decode(res.body);
//
//       //print(response["firebaseId"]);
//       //print(response);
//       if (res.statusCode == 200) {
//         print("User added Successfully!!");
//         setState(() => isLoading = false);
//
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => HomePage()));
//       } else {
//         print("some issue");
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   void terms() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Center(
//           child: Text(
//             "Terms & Conditions",
//             style: TextStyle(
//               fontSize: 15,
//               color: Color(0xFF1D2A3A),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         content: const SingleChildScrollView(
//           child: Text("1. Acknowledgment\n"
//               "These are the Terms and Conditions governing the use of this Service and the agreement that operates"
//               "between You and the Company. These Terms and Conditions set out the rights and obligations of all users"
//               "regarding the use of the Service.\n\n"
//               "2. User Accounts\n"
//               "When You create an account with Us, You must provide Us information that is accurate, complete, and"
//               "current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate"
//               "termination of Your account on Our Service\n\n"
//               "3. Termination\n"
//               "We may terminate or suspend Your Account immediately, without prior notice or liability, for any reason"
//               "whatsoever, including without limitation if You breach these Terms and Conditions.\n\n"
//               "4. Payments\n"
//               "Payment can be made through various payment methods we have available, such as Visa, MasterCard,"
//               "Affinity Card, American Express cards or online payment methods (PayPal, for example)\n\n"
//               "5. Content\n"
//               "Our Service allows You to post Content. You are responsible for the Content that You post to the Service,"
//               "including its legality, reliability, and appropriateness.\n\n"),
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: Navigator.of(context).pop,
//             child: const Text(
//               'Ok',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               primary: Color(0xFF1D2A3A),
//               onSurface: Color(0xFF1D2A3A),
//               padding: EdgeInsets.all(1),
//               textStyle: TextStyle(fontSize: 20),
//               shape: StadiumBorder(),
//               enableFeedback: true,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
