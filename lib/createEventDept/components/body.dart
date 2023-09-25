import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:college_event_management/dashboard/dashboardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../hms/event.dart';
import '../../hms/event_parser.dart';
import '../../main.dart';
import '../../size_config.dart';
import 'createEventDept_components.dart';
import 'package:http/http.dart' as http;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  File? _pickedimage;
  Uint8List webImage = Uint8List(8);

  TextEditingController _eventDeptnameController = TextEditingController();
  TextEditingController _eventDeptdescriptionController =
      TextEditingController();
  bool isLoading = false;
  var uuid = Uuid();
  var f;
  var imgPath;

  
  
  List<EventDeptData> eventlist = [];

  @override
  void initState() {
    eventlist.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: constraints.maxWidth < 500
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(30),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: Column(
                    children: <Widget>[
                      Column(
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
                                    padding: const EdgeInsets.only(
                                        bottom: 3, right: 3),
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
                            child: createEventDept_components().text(
                                "Create Department",
                                FontWeight.bold,
                                Color(0xFF1D2A3A),
                                30),
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
                                Container(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                        radius: SizeConfig.screenWidth! * 0.05,
                                        child: _pickedimage == null
                                            ? InkWell(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.camera_alt,
                                                        size: 50,
                                                        color: Colors.white),
                                                    Text(
                                                      "Choose Image",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    )
                                                  ],
                                                ),
                                                onTap: () {
                                                  _getFromGallery();
                                                },
                                              )
                                            : ClipOval(
                                                child: Image.memory(
                                                width: double.maxFinite,
                                                height: double.maxFinite,
                                                webImage,
                                                fit: BoxFit.fill,
                                              )))
                                ),
                                Visibility(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.edit),
                                              Text("Edit"),
                                            ],
                                          ),
                                          onPressed: () => _getFromGallery()),
                                    ),
                                    visible:
                                        _pickedimage == null ? false : true),
                                const createEventDept_components().text(
                                    '   Name',
                                    FontWeight.normal,
                                    Color(0xFF1D2A3A),
                                    16),
                                const SizedBox(
                                  height: 10,
                                ),
                                const createEventDept_components().textField(
                                    "Enter Department Name",
                                    TextInputType.text,
                                    _eventDeptnameController,
                                    1),
                                const SizedBox(
                                  height: 30,
                                ),
                                const createEventDept_components().text(
                                    '   Description',
                                    FontWeight.normal,
                                    Color(0xFF1D2A3A),
                                    16),
                                const SizedBox(
                                  height: 10,
                                ),
                                const createEventDept_components().textField(
                                    "Enter Department Description",
                                    TextInputType.multiline,
                                    _eventDeptdescriptionController,
                                    null),
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
                                        child: const Text('Create Department'),
                                        onPressed: () async {
                                          uploadLogo();
                                        },

                                     // onPressed: () async {
                                        //   if (isLoading) return;
                                        //   setState(() => isLoading = true);
                                        //
                                        //   if (_eventDeptnameController
                                        //           .text.isNotEmpty &&
                                        //       _eventDeptdescriptionController
                                        //           .text.isNotEmpty) {
                                        //     createDepart();
                                        //   } else {
                                        //     Fluttertoast.showToast(
                                        //         msg:
                                        //             "Any field can not be empty!!",
                                        //         toastLength: Toast.LENGTH_SHORT,
                                        //         gravity: ToastGravity.BOTTOM,
                                        //         timeInSecForIosWeb: 1,
                                        //         backgroundColor: Colors.red,
                                        //         textColor: Colors.white,
                                        //         fontSize: 16.0);
                                        //     setState(() => isLoading = false);
                                        //   }
                                        // },
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context)
                                      .viewInsets
                                      .bottom)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      f = await image.readAsBytes();
      setState(() {
        webImage = f;
        _pickedimage = File("a");
      });
    }

    //imgPath = image!.path;
    imgPath = File(image!.path);
    print("print $imgPath" );
  }

  void addEventDept() async {
    print("addEventDept");
    File file = File("assets/json/event_data.json");
    EventDeptData newEventDept = EventDeptData(
        name: _eventDeptnameController.text, logo: "", poster: "");
    eventlist.add(newEventDept);
    eventlist.map((event) => event.toJson());
    file.writeAsString(json.encode(eventlist));
    print("addEventDept");
  }

  Future createDepart() async {
    var departId = uuid.v4();

    try {
      final uri = "https://convergence.uvpce.ac.in/C2K22/addDepartment.php";

      var url = Uri.parse(
          "https://convergence.uvpce.ac.in/C2K22/addDepartment.php");
      var requestBody={
        "depatId":departId.toString(),
        "departName":_eventDeptnameController.text.toString(),
        "description":_eventDeptdescriptionController.text.toString(),
        "departLogo":webImage

      };

      http.Response response = await http.post(url,body: requestBody);
      // var res = await http.post(Uri.parse(uri),
      //     body: json.encode({
      //       "id": userId,
      //       "email": _addCampaigneremailController.text,
      //       "userName": _addCampaignernameController.text,
      //       "role": "campaigner",
      //       "password": "123456789"
      //     }),
      //     headers: {
      //       "Accept": "application/json",
      //       "Access-Control-Allow-Origin": "*"
      //     },
      //     encoding: Encoding.getByName('utf-8'));
      print(response.statusCode);
      //  var response = json.decode(res.body);

      //print(response["firebaseId"]);
      //print(response);
      if (response.statusCode == 404) {
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
        setState(() => isLoading = false);
      } else if (response.statusCode == 442) {
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
        setState(() => isLoading = false);
      } else if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Campaigner Added Successfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Department created Successfully!!");
        setState(() => isLoading = false);

        _eventDeptnameController.text = "";
        _eventDeptdescriptionController.text = "";

        // print(response);
      } else {
        print("some issue");
        Fluttertoast.showToast(
          msg: "Some issue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() => isLoading = false);
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
      setState(() => isLoading = false);
    }
  }

  Future uploadLogo() async{
    //print(f.path);

    var urlToInsertImage = Uri.parse(
        "https://convergence.uvpce.ac.in/C2K22/logoUpload.php");
    var request =
    http.MultipartRequest('POST', urlToInsertImage);
    request.files.add(await http.MultipartFile.fromPath(
        'logo',
       f
       // File(imgPath).readAsBytes().asStream()
    ));

    var response = await request.send();
    print(response);

  }
}
