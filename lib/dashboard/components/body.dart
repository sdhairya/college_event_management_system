import 'package:college_event_management/addCoordinator/components/body.dart';
import 'package:college_event_management/createProfile/createProfile.dart';
import 'package:college_event_management/profileDetails/profileDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../addFaculty/addFaculty.dart';
import '../../createEvent/createEvent.dart';
import '../../eventDetails/eventDetails.dart';
import '../../events/events.dart';
import '../../size_config.dart';
import '../dashboardScreen.dart';
import 'dashboard_components.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  List<String> list = <String>['Tech', 'Talk', 'Funny', 'Sports',"Logical", "Coding"];


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var i;
    return Scaffold(
        appBar: AppBar(backgroundColor: Color(0xFF1D2A3A)),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Align(
                alignment: Alignment(0, 0),
              ),
              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    dashboard_components().text("Welcome Dhairya,", FontWeight.bold, const Color(0xFF1D2A3A), 25),
                    SizedBox(height: 20),


                  ],
                ),
              ),

              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dashboard_components().text("Find Events,", FontWeight.normal, const Color(0xFF1D2A3A), 16),
                      SizedBox(height: 10,)
                    ],
                  )
              ),

              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: getWidth(kIsWeb ? 225 : MediaQuery.of(context).size.width * 0.7),
                      child: dashboard_components().textFormField("Search"),
                    ),
                    SizedBox(
                      width: getWidth(3),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary: Color(0xFF1D2A3A),
                          onSurface: Color(0xFF1D2A3A),
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 20, right: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: StadiumBorder(),
                          enableFeedback: true,
                        ),
                        child: IconButton(
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => createEvent()));
                            },
                            icon: Icon(
                              Icons.filter_list_rounded,
                              size: 30,
                            )),
                        onPressed: () {})
                  ],
                ),
              ),

              SizedBox(height: 40,),

              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: dashboard_components().text("Categories", FontWeight.w300, Color(0xFF1D2A3A), 23),
              ),


              SizedBox(height: 20,),

              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                    child: Row(
                    children: [
                      for (i in list) dashboard_components().elevatedButton(true, i.toString()),
                    ],
                  ),
                ) ,

              ),

              SizedBox(height: 40,),

              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: dashboard_components().text("Events", FontWeight.w300, Color(0xFF1D2A3A), 23),
              ),

              Container(
                child: SizedBox(
                  height: 320, // card height
                  width: getWidth(kIsWeb ? 250 : double.infinity),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(12),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return buildCard(index,list: list);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 30);
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
    );
  }

  buildMenuItems(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.home_filled),
          title: const Text('Home'),
          onTap: () {
            const dashboardScreen();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.event_note),
          title: const Text('Create Event'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => createEvent()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle),
          title: const Text('Add Faculty'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => addFaculty()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
        // ListTile(
        //   leading: const Icon(Icons.settings),
        //   title: const Text('Profile'),
        //   onTap: () {
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => profileDetails()));
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Create Profile'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => createProfile()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('My Events'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => events()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Add Coordinator'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => addCoordinator()));
          },
        ),
      ],
    );
  }

  Widget buildCard(int index,{required List list}) => Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      width: 250,
      height: 320,
      child: InkWell(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: 170,
                width: 250,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("29 Nov, 2022"),
                      SizedBox(
                        width: 5,
                      ),
                      Text("12:00 PM"),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(list[index],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, size: 20),
                      Text("Ahmedabad")
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: 100,
              height: 30,
              child: ElevatedButton(
                  onPressed: (){ createEvent();},
                  child: const Text('Rs. 200'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1D2A3A),
                    onSurface: Color(0xFF1D2A3A),
                    textStyle: TextStyle(fontSize: 20),
                    shape: StadiumBorder(),
                  )),
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => eventDetails(l: list[index],)));
        },
      )

  );

}
