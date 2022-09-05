
import 'package:college_event_management/dashboard/dashboardScreen.dart';
import 'package:college_event_management/eventDetails/eventDetails.dart';
import 'package:flutter/material.dart';

import '../../createEvent/createEvent.dart';

class dashboard_components extends StatelessWidget {
  const dashboard_components({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Text text(String data, FontWeight fontWeight, Color color, double fontsize) {
    return Text(
      data,
      style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: fontsize),
    );
  }

  Container elevatedButton(bool _isClicked, String text, ) {
    return Container(
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () => _isClicked = true,
              style: ElevatedButton.styleFrom(
                primary: _isClicked ? Color(0xFF1D2A3A) : Color(0xFFF7F7F7),
                textStyle: TextStyle(fontSize: 20),
                shape: StadiumBorder(),
              ),
              child: Text(text)),
          SizedBox(width: 20,)
        ],
      ),
    );
  }

  TextFormField textFormField(String hint) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        hintText: hint,
      ),
    );
  }



}
