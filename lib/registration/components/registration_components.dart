import 'package:flutter/material.dart';

var validator;
TextEditingController _signUpPasswordController = TextEditingController();

class registration_components extends StatefulWidget {
  const registration_components({Key? key}) : super(key: key);

  @override
  State<registration_components> createState() => _registration_componentsState();




  Text text(String data, FontWeight fontWeight, Color color, double fontsize) {
    return Text(
      data,
      style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: fontsize),
    );
  }

  TextFormField textField(String hint, TextInputType type, TextEditingController controller, String valid) {
    if(valid=="password"){
      validator=_requiredValidator;
    }
    else if(valid=="confirmpassword"){
      validator=_confirmPasswordValidator;
    }
    return  TextFormField(
      keyboardType: type,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        hintText: hint,
      ),
    );
  }

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This feild is required";
    }
    return null;
  }

  String? _confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return "This feild is required";
    }

    if (_signUpPasswordController.text != confirmPasswordText) {
      return "Passwords don't match";
    }
    return null;
  }



}

class _registration_componentsState extends State<registration_components> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
