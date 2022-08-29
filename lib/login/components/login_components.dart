import 'package:flutter/material.dart';

class login_components extends StatefulWidget {
  const login_components({Key? key}) : super(key: key);

  @override
  State<login_components> createState() => _login_componentsState();



  // textField_pass(String hint, TextInputType type,
  //     TextEditingController controller) {
  //   return TextFormField(
  //     obscureText: true,
  //     controller: controller,
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  //         hintText: hint,
  //         suffixIcon: InkWell(
  //           child: Icon(true ? Icons.visibility : Icons.visibility_off),
  //           onTap: () {
  //             isobscure=!isobscure;
  //           },
  //         )),
  //     keyboardType: type,
  //   );
  // }

  Text text(String label) {
    return Text(label,
        style: TextStyle(fontSize: 16, color: Color(0xFF1D2A3A)));
  }

  TextField textField(String hint, TextInputType type, TextEditingController controller) {
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

class _login_componentsState extends State<login_components> {
  late bool _isobscure = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void togglePasswordVisibility() => setState(() {
    _isobscure = !_isobscure;
  });
}
