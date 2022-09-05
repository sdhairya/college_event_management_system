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
  List<String> list = <String>['Tech', 'Talk', 'Funny', 'Sports',"Logical", "Coding"];

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
              padding: EdgeInsets.all(20),
              child: Flexible(
                fit: FlexFit.loose,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, int index) {
                    return buildCard(index, list);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 20 / 14,
                      crossAxisCount: kIsWeb ? 3 : 1,
                      crossAxisSpacing: 50,
                      mainAxisSpacing: 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index, List list) => Container(
        // padding: EdgeInsets.only(left: 10, top: 10,bottom: 10, right: 10),
        // margin: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF1D2A3A),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFd9d8d4)),
        child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.blueGrey),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    events_components().text("29th Nov 2022", FontWeight.normal, Color(0xFF1D2A3A), 14),
                    SizedBox(height:5,),
                    events_components().text(list[index], FontWeight.bold, Color(0xFF1D2A3A), 20),
                    SizedBox(height: 5,),

                    Row(
                      children: [
                        events_components().icon(Icons.location_on),
                        events_components().text("Ahmedabad", FontWeight.normal, Color(0xFF1D2A3A), 14),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        onTap: (){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => eventDetails(l: list[index],)));
        },)
      );
}
