import 'package:college_event_management/addCoordinator/components/body.dart';
import 'package:college_event_management/createProfile/createProfile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../addFaculty/addFaculty.dart';
import '../../createEvent/createEvent.dart';
import '../../eventDetails/eventDetails.dart';
import '../../events/events.dart';
import '../../size_config.dart';
import '../dashboardScreen.dart';
import 'dashboard_components.dart';
import 'package:college_event_management/eventData.dart' as data;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<String> list = <String>[
    "Infocrafts",
    "MechMechato",
    "MathMagix",
    "PetroX",
    "Biotechnica",
    "Civesta",
    "ElectaBuzz",
    "Maritech",
    "GeneralEvents",

  ];

  Map<String,List> event={};



  List<List> Infocrafts = <List>[
    [
      "Project Presentation",
      "Tech",
      "9:30 AM - 2:30 PM",
      "C-D",
      [
        ["Prof. Rachana Modi", "rvm02@ganpatuniversity.ac.in", "9825015094"],
        ["Prof. Satish Maurya", "skm02@ganpatuniversity.ac.in", "9196116503"],
        ["Prof. Dhiren Prajapati", "dtp01@ganpatuniversity.ac.in", "7016050788"]
      ],
      [
        [
          "Ayushi Gorai",
          "ayushigorai19@gnu.ac.in",
          "8141784691",
          "Sem-7 CE",
          "19012011014",
        ],
        [
          "Vishnu Tak",
          "vishnutak08@gmail.com",
          "6378133765",
          "Sem-5 CE",
          "20012011181",
        ],
      ],
      "The project work constitutes a major component in most of the professional programmers. In this event the project should be related to the field of Computer science / Information Technology. Participants of this event are expected to demonstrate some real life projects. These projects may be carried out in some industry, research and development laboratories, "
          "educational institutions or software companies by the participant. It is suggested that the project is to be chosen which should have some direct relevance in day-to-day activities. Participants have to show the actual working of their project.",
      "1. Each team/member will be given 15 minutes to demonstrate their project work (10 minutes for presentation and 5 minutes for question and answer). \n\n2. Maximum 3 students per team/group are allowed.\n\n3. Any student from any college and from any branch is allowed to participate but the project should be oriented to computer technology or it may be using some sort of computer programming.\n\n4. Resources are to be managed by the team.\n\n5. Testing of the project will not be permitted on the day of the event.\n\n6. Event coordinators will not be responsible for any kind of failure.\n\n7. The decision of the judges would be final and binding.",
      "1. Presentation, skills and strategies.\n2. Question answer round.\n3. Depth knowledge of the Project/topic\n4. Content and selection of projects/topics\n5. Marks will be given based on project complexity and team members.\n6. Acceptability\n7. Feasibility"
    ],

  ];
@override
  void initState() {
    event.addAll({
      list[0]:data.Infocrafts,
      list[1]:data.MechMechato,
      list[2]:data.MathMagix,
      list[3]:data.PetroX,
      list[4]:data.Biotechnica,
      list[5]:data.Civesta,
      list[6]:data.ElectaBuzz,
      list[7]:data.Maritech,
      list[8]:data.GeneralEvents
    });
    super.initState();
  }

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
                    dashboard_components().text("Welcome Dhairya,",
                        FontWeight.bold, const Color(0xFF1D2A3A), 25),
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
                      dashboard_components().text("",
                          FontWeight.normal, const Color(0xFF1D2A3A), 16),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
              /*Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: getWidth(kIsWeb
                          ? 225
                          : MediaQuery.of(context).size.width * 0.7),
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
              ),*/
              SizedBox(
                height: 40,
              ),
              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: dashboard_components()
                    .text("Categories", FontWeight.w300, Color(0xFF1D2A3A), 23),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (i in list)
                        dashboard_components()
                            .elevatedButton(true, i.toString()),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              // Container(
              //   width: getWidth(kIsWeb ? 250 : double.infinity),
              //   child: dashboard_components()
              //       .text("Infocrafts", FontWeight.w300, Color(0xFF1D2A3A), 23),
              // ),
              // Container(
              //   child: SizedBox(
              //     height: 320, // card height
              //     width: getWidth(kIsWeb ? 250 : double.infinity),
              //     child: ListView.separated(
              //         scrollDirection: Axis.horizontal,
              //         padding: const EdgeInsets.all(12),
              //         itemCount: data.Infocrafts.length,
              //         itemBuilder: (context, index) {
              //           return buildCard(index, list: data.Infocrafts);
              //         },
              //         separatorBuilder: (context, index) {
              //           return const SizedBox(width: 30);
              //         }),
              //   ),
              // ),

              Container(
                width: getWidth(kIsWeb ? 250 : double.infinity),
                child:
                buildCategoriesListWithoutScroll(list)


                ),


            ],
          ),
        ));
  }
  Widget buildWrapProductList(List eventListData)
  {
    return
      Flexible(
          child:
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:Wrap(
                alignment: WrapAlignment.spaceEvenly,
                  spacing: getWidth(20),
                  runSpacing: getHeight(20),
                  direction: Axis.horizontal,
                  children: eventListData.map((e) {
                    return buildCard(e);
                  }).toList(),
              )
          )
      )
    ;
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
  Widget buildCategoriesListWithoutScroll(List<String> list) {
    return
      Column(children:list.map((e) => buildView(e,event[e]!)).toList()
      )
    ;
  }
  Widget buildView(String categoryName,List eventListData) => Container(
    width: getWidth(kIsWeb ? 250 : double.infinity),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          width: getWidth(kIsWeb ? 250 : double.infinity),
          child: dashboard_components()
              .text(categoryName, FontWeight.w300, Color(0xFF1D2A3A), 23),
        ),
        Container(
          child:
          /*SizedBox(
            height: 320, // card height
            width: getWidth(kIsWeb ? 250 : double.infinity),
            child:*/
            buildWrapProductList(eventListData)
            /*ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                itemCount: eventListData.length,
                itemBuilder: (context, index1) {
                  return buildCard(eventListData[index1]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 30);
                }),*/
          //),
        ),
      ],
    ),
  );

  Widget buildCard(element) => Container(
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
                child: Image.asset('assets/event1.png'),
                height: 170,
                width: 250,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Text("29 Nov, 2022"),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      Text(element[2]),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(element[0].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 120,
              height: 30,
              child: ElevatedButton(
                  onPressed: () {
                    createEvent();
                  },
                  child: Text("Register"),
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => eventDetails(
                    inputList: element,
                  )));
        },
      ));
}
