import 'dart:convert';

import 'package:college_event_management/hms/event_parser.dart';
import 'package:college_event_management/showCampaigner/components/showCampaigner_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../dashboard/dashboardScreen.dart';
import '../../hms/event.dart';
import '../../size_config.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<CampaignerData> campaignerlist = [];
  var responseData;
  

  @override
  void initState() {
    campaignerlist.clear();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    if(campaignerlist.isEmpty){
      EventParser().getCampaignerDataList().then((value) {
        setState(() {
          campaignerlist=value;
        });
      });
    }
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: constraints.maxWidth < 500
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(30.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
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
                        child: showCampaigner_components().text("Show Campaigners", FontWeight.bold, Color(0xFF1D2A3A), 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: buildListWithoutScroll(campaignerlist),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildListWithoutScroll(List<CampaignerData> list) {
    return Column(
      children: list.map((e) => buildList(e)).toList(),
    );

  }

  Widget buildList(CampaignerData element) {
    return  Container(
        padding: EdgeInsets.only(left: 0, top: 5,bottom: 5, right: 0),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFD9D9D9)),
            child: ListTile(
                title:
                    ListTile(horizontalTitleGap: 15,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: CircleAvatar(
                        // radius: SizeConfig.screenWidth! * 0.05,
                        backgroundColor: Color(0xFF1D2A3A),
                        child: showCampaigner_components().text(element.name[0], FontWeight.bold, Colors.white, 25),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showCampaigner_components().text(element.name, FontWeight.bold, Color(0xFF1D2A3A), 20),
                          SizedBox(height: 5,),
                          showCampaigner_components().text(element.email, FontWeight.normal, Color(0xFF1D2A3A), 14),
                          SizedBox(height: 5,),
                          showCampaigner_components().text("Campaigner Token: " + element.campaigner_token, FontWeight.normal, Color(0xFF1D2A3A), 14)
                        ],
                      )
                    ),

            ),

    );
  }

  Future fetchData() async {
    final url =
        Uri.parse("https://convergence.uvpce.ac.in/C2K22/addCampaigner.php");
    final response = await http.get(url);

    responseData = json.decode(response.body);

    print(responseData);
  }
}
