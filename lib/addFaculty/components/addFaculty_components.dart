import 'dart:js';

import 'package:flutter/material.dart';

class addFaculty_components extends StatelessWidget {
  const addFaculty_components({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();

    Future dialog(){
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration up failed!'),
            content: Text("abcd"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          ));
    }

  }

  Text text(String label){
    return Text(label,
        style: TextStyle(
            fontSize: 16, color: Color(0xFF1D2A3A)));
  }

  TextField textField(String hint, TextInputType type){
    return  TextField(
      keyboardType: type,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        hintText: hint,
      ),
    );
  }



}
