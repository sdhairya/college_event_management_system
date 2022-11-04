import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class createEventDept_components extends StatelessWidget {
  const createEventDept_components({Key? key}) : super(key: key);

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

  TextFormField textField(String hint, TextInputType type, TextEditingController controller) {
    // if(valid=="password"){
    //   validator=_requiredValidator;
    // }
    // else if(valid=="confirmpassword"){
    //   validator=_confirmPasswordValidator;
    // }
    return  TextFormField(
      keyboardType: type,
      controller: controller,
      // validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        hintText: hint,
      ),
    );
  }

}
