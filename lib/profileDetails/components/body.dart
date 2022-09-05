import 'package:college_event_management/profileDetails/components/profile_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../size_config.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  List<String> list = <String>['Tech', 'Talk', 'Funny', 'Sports',"Logical", "Coding"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        reverse: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Align(
              alignment: Alignment(0, 0),
            ),
            Container(
              height: getHeight(50),
              width: getWidth(kIsWeb ? 250 : double.infinity),
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  left: 0, top: MediaQuery.of(context).size.height * 0.12),
              child: Row(
                children: <Widget>[
                  IconButton(
                      padding: EdgeInsets.only(bottom: 3, right: 8),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => dashboardScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                      )),
                  Text(
                    'Attendees Details ',
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
              width: getWidth(kIsWeb ? 250 : double.infinity),
              padding: EdgeInsets.only(left: 5, top: 40,  ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.cyan,
                  ),
                  SizedBox(width: 30,),
                  Column(
                    children: [
                      profile_components().text("Dhairya Soni", FontWeight.bold, Color(0xFF1D2A3A), 26),
                      profile_components().text("Ahmedabad", FontWeight.normal, Color(0xFF1D2A3A), 22)
                    ],
                  )

                ],
              ),
            ),

            Container(
              width: getWidth(kIsWeb ? 250 : double.infinity),
              padding: EdgeInsets.only(left: 10, top: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      profile_components().icon(Icons.mail),
                      profile_components().text("abc@gmail.com", FontWeight.normal, Color(0xFF1D2A3A), 20)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      profile_components().icon(Icons.phone),
                      profile_components().text("1234567890", FontWeight.normal, Color(0xFF1D2A3A), 20)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      profile_components().icon(Icons.whatsapp),
                      profile_components().text("1234567890", FontWeight.normal, Color(0xFF1D2A3A), 20)
                    ],
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),

            Container(
              width: getWidth(kIsWeb ? 250 : double.infinity),
              padding: EdgeInsets.only(left: 10, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profile_components().text("Attended Events", FontWeight.bold, Color(0xFF1D2A3A), 25),
                  SizedBox(height: 20,)
                ],
              ),
            ),

            Container(
              width: getWidth(kIsWeb ? 230 : double.infinity),
              child: Flexible(
                fit: FlexFit.loose,
                // height:,// card height
                // width: getWidth(kIsWeb ? 230 : double.infinity),
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
            ),

          ],
        ),
      ),
    );
  }

  Widget buildCard(int index, List list) => Container(
    padding: EdgeInsets.only(left: 30, top: 10,bottom: 10),
    // margin: EdgeInsets.only(left: 50, right: 50),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF1D2A3A), width: 1,),
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFd9d8d4)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profile_components().text(list[index], FontWeight.bold, Color(0xFF1D2A3A), 22),
        SizedBox(height: 5,),
        profile_components().text("29th Nov 2022", FontWeight.normal, Color(0xFF1D2A3A), 20),
        SizedBox(height:5,),
        Row(
          children: [
            profile_components().icon(Icons.location_on),
            profile_components().text("Ahmedabad", FontWeight.normal, Color(0xFF1D2A3A), 20),
          ],
        )
      ],
    ),
  );

}
