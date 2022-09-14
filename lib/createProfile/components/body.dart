import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:college_event_management/dashboard/dashboardScreen.dart';
import 'package:college_event_management/size_config.dart';
import 'createProfile_components.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  File? _pickedimage;
  Uint8List webImage = Uint8List(8);

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
  TextEditingController _createProfileBranchController = TextEditingController();
  TextEditingController _createProfileCollegeController = TextEditingController();
  TextEditingController _createProfileAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: Column(
          children: [
            const Align(
              alignment: Alignment(0, 0),
            ),
            Container(
              height: getHeight(50),
              width: getWidth(kIsWeb ? 110 : double.infinity),
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  left: 0, top: MediaQuery.of(context).size.height * 0.12),
              child: Row(
                children: <Widget>[
                  IconButton(
                      padding: EdgeInsets.only(bottom: 3, right: 8),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => dashboardScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                      )),
                  Text(
                    'Create Profile ',
                    style: TextStyle(
                        fontSize: 35,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2A3A)),
                  )
                ],
              ),
            ),
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
                  const Text('   First Name',
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
                  const SizedBox(
                    height: 10,
                  ),
                  const createProfile_components().textField("Enter Last Name",
                      TextInputType.text, _createProfileLastNameController, ""),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('    Mobile Number',
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A))),
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
                          child: const Text('Create Profile'),
                          onPressed: isChecked
                              ? () async {
                                  if (isLoading) return;

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
}
