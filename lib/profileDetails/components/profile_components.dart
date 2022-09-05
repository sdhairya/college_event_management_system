import 'package:flutter/material.dart';

class profile_components extends StatelessWidget {
  const profile_components({Key? key}) : super(key: key);

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

  Icon icon(IconData icon){
    return Icon(icon);
  }

}
