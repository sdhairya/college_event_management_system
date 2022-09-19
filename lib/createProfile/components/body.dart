import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:college_event_management/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:college_event_management/dashboard/dashboardScreen.dart';
import 'package:college_event_management/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'createProfile_components.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  File? _pickedimage;
  Uint8List webImage = Uint8List(8);
  var stuid;

  bool isLoading = false;
  bool isChecked = true;
  TextEditingController _createProfileFirstNameController =
      TextEditingController();
  TextEditingController _createProfileLastNameController =
      TextEditingController();
  TextEditingController _createProfileMobileController =
      TextEditingController();
  TextEditingController _createProfileEmailController = TextEditingController();
  TextEditingController _createProfileSemController = TextEditingController();
  TextEditingController _createProfileBranchController =
      TextEditingController();
  TextEditingController _createProfileCollegeController =
      TextEditingController();
  TextEditingController _createProfileAddressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          reverse: false,
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: constraints.maxWidth < 500
                    ? EdgeInsets.zero
                    : const EdgeInsets.all(30.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 25.0),
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment(0, 0),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: ListTile(
                              leading: IconButton(
                                  padding: const EdgeInsets.only(
                                      bottom: 3, right: 8),
                                  onPressed: () {
                                    //
                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    //     builder: (context) => dashboardScreen()));
                                  },
                                  icon: Icon(
                                    color: Color(0xFF1D2A3A),
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 30,
                                  )),
                              title: const Text(
                                'Create Profile ',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1D2A3A)),
                              ),
                            )),
                        // Container(
                        //     margin: EdgeInsets.only(
                        //         left: 0, top: MediaQuery.of(context).size.height * 0.12),
                        //     child: CircleAvatar(
                        //         radius: 80,
                        //         child: _pickedimage == null
                        //             ? null
                        //             : ClipOval(
                        //
                        //             child: kIsWeb
                        //                 ? Image.memory(
                        //               width: double.maxFinite,
                        //               height: double.maxFinite,
                        //               webImage,
                        //               fit: BoxFit.fill,
                        //             )
                        //                 : Image.file(
                        //               width: double.maxFinite,
                        //               height: double.maxFinite,
                        //               _pickedimage!,
                        //               fit: BoxFit.fill,
                        //             )))
                        // ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   child: TextButton(
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: const [
                        //           Icon(Icons.edit),
                        //           Text("Edit"),
                        //         ],
                        //       ),
                        //       onPressed: () => showDialog(
                        //           context: context,
                        //           builder: (context) => Dialog(
                        //               child: Container(
                        //                 width: double.minPositive,
                        //                 padding: EdgeInsets.all(20),
                        //                 height: 150,
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.center,
                        //                   children: [
                        //                     ElevatedButton(
                        //                         style: ElevatedButton.styleFrom(
                        //                           shape: CircleBorder(),
                        //                           enableFeedback: true,
                        //                           alignment: Alignment.center,
                        //                           primary: Colors.white70,
                        //                           padding: EdgeInsets.only(top: 20,left: 20,right: 20, bottom: 15),
                        //                         ),
                        //                         onPressed: () {
                        //                           _getFromGallery();
                        //                           Navigator.pop(context);
                        //                         },
                        //                         child: Column(
                        //                           children: [
                        //                             Icon(Icons.image,size: 50, color: Colors.deepOrange),
                        //                             Text("Gallery",style: TextStyle(fontSize: 16, color: Colors.black),)
                        //                           ],
                        //                         )),
                        //
                        //                     Visibility(child: SizedBox(width: 30,), visible: kIsWeb ? false : true,),
                        //                     Visibility(child: ElevatedButton(
                        //
                        //                         style: ElevatedButton.styleFrom(
                        //                           shape: CircleBorder(),
                        //                           enableFeedback: true,
                        //                           alignment: Alignment.center,
                        //                           primary: Colors.white70,
                        //                           padding: EdgeInsets.only(top: 20,left: 20,right: 20, bottom: 15),
                        //                         ),
                        //                         onPressed: () {
                        //                           _getFromCamera();
                        //                           Navigator.pop(context);
                        //                         },
                        //                         child: Column(
                        //                           children: [
                        //                             Icon(Icons.camera_alt,size: 50, color: Colors.deepOrange),
                        //                             Text("Camera", style: TextStyle(color: Colors.black,fontSize: 16),)
                        //                           ],
                        //                         )), visible: kIsWeb ? false : true,)
                        //                   ],
                        //                 ),
                        //               )))),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('   First Name',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter First Name",
                                  TextInputType.text,
                                  _createProfileFirstNameController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text('    Last Name',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter Last Name",
                                  TextInputType.text,
                                  _createProfileLastNameController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text('    Mobile Number',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter Mobile Number",
                                  TextInputType.phone,
                                  _createProfileMobileController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text('    Email',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter Email",
                                  TextInputType.emailAddress,
                                  _createProfileEmailController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text('    Branch',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter Branch Name",
                                  TextInputType.datetime,
                                  _createProfileBranchController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text('    Semester',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter Semester",
                                  TextInputType.datetime,
                                  _createProfileSemController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text('    College Name',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter College Name",
                                  TextInputType.datetime,
                                  _createProfileCollegeController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text('    Address',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF1D2A3A))),
                              const SizedBox(
                                height: 10,
                              ),
                              const createProfile_components().textField(
                                  "Enter Address",
                                  TextInputType.datetime,
                                  _createProfileAddressController,
                                  ""),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF1D2A3A),
                                    onSurface: const Color(0xFF1D2A3A),
                                    padding: const EdgeInsets.all(3),
                                    textStyle: const TextStyle(fontSize: 20),
                                    minimumSize: const Size.fromHeight(50),
                                    shape: const StadiumBorder(),
                                    enableFeedback: true,
                                  ),
                                  onPressed: isChecked
                                      ? () async {
                                          if (isLoading) return;
                                          createStuProfile();

                                          // if (_signUpEmailController
                                          //     .text.isNotEmpty) {
                                          //   if (_signUpPasswordController.text ==
                                          //       _signUpConfrimPasswordController
                                          //           .text) {
                                          //     signUp();
                                          //   } else {
                                          //     Fluttertoast.showToast(
                                          //         msg:
                                          //         "Confirm password don't match!!",
                                          //         toastLength: Toast.LENGTH_SHORT,
                                          //         gravity: ToastGravity.BOTTOM,
                                          //         timeInSecForIosWeb: 1,
                                          //         backgroundColor: Colors.red,
                                          //         textColor: Colors.white,
                                          //         fontSize: 16.0);
                                          //     setState(() => isLoading = false);
                                          //   }
                                          // } else {
                                          //   Fluttertoast.showToast(
                                          //       msg: "Any field can not be empty!!",
                                          //       toastLength: Toast.LENGTH_SHORT,
                                          //       gravity: ToastGravity.BOTTOM,
                                          //       timeInSecForIosWeb: 1,
                                          //       backgroundColor: Colors.red,
                                          //       textColor: Colors.white,
                                          //       fontSize: 16.0);
                                          //   setState(() => isLoading = false);
                                          // }
                                        }
                                      : null,
                                  child: const Text('Create Profile'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom)),
                      ],
                    ),
                  ),
                ));
          })),
    );
  }

  _getFromGallery() async {
    if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      // PickedFile? image = await ImagePicker().getImage(
      //   source: ImageSource.gallery,
      //   maxWidth: 1800,
      //   maxHeight: 1800,
      // );
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedimage = File("a");
        });
      }
      print(webImage);
    } else {
      // final ImagePicker _picker = ImagePicker();
      // XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      PickedFile? image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        setState(() {
          _pickedimage = File(image.path);
        });
      }
      print(_pickedimage);
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedimage = File(pickedFile.path);
      });
    }
    print(_pickedimage);
  }

  Future createStuProfile() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    stuid = studata.getString("stuid");

    print(stuid);

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/studentProfile.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "sid": stuid,
            "firstName": _createProfileFirstNameController.text,
            "lastName": _createProfileLastNameController.text,
            "email": _createProfileEmailController.text,
            "mobile": _createProfileMobileController.text,
            "college": _createProfileCollegeController.text,
            "branch": _createProfileBranchController.text,
            "sem": _createProfileSemController.text,
            "address": _createProfileAddressController.text,
            "flag": 1
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
                  content: Text("User Not Found !!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
        setState(() => isLoading = false);
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
                        child: Text('Ok'))
                  ],
                ));
        setState(() => isLoading = false);
      } else if (res.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future checkPayment() async {
    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/checkPayment.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({"id": stuid}),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      var temp = res.statusCode;
      print("paymentCode  $temp");
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => payment()));

        setState(() => isLoading = false);
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
                        child: Text('Ok'))
                  ],
                ));
        setState(() => isLoading = false);
      } else if (res.statusCode == 200) {
        var response = json.decode(res.body);

        print(response["sid"]);
        print(response);
        if (response["sid"] == stuid) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => dashboardScreen()));
          setState(() => isLoading = false);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
