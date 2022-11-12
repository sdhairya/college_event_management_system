import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../homepage/homepage.dart';
import '../../profileDetails/profileDetails.dart';
import '../campaignerDashBoard.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  var visitedColleges;
  var myParticipants;
  var totalParticipants;
  var campId;
  var campaignerToken;


  @override
  void initState() {
    getcampData();
    // getVisitedCollegeL();
    // getTotalParticipatianceList();
    // getMyParticipants();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1D2A3A),
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  buildMenuItems(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.home_filled),
          title: const Text('Home'),
          onTap: () {
            const campaignerDashBoard();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('My Profile'),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => profileDetails(
                )));
          },
        ),

        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Logout'),
          onTap: () async {
            SharedPreferences studata = await SharedPreferences.getInstance();
            SharedPreferences data = await SharedPreferences.getInstance();
            data.clear();
            studata.clear();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => homepage()));
          },
        ),

      ],
    );
  }

  Future getcampData() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    campId = studata.getString("stuid");
    var url = Uri.parse("https://convergence.uvpce.ac.in/C2K22/CampaignerDashboard/campaignerPaticipants.php?id=$campId");
    var res = await http.get(url);
    var response = json.decode(res.body);
    campaignerToken = response["campaigner_token"];
    print(campaignerToken);
    getVisitedCollegeL();
    getMyParticipants();
    getTotalParticipatianceList();
  }

  Future getVisitedCollegeL() async{

    try {
      var url = Uri.parse(
          "https://convergence.uvpce.ac.in/C2K22/CampaignerDashboard/visitedColleges.php?campaignerToken=$campaignerToken");
      var response = await http.get(url);
      visitedColleges = json.decode(response.body);
      print(visitedColleges);
    }catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future getMyParticipants() async{
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/CampaignerDashboard/campaignerPaticipants.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "campaignerToken":campaignerToken
          }),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("User Not Found Check the Email address!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
      } else if (res.statusCode == 442) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("Bed Request!!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
      } else if (res.statusCode == 200) {
        myParticipants = json.decode(res.body);

        print("getMyParticipants function work!!");
        print(myParticipants);
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }


  }

  Future getTotalParticipatianceList() async
  {
    try {
      var url = Uri.parse(
          "https://convergence.uvpce.ac.in/C2K22/totalParticipants.php?campaignerToken=$campaignerToken");
      var response = await http.get(url);
      totalParticipants = json.decode(response.body);

      print(totalParticipants);
    }catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Some issue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

  }




}
