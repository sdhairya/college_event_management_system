import 'package:college_event_management/addFaculty/addFaculty.dart';
import 'package:college_event_management/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'createEvent/createEvent.dart';


class dashboardScreen extends StatefulWidget {

  const dashboardScreen({Key? key}) : super(key: key);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        child: Column(
          children: <Widget>[
            Container(
              height: getHeight(50),
              width: getWidth(kIsWeb ? 100 : double.infinity),
              padding: const EdgeInsets.only(top: 10),

              child: Column(
                children: [
                  Text("Welcome Dhairya," , style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D2A3A), fontSize: 25 ),),


                ],
              ),

            ),
            Container(
              transform: Matrix4.translationValues(-100, 0, 0),
              child: SizedBox(
                height: 220, // card height
                child: PageView.builder(
                  itemCount: 10,
                  controller: PageController(viewportFraction: 0.5),
                  onPageChanged: (int index) =>
                      setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scaleX: 1,
                      child: Card(
                        margin: EdgeInsets.only(left: 20),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Card ${i + 1}",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  buildHeader(BuildContext context){
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
          onTap: (){
            const dashboardScreen();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.event_note),
          title: const Text('Create Event'),
          onTap: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        createEvent()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle),
          title: const Text('Add Faculty'),
          onTap: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        addFaculty()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: (){},
        ),
      ],
    );
  }
}
