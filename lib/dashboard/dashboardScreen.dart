import 'package:college_event_management/dashboard/components/body.dart'
    as dashboardBody;
import 'package:college_event_management/login/components/body.dart'
    as loginBody;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({Key? key}) : super(key: key);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
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

          if (isLoggedIn) {
            return dashboardBody.body();
          } else {
            return loginBody.body();
          }
        } else {
          return SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(backgroundColor: Colors.red,),
          );
        }
      },
    );
  }
}
