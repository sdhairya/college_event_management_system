import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class createEvent_components extends StatelessWidget {
  const createEvent_components({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Text text(String label){
    return Text(label,
        style: TextStyle(
            fontSize: 16, color: Color(0xFF1D2A3A)));
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
