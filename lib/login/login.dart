import 'package:college_event_management/dashboard/components/body.dart'
    as dashboard_body;
import 'package:college_event_management/login/components/body.dart'
    as login_body;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Login Function

  Future<bool> isLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? studentId = _prefs.getString("stuid");

    if (studentId != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error} occurred',
              style: TextStyle(fontSize: 18),
            ),
          );
        } else if (snapshot.hasData) {
          final isLoggedIn = snapshot.data as bool;
          // print("\nDaaaaaaaaaaaaaaaaaaaaaaaaaaaaaata: $isLoggedIn");


          if (isLoggedIn) {
            return dashboard_body.body();
          } else {
            return login_body.body();
          }
        } else {
          return SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}
