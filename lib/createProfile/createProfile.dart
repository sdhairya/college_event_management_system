import 'package:college_event_management/createProfile//components/body.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class createProfile extends StatefulWidget {
  const createProfile({Key? key}) : super(key: key);

  @override
  State<createProfile> createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {


  @override
  Widget build(BuildContext context) {
    return body();
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Align(alignment: Alignment(0, 0),),
    //         Container(
    //           height: getHeight(50),
    //           width: getWidth(kIsWeb ? 180 : double.infinity),
    //           margin: EdgeInsets.only(
    //               left: 20, top: MediaQuery.of(context).size.height * 0.12),
    //           child: Row(
    //             children: <Widget>[
    //               IconButton(
    //                   padding: EdgeInsets.only(bottom: 3, right: 8),
    //                   onPressed: () {
    //                     // Navigator.of(context).pushReplacement(
    //                     //     MaterialPageRoute(
    //                     //         builder: (context) => HomePage()));
    //                   },
    //                   icon: Icon(
    //                     Icons.arrow_back_ios_new_rounded,
    //                     size: 30,
    //                   )),
    //               Text(
    //                 'Create Profile ',
    //                 style: TextStyle(
    //                     fontSize: 35,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w600,
    //                     color: Color(0xFF1D2A3A)),
    //               )
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           width: getWidth(kIsWeb ? 180 : double.infinity),
    //           child: Column(
    //             children: <Widget>[
    //               SizedBox(
    //                 child: Card(color: Colors.deepOrange),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   )
    // );
  }


}
