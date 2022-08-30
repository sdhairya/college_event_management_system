import 'package:college_event_management/registration/components/registration_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../login/main.dart';
import '../../size_config.dart';
import '../../terms.dart';
import '../registrtion.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  bool isLoading = false;
  bool isChecked = false;
  TextEditingController _signUpEmailController = TextEditingController();
  TextEditingController _signUpPasswordController = TextEditingController();
  TextEditingController _signUpConfrimPasswordController = TextEditingController();
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
                      const Text('    Registration Email',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      const registration_components().textField("Enter Email", TextInputType.emailAddress, _signUpEmailController,""),
                      // TextFormField(
                      //   controller: _signUpEmailController,
                      //   validator: _requiredValidator,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15)),
                      //     hintText: 'Enter Email',
                      //   ),
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
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
                      // TextFormField(
                      //   controller: _signUpPasswordController,
                      //   validator: _requiredValidator,
                      //   // keyboardType: kebordtype,
                      //   // obscureText: password,
                      //
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15)),
                      //     hintText: 'Enter Password',
                      //   ),
                      // ),
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
                      // TextFormField(
                      //   controller: _signUpConfrimPasswordController,
                      //   validator: _confirmPasswordValidator,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15)),
                      //     hintText: 'Enter Confirm Password',
                      //   ),
                      //   keyboardType: TextInputType.number,
                      // ),
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

                                if (_signUpEmailController
                                    .text.isNotEmpty) {
                                  if (_signUpPasswordController.text ==
                                      _signUpConfrimPasswordController
                                          .text) {
                                    const registration().signUp(_signUpEmailController.text,_signUpPasswordController.text,_signUpNameController.text);
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



}
