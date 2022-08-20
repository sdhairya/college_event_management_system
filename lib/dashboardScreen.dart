import 'package:college_event_management/addFaculty.dart';
import 'package:flutter/material.dart';
import 'createEvent.dart';

class dashboardScreen extends StatefulWidget {

  const dashboardScreen({Key? key}) : super(key: key);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  @override
  Widget build(BuildContext context) {
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

      body: Center(
        child: Text( "Welcome to Dashboard!!",),
      ),
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
