import 'dart:io';
import 'dart:typed_data';

import 'package:college_event_management/profileDetails/profileDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../eventDetails/eventDetails.dart';
import '../../size_config.dart';
import 'attendees_components.dart';

class body extends StatefulWidget {
  final List previousScreen_data;
  const body({Key? key, required this.previousScreen_data}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  File? _pickedimage;
  Uint8List webImage = Uint8List(8);
  List<String> list = <String>['Dhairya', 'Hardik', 'Rohan', 'Rahul',"Veer", "Om"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: false,
        child: Column(
          children: [
            const Align(
              alignment: Alignment(0, 0),
            ),
            Container(
              height: getHeight(50),
              width: getWidth(kIsWeb ? 250 : double.infinity),
              margin: EdgeInsets.only(
                  left: 20, top: MediaQuery.of(context).size.height * 0.12),
              child: Row(
                children: <Widget>[
                  IconButton(
                      padding: EdgeInsets.only(bottom: 3, right: 8),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => eventDetails(l: widget.previousScreen_data)));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                      )),
                  Text(
                    'Attendees ',
                    style: TextStyle(
                        fontSize: 35,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2A3A)),
                  )
                ],
              ),
            ),
            Container(
              // height: 1000,
              width: getWidth(kIsWeb ? 230 : double.infinity),
              padding: EdgeInsets.all(0),
              child: Flexible(
                fit: FlexFit.loose,
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return buildCard(index, list);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10,);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index, List list) => Container(
      padding: EdgeInsets.only(left: 15, top: 10,bottom: 10, right: 20),
      // margin: EdgeInsets.only(left: 50, right: 50),
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFD9D9D9)),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 40,
                          child: _pickedimage == null
                              ? null
                              : ClipOval(

                              child: kIsWeb
                                  ? Image.memory(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                webImage,
                                fit: BoxFit.fill,
                              )
                                  : Image.file(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                _pickedimage!,
                                fit: BoxFit.fill,
                              ))),
                      SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          attendees_components().text(list[index], FontWeight.bold, Color(0xFF1D2A3A), 26),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              attendees_components().icon(Icons.mail,25),
                              SizedBox(width: 5,),
                              attendees_components().text("EMAIL", FontWeight.normal, Color(0xFF1D2A3A), 18),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                Icon(Icons.arrow_circle_right,size: 30,color: Color(0xFF1D2A3A),)
              ],
            )




          ],
        ),
        onTap: (){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => profileDetails(name: list[index],)));
        },)
  );
}
