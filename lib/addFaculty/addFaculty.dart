import 'dart:async';
import 'dart:js';

import 'package:college_event_management/dashboardScreen.dart';
import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../addFaculty/components/body.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:college_event_management/emailVerification.dart';
import 'package:college_event_management/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../login/main.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/framework.dart';


class addFaculty extends StatefulWidget {
  const addFaculty({Key? key}) : super(key: key);

  @override
  State<addFaculty> createState() => _addFacultyState();
}


class _addFacultyState extends State<addFaculty> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return body();
  }


}


