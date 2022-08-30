import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:college_event_management/size_config.dart';
import '../addFaculty.dart';
import 'addFaculty_components.dart';

import '../../dashboardScreen.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  TextEditingController _nameController  =  TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool temp = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
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
                          padding: EdgeInsets.only(bottom: 3,right: 8),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => dashboardScreen()));
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded,size: 30,)),

                      Text('Add Faculty',
                        style: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D2A3A)),)
                    ],
                  ),
                ),
                Container(
                  height: getHeight(555),
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
                      const addFaculty_components().text("    Name"),
                      const SizedBox(
                        height: 10,
                      ),
                      const addFaculty_components().textField("Enter Name", TextInputType.text,_nameController),

                      const SizedBox(
                        height: 30,
                      ),
                      const addFaculty_components().text("    Email"),

                      const SizedBox(
                        height: 10,
                      ),
                      const addFaculty_components().textField("Enter Email", TextInputType.emailAddress,_emailController),
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
                                  : const Text('Add Faculty'),
                              onPressed: () async {
                                if (isLoading) return;

                                setState(() => isLoading = true);
                                addFaculty().addFacultyDetails(_nameController.text,_emailController.text);
                                  // get();

                              },
                            ),
                          )),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // void get() async{
  //
  //   setState(() => isLoading=temp);
  // }
}
