import 'package:college_event_management/addCoordinator/components/addCoordinator_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../login/main.dart';
import '../../size_config.dart';


TextEditingController _coordiantorNameController = TextEditingController();
TextEditingController _coordiantorEmailController = TextEditingController();
TextEditingController _coordiantorPhoneController = TextEditingController();
TextEditingController _coordiantorEnrollmentController = TextEditingController();


class addCoordinator extends StatefulWidget {
  const addCoordinator({Key? key}) : super(key: key);

  @override
  State<addCoordinator> createState() => _addCoordinatorState();
}

class _addCoordinatorState extends State<addCoordinator> {
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
                      addCoordinator_components().text("Add Coordinator", FontWeight.w600, Color(0xFF1D2A3A), 35),
                      // Text(
                      //   'Add Coordinator ',
                      //   style: TextStyle(
                      //       fontSize: 35,
                      //       fontStyle: FontStyle.normal,
                      //       fontWeight: FontWeight.w600,
                      //       color: Color(0xFF1D2A3A)),
                      // )
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
                      const addCoordinator_components().text('   Name', FontWeight.normal, Color(0xFF1D2A3A), 16),

                      const SizedBox(
                        height: 10,
                      ),
                      const addCoordinator_components().textField("Enter Your Name", TextInputType.text, _coordiantorNameController),

                      const SizedBox(
                        height: 30,
                      ),
                      const addCoordinator_components().text('   Email', FontWeight.normal, Color(0xFF1D2A3A), 16),
                      const SizedBox(
                        height: 10,
                      ),
                      const addCoordinator_components().textField("Enter Email", TextInputType.emailAddress, _coordiantorEmailController),

                      const SizedBox(
                        height: 30,
                      ),
                      const addCoordinator_components().text('   Phone Number', FontWeight.normal, Color(0xFF1D2A3A), 16),
                      const SizedBox(
                        height: 10,
                      ),
                      const addCoordinator_components().textField("Enter Phone Number", TextInputType.visiblePassword, _coordiantorPhoneController),

                      const SizedBox(
                        height: 30,
                      ),
                      const addCoordinator_components().text('   Enrollment Number', FontWeight.normal, Color(0xFF1D2A3A), 16),

                      const SizedBox(
                        height: 10,
                      ),
                      const addCoordinator_components().textField("Enter Enrollment No.", TextInputType.text, _coordiantorEnrollmentController),

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
                                primary:Color(0xFF1D2A3A),
                                onSurface: Color(0xFF1D2A3A),
                                padding: EdgeInsets.all(3),
                                textStyle: TextStyle(fontSize: 20),
                                minimumSize: Size.fromHeight(50),
                                shape: StadiumBorder(),
                                enableFeedback: true,
                              ),
                              child: const Text('Add Coordinator'),
                              onPressed: (){}
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
