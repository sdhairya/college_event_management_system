import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:college_event_management/eventsList/components/eventList_components.dart';

import '../../dashboard/dashboardScreen.dart';
import '../../eventDetails/eventDetails.dart';
import '../../hms/event.dart';
import '../../size_config.dart';

class body extends StatefulWidget {
  final List<EventData> eventListData;
  final String categoryName, logo;
  const body({Key? key, required this.eventListData, required this.categoryName, required this.logo}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<EventDeptData> eventlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedContainer(duration: const Duration(milliseconds: 500),
              padding: constraints.maxWidth < 500 ? EdgeInsets.zero : const EdgeInsets.all(30.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
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
                                padding: const EdgeInsets.only(
                                    bottom: 3, right: 3),
                                onPressed: () {
                                  //
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => dashboardScreen()));
                                },
                                icon: Icon(
                                  color: Color(0xFF1D2A3A),
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 25,
                                )),
                            title: const Text(
                              'Dashboard ',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1D2A3A)),
                            ),
                          )

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: kIsWeb ? SizeConfig.screenWidth! * 0.05 : SizeConfig.screenWidth! * 0.15,
                              child: ClipOval(
                                child: Image.asset(widget.logo, fit: BoxFit.fill, height: double.maxFinite, width: double.maxFinite,),
                              ),

                            ),
                            eventsList_components()
                                .text(
                                widget.categoryName, FontWeight.w300, Color(0xFF1D2A3A),
                                23),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: buildListWithoutScroll(widget.eventListData),
                      )
                    ],
                  ),
                ),
              ),);
          }),
        ),
      )
      ,

    );
  }

  Widget buildListWithoutScroll(List<EventData> list) {
    return Column(
      children: list.map((e) => buildList(e)).toList(),
    );

  }

  Widget buildList(EventData element) {
    return  Container(
        padding: EdgeInsets.only(left: 5, top: 10,bottom: 5, right: 0),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFD9D9D9)),
        child: InkWell(
          child: ListTile(
            title:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      eventsList_components().text(element.name, FontWeight.bold, Color(0xFF1D2A3A), 20),
                      SizedBox(height: 5,),
                      eventsList_components().text(element.date, FontWeight.normal, Color(0xFF1D2A3A), 14),
                      ListTile(horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: eventsList_components().icon(Icons.location_on),
                          title: eventsList_components().text(element.venue, FontWeight.normal, Color(0xFF1D2A3A), 14),

                      )
                    ],
                  ),
                  trailing: Icon(Icons.arrow_circle_right,size: 30,color: Color(0xFF1D2A3A),)

              ),





          onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => eventDetails(inputList: element, deptName: widget.categoryName,))).then((value) => null);

          // Replacement(
          //     MaterialPageRoute(builder: (context) => eventDetails(inputList: element)));
        }
        )
    );
  }
}
