import 'package:college_event_management/login/components/login_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../forgotPassword.dart';
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
      body: SingleChildScrollView(
        child:
            //Login Text Container
        Container(
        margin: EdgeInsets.only(
        left: getWidth(150),
            right: getWidth(150),
    top: getPercentHeight(12)),
    child:
            Column(
              children: [
                const Align(alignment: Alignment(0, 0)),
                 const Text(
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
                        const Text('Phone Email\n',
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
                        SizedBox(
                          height: getPercentHeight(1),
                        ),

                        const Text('Password\n',
                            style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                          height: 20,
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          SizedBox(
                              height: 24.0,
                              width: 24.0,
                                child: Checkbox(
                                    value: _ischecked,
                                    onChanged: (value) {
                                      _handleRememeberme(value!);
                                    },),
                              ),
                          SizedBox(width: 10.0),
                          Text("Remember Me",
                              style: TextStyle(
                                  color: Color(0xff646464),
                                  fontSize: 16,))
                        ]),
                        // Checkbox(value: _ischecked, onChanged: _handleRememeberme(_ischecked)),
                        
                        const SizedBox(
                          height: 30,
                        ),

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
                            )
                        ,
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
                    )


              ],
            ),
        )
      ),
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

  _loadUserEmailPassword() async{
    try{
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password  = _prefs.getString("password") ?? "";
      var _rememberMe = _prefs.getBool("remember_me") ?? false;

      if(_rememberMe){
        setState(() {
          _ischecked = true;
        });
        _emailController.text=_email;
        _passwordController.text = _password;
      }
    }catch(e){
      print(e);
    }
  }


}
