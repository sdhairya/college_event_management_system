import 'package:flutter/material.dart';

class attendees_components extends StatelessWidget {
  const attendees_components({Key? key}) : super(key: key);

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

  Icon icon(IconData icon, double size){
    return Icon(icon,color: Color(0xFF1D2A3A),size: size,);
  }

}
