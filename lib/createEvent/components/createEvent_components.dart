import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class createEvent_components extends StatelessWidget {
  const createEvent_components({Key? key}) : super(key: key);

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

  TextField textField(String hint, TextInputType type, TextEditingController controller){
    return  TextField(
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        hintText: hint,
      ),
    );
  }

}
