import 'package:flutter/material.dart';

var validator;
TextEditingController _signUpPasswordController = TextEditingController();

class editProfile_components extends StatefulWidget {
  const editProfile_components({Key? key}) : super(key: key);

  @override
  State<editProfile_components> createState() => _editProfile_componentsState();




  Text text(String label) {
    return Text(label,
        style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A)));
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
      // initialValue: hint,
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

class _editProfile_componentsState extends State<editProfile_components> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
