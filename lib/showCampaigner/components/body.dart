import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  @override
  void initState() {
    fetchData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future fetchData() async{

    final url = Uri.parse("https://convergence.uvpce.ac.in/C2K22/addCampaigner.php");
    final response = await http.get(url);

    var responseData = json.decode(response.body);

    print(responseData);

  }
}
