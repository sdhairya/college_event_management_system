import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:college_event_management/payment/payment.dart';
import 'package:college_event_management/profileDetails/profileDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:college_event_management/dashboard/dashboardScreen.dart';
import 'package:college_event_management/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../campaignerDashBoard/campaignerDashBoard.dart';
import 'editProfile_components.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  File? _pickedimage;
  Uint8List webImage = Uint8List(8);
  List<String?> profilelist = [];

  var stuid;
  var role;
  var email;

  bool isLoading = false;
  bool isChecked = true;

  @override
  void initState() {
    fetchData();
    getData();
    super.initState();
  }

  TextEditingController _editProfileFirstNameController =
  TextEditingController();
  TextEditingController _editProfileLastNameController =
  TextEditingController();
  TextEditingController _editProfileMobileController = TextEditingController();
  TextEditingController _editProfileCampaignerController = TextEditingController();
  TextEditingController _editProfileEr_noController = TextEditingController();

  TextEditingController _editProfileSemController = TextEditingController();
  TextEditingController _editProfileBranchController = TextEditingController();
  TextEditingController _editProfileCollegeController = TextEditingController();
  TextEditingController _editProfileAddressController = TextEditingController();

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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          profileDetails()));
                            },
                            icon: Icon(
                              color: Color(0xFF1D2A3A),
                              Icons.arrow_back_ios_new_rounded,
                              size: 30,
                            )),
                        title: const Text(
                          'Edit Profile ',
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
                      const editProfile_components().textField(
                          "Enter First Name",
                          TextInputType.text,
                          _editProfileFirstNameController,
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
                      const editProfile_components().textField(
                          "Enter Last Name",
                          TextInputType.text,
                          _editProfileLastNameController,
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
                      const editProfile_components().textField(
                          "Enter Mobile Number",
                          TextInputType.phone,
                          _editProfileMobileController,
                          ""),
                      const SizedBox(
                        height: 30,
                      ),

                      const Text('    Enrollment No',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      const editProfile_components().textField(
                          "Enter Enrollment Number",
                          TextInputType.text,
                          _editProfileEr_noController,
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
                      const editProfile_components().textField(
                          "Enter Branch Name",
                          TextInputType.datetime,
                          _editProfileBranchController,
                          ""),
                      const SizedBox(
                        height: 30,
                      ),
                      role != "faculty" || role != "admin"
                          ? Wrap(children: [
                        const Text('    Semester',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1D2A3A))),
                        const SizedBox(
                          height: 10,
                        ),
                        const editProfile_components().textField(
                            "Enter Semester",
                            TextInputType.datetime,
                            _editProfileSemController,
                            "")
                      ])
                          : SizedBox(),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    College Name',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      const editProfile_components().textField(
                          "Enter College Name",
                          TextInputType.datetime,
                          _editProfileCollegeController,
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
                      const editProfile_components().textField(
                          "Enter Address",
                          TextInputType.datetime,
                          _editProfileAddressController,
                          ""),
                      const SizedBox(
                        height: 30,
                      ),
                      if (role== "user") ... [const Text('    Campaigner Token',
                  style: TextStyle(
                      fontSize: 16, color: Color(0xFF1D2A3A))),
              const SizedBox(
                height: 10,
              ),
              const editProfile_components().textField(
                  "Enter Campaigner Token",
                  TextInputType.number,
                  _editProfileCampaignerController,
                  ""),
              const SizedBox(
                height: 30,
              ),],
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
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.transparent,
                  )
                      : const Text('Update Profile'),
                  onPressed: isChecked
                      ? () async {
                    setState(() => isLoading = true);

                    // if (isLoading) return;
                    if (_editProfileFirstNameController
                        .text.isNotEmpty &&
                        _editProfileLastNameController
                            .text.isNotEmpty &&
                        _editProfileAddressController
                            .text.isNotEmpty &&
                        _editProfileSemController
                            .text.isNotEmpty &&
                        _editProfileMobileController
                            .text.isNotEmpty &&
                        _editProfileBranchController
                            .text.isNotEmpty &&
                        _editProfileCollegeController
                            .text.isNotEmpty) {
                      updateStuProfile();
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: Text('Error'),
                                content: Text(
                                    "All fields are required!!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                            context)
                                            .pop();
                                      },
                                      child: Text('Ok'))
                                ],
                              ));
                    }
                  }
                      : null,
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
            )
            );
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

  Future updateStuProfile() async {
    print(stuid);

    try {
      String uri = "https://convergence.uvpce.ac.in/C2K22/studentProfile.php";
      var res = await http.post(Uri.parse(uri),
          body: json.encode({
            "sid": stuid,
            "firstName": _editProfileFirstNameController.text.toString(),
            "lastName": _editProfileLastNameController.text.toString(),
            "email": email.toString(),
            "er_no": _editProfileEr_noController.text.toString(),
            "mobile": _editProfileMobileController.text,
            "college": _editProfileCollegeController.text.toString(),
            "branch": _editProfileBranchController.text.toString(),
            "sem": _editProfileSemController.text,
            "address": _editProfileAddressController.text.toString(),
            "flag": 1,
            "campaignerToken":role == "user" ? int.parse(_editProfileCampaignerController.text.toString()) : 0

          }),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          encoding: Encoding.getByName('utf-8'));
      print("okh");
      print(res.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (res.statusCode == 404) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
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
            builder: (context) =>
                AlertDialog(
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
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Status'),
                  content: Text("Profile Updated Successfully!!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (role == "campaigner") {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => campaignerDashBoard()));
                            setState(() => isLoading = false);
                          } else {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => dashboardScreen()));
                            setState(() => isLoading = false);
                          }
                        },
                        child: Text('Ok'))
                  ],
                ));


        setState(() => isLoading = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getData() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    _editProfileFirstNameController.text = data.getString("fname")!.toString();
    _editProfileLastNameController.text = data.getString("lname")!.toString();
    email = data.getString("email")!.toString();
    _editProfileCampaignerController.text = data.getString("campToken").toString();
    _editProfileEr_noController.text = data.getString("eno")!.toString();
    _editProfileMobileController.text = data.getString("mobile")!;
    _editProfileBranchController.text = data.getString("branch")!.toString();
    _editProfileSemController.text = data.getString("sem")!;
    _editProfileCollegeController.text = data.getString("college")!.toString();
    _editProfileAddressController.text = data.getString("address")!.toString();
  }

  Future fetchData() async {
    SharedPreferences studata = await SharedPreferences.getInstance();
    role = studata.getString("role");
    stuid = studata.getString("stuid");
  }
}