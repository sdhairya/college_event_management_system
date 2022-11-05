import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../size_config.dart';
import 'package:college_event_management/createEvent/components/createEvent_components.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool isLoading = false;
  List<String> list = <String>['Tech', 'Talk', 'Funny', 'Sports'];
  String dropdownValue = "Tech";
  // name, category, date, location, charges, description
  TextEditingController _eventNameController = TextEditingController();
  // TextEditingController _eventCategoryController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _eventLocationController = TextEditingController();
  TextEditingController _eventChargesController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: false,
        child: LayoutBuilder(builder: (context, constraints){
          return AnimatedContainer(duration: const Duration(milliseconds: 600),
          padding: constraints.maxWidth<500 ? EdgeInsets.zero : const EdgeInsets.all(30),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment(0, 0),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 0,
                          leading: IconButton(
                              padding:
                              const EdgeInsets.only(bottom: 3, right: 3),
                              onPressed: () {
                                //
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            dashboardScreen()));
                              },
                              icon: Icon(
                                color: Color(0xFF1D2A3A),
                                Icons.arrow_back_ios_new_rounded,
                                size: 20,
                              )),
                          title: const Text(
                            'Dashboard ',
                            style: TextStyle(
                                fontSize: 22,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1D2A3A)),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: createEvent_components().text("Create Event", FontWeight.bold, Color(0xFF1D2A3A), 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: MediaQuery.of(context).size.height * 0.06),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const createEvent_components().text("   Event Name",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          const createEvent_components()
                              .textField("Enter Event Name", TextInputType.text, _eventNameController),
                          const SizedBox(
                            height: 30,
                          ),
                          const createEvent_components().text("   Event Category",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Colors.black38)
                                    )
                                ),
                                items: list.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                value: dropdownValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                }),),
                          const SizedBox(
                            height: 30,
                          ),
                          const createEvent_components().text("   Event Date",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          const createEvent_components()
                              .textField("Enter Date", TextInputType.datetime, _eventDateController),
                          const SizedBox(
                            height: 30,
                          ),
                          const createEvent_components().text("   Event Location",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          const createEvent_components().textField(
                              "Enter Event Location", TextInputType.text, _eventLocationController),
                          const SizedBox(
                            height: 30,
                          ),
                          const createEvent_components().text("   Event Charges",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          const createEvent_components().textField(
                              "Enter Event Charges", TextInputType.number, _eventChargesController),
                          const SizedBox(
                            height: 30,
                          ),
                          const createEvent_components()
                              .text("   Event Description",FontWeight.normal,Color(0xFF1D2A3A),18),
                          const SizedBox(
                            height: 10,
                          ),
                          const createEvent_components().textField(
                              "Enter Event Description", TextInputType.multiline, _eventDescriptionController),
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
                                      : const Text('Create Event'),
                                  onPressed: () async {
                                    if (isLoading) return;

                                    setState(() => isLoading = true);
                                    // User? user = await loginUsingEmailPassword(
                                    //     email: _emailController.text,
                                    //     password: _passwordController.text,
                                    //     context: context);
                                    // print(user);
                                    // if (user != null) {
                                    //   setState(() => isLoading = false);
                                    //   Navigator.of(context).pushReplacement(
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               dashboardScreen()));
                                    // } else {
                                    //   Fluttertoast.showToast(
                                    //       msg: "Enter Valid Email and Password",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.BOTTOM,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.red,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0);
                                    //   setState(() => isLoading = false);
                                    // }
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom)),
                  ],
                ),
              ),
          ),);
        }),


      ),
    );
  }
}
