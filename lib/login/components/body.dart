import 'package:college_event_management/login/components/login_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../dashboardScreen.dart';
import '../../forgotPassword.dart';
import '../../registrtion.dart';
import '../../size_config.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool _isobscure = true;
  bool isLoading = false;

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
        print("No Usre Found For this Email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            //Login Text Container
            Column(
              children: [
                const Align(alignment: Alignment(0, 0)),
                Container(
                    height: getHeight(50),
                    width: getWidth(kIsWeb ? 100 : double.infinity),
                    margin: EdgeInsets.only(
                        left: 20,
                        top: MediaQuery.of(context).size.height * 0.12),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 40,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1D2A3A)),
                    )),
                Container(
                    height: getHeight(555),
                    width: getWidth(kIsWeb ? 100 : double.infinity),
                    // width: kIsWeb ? 600 : double.infinity,
                    // constraints: BoxConstraints(maxWidth: 1000),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('    Phone Email\n',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF1D2A3A))),
                        login_components().textField("Enter Email Address", TextInputType.emailAddress, _emailController),

                        // TextField(
                        //   keyboardType: TextInputType.emailAddress,
                        //   controller: _emailController,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15)),
                        //     hintText: 'Enter Email Address',
                        //   ),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),

                        const Text('    Password\n',
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
                                onPressed: ()  => _isobscure = !_isobscure,
                              )),
                          keyboardType: TextInputType.visiblePassword,
                        ),

                        Align(
                            alignment: Alignment(1, 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            forgotPassword()));
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xFF1D2A3A)),
                              ),
                            )),
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
                                  primary: Color(0xFF1D2A3A),
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
                                    : const Text('LogIn'),
                                onPressed: () async {
                                  if (isLoading) return;

                                  setState(() => isLoading = true);
                                  User? user = await loginUsingEmailPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      context: context);
                                  print(user);
                                  if (user != null) {
                                    setState(() => isLoading = false);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                dashboardScreen()));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Enter Valid Email and Password",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    setState(() => isLoading = false);
                                  }
                                },
                              ),
                            )),
                        Align(
                          // alignment: Alignment(0, 0.5),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            registration()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Align(alignment: Alignment.center),
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Color(0xFF1D2A3A)),
                                  ),
                                  Text(
                                    "Register",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF1D2A3A)),
                                  )
                                ],
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
                    )),
              ],
            ),

            //Email Container
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
