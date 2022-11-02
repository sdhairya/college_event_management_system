import 'dart:async';




import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../addFaculty/components/body.dart';


import 'package:flutter/src/widgets/framework.dart';

class addCampaigner extends StatefulWidget {
  const addCampaigner({Key? key}) : super(key: key);

  @override
  State<addCampaigner> createState() => _addCampaignerState();
}

class _addCampaignerState extends State<addCampaigner> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return body();
  }

}
