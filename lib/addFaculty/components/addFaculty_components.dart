
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

  Text text(String data, FontWeight fontWeight, Color color, double fontsize) {
    return Text(
      data,
      style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: fontsize),
    );
  }
  TextField textField(String hint, TextInputType type, TextEditingController _controller){
    return  TextField(
      keyboardType: type,
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        hintText: hint,
      ),
    );
  }



}
