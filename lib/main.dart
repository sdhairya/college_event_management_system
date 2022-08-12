import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isobscure = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[


          //Login Text Container

          Column(
            children: [
              Align(alignment: Alignment(0, 0)),


              Container(
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
                  width: kIsWeb ? 800 : double.infinity,
                  // constraints: BoxConstraints(maxWidth: 1000),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('    Phone Number\n',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Phone Number',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      const Text('    Password\n',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      TextField(
                        obscureText: _isobscure,
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
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
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
                            onPressed: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                              Align(alignment: Alignment.center),
                              Text("Don't have an account? ", style: TextStyle(color: Color(0xFF1D2A3A)),),
                              Text("Register", style: TextStyle(fontWeight: FontWeight.w900, color:  Color(0xFF1D2A3A)),)
                            ],),
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
