import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../eventDetails/eventDetails.dart';
import '../../size_config.dart';
import 'events_components.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<String> list = <String>['Infocrats', 'Mech-Mechato', 'MATHMAGIX', 'PetroX',"Biotechnical", "CIVESTA","Electabuzz","General Events","MARITECH"];
  // List<String> infocrats =  <String>["PROJECT PRESENTATION",
  //   "PAPER PRESENTATION",
  //   "POSTER PRESENTATION",
  //   "CRYPT YOUR  MIND",
  //   "WEB INSIDE",
  //   "CODE CONNECTION",
  //   "QUIZZARD"];



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
                            builder: (context) => dashboardScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                      )),
                  Text(
                    'My Events ',
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
        padding: EdgeInsets.only(left: 30, top: 10,bottom: 10, right: 30),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    events_components().text(list[index], FontWeight.bold, Color(0xFF1D2A3A), 20),
                    SizedBox(height: 5,),
                    events_components().text("29th Nov 2022", FontWeight.normal, Color(0xFF1D2A3A), 14),
                    SizedBox(height:5,),
                    Row(
                      children: [
                        events_components().icon(Icons.location_on),
                        events_components().text("Ahmedabad", FontWeight.normal, Color(0xFF1D2A3A), 14),
                      ],
                    )
                  ],
                ),
                Icon(Icons.arrow_circle_right,size: 30,color: Color(0xFF1D2A3A),)
              ],
            )
            
            


          ],
        ),
        onTap: (){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => eventDetails(l: list[index],)));
        },)
      );
}
