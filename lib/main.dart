import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dashboardScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),

      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initialize firebase

  Future<FirebaseApp> _intitializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _intitializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isobscure = true;

  //Login Function
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
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          //Login Text Container
          Column(
            children: [
              const Align(alignment: Alignment(0, 0)),
              Container(
                  height: getHeight(50),
                  width: getWidth(kIsWeb ? 100 : double.infinity),
                  margin: EdgeInsets.only(
                      left: 20, top: MediaQuery.of(context).size.height * 0.12),
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
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Email Address',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Password\n',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      TextField(
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
                              onPressed: () {
                                setState(() {
                                  _isobscure = !_isobscure;
                                });
                              },
                            )),
                      ),
                      Align(
                          alignment: Alignment(1, 0),
                          child: TextButton(
                            onPressed: () {},
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
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Color(0xFF1D2A3A),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextButton(
                              child: const Text(
                                'LogIn',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          )),
                      Align(
                          // alignment: Alignment(0, 0.5),
                          child: TextButton(
                        onPressed: () async{
                          User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                          print(user);
                          if(user != null)
                            {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> dashboardScreen()));
                            }
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   bool _isobscure = true;
//
//
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var screensize=MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//
//         children: <Widget>[
//
//
//           //Login Text Container
//
//           Column(
//             children: [
//               Align(alignment: Alignment(0, 0)),
//               Container(
//                   height: getHeight(50),
//                   width: getWidth(kIsWeb ? 100 : double.infinity),
//                   margin: EdgeInsets.only(
//                       left: 20, top: MediaQuery.of(context).size.height * 0.12),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(
//                         fontSize: 40,
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1D2A3A)),
//                   )),
//               Container(
//                 height: getHeight(555),
//                   width: getWidth(kIsWeb ? 100 : double.infinity),
//                   // width: kIsWeb ? 600 : double.infinity,
//                   // constraints: BoxConstraints(maxWidth: 1000),
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.only(
//                       left: 20,
//                       right: 20,
//                       top: MediaQuery.of(context).size.height * 0.1),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('    Phone Number\n',
//                           style: TextStyle(
//                               fontSize: 16, color: Color(0xFF1D2A3A))),
//                       TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                           hintText: 'Enter Phone Number',
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       const Text('    Password\n',
//                           style: TextStyle(
//                               fontSize: 16, color: Color(0xFF1D2A3A))),
//                       TextField(
//                         obscureText: _isobscure,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             hintText: 'Enter Password',
//                             suffixIcon: IconButton(
//                               icon: Icon(_isobscure
//                                   ? Icons.visibility
//                                   : Icons.visibility_off),
//                               onPressed: () {
//                                 setState(() {
//                                   _isobscure = !_isobscure;
//                                 });
//                               },
//                             )),
//                       ),
//                       Align(
//                           alignment: Alignment(1, 0),
//
//                           child: TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               'Forgot Password?',
//                               style: TextStyle(
//                                   fontSize: 15, color: Color(0xFF1D2A3A)),
//                             ),
//                           )),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 70, vertical: 5),
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.all(3),
//                             decoration: BoxDecoration(
//                                 color: Color(0xFF1D2A3A),
//                                 borderRadius: BorderRadius.circular(30)),
//                             child: TextButton(
//                               child: const Text(
//                                 'LogIn',
//                                 style: TextStyle(
//                                     fontSize: 20.0, color: Colors.white),
//                               ),
//                               onPressed: () {},
//                             ),
//                           )),
//                       Align(
//                           // alignment: Alignment(0, 0.5),
//                           child: TextButton(
//                             onPressed: () {},
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                               Align(alignment: Alignment.center),
//                               Text("Don't have an account? ", style: TextStyle(color: Color(0xFF1D2A3A)),),
//                               Text("Register", style: TextStyle(fontWeight: FontWeight.w900, color:  Color(0xFF1D2A3A)),)
//                             ],),
//                             // child: const Text(
//                             //   "Register",
//                             //   style: TextStyle(
//                             //       decoration: TextDecoration.underline,
//                             //       fontSize: 15,
//                             //       color: Color(0xFF1D2A3A),
//                             //       fontWeight: FontWeight.w600,),
//                             // ),
//                           )),
//                       ],
//                   )),
//             ],
//           ),
//
//           //Email Container
//         ],
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
