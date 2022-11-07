import 'package:flutter/material.dart';

import '../../profileDetails/profileDetails.dart';
import '../campaignerDashBoard.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1D2A3A),
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildMenuItems(context),
            ],
          ),
        ),
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
            const campaignerDashBoard();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('My Profile'),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => profileDetails(
                )));
          },
        ),

      ],
    );
  }


}
