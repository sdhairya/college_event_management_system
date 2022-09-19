import 'dart:async';

import 'package:flutter/material.dart';

class timer extends StatefulWidget {
  const timer({Key? key}) : super(key: key);

  @override
  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {
  // Step 2
  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 5);
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(minutes: 5));
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    // final days = strDigits(myDuration.inMinutes);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Step 8
            Text(
              '$hours:$minutes:$seconds',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 80),
            ),
            // Step 9
            // ElevatedButton(
            //   onPressed: (){
            //     startTimer();
            //   },
            //   child: Text(
            //     'Start',
            //     style: TextStyle(
            //       fontSize: 30,
            //     ),
            //   ),
            // ),
            // Step 10
            // ElevatedButton(
            //   onPressed: () {
            //     if (countdownTimer == null || countdownTimer!.isActive) {
            //       stopTimer();
            //     }
            //   },
            //   child: Text(
            //     'Stop',
            //     style: TextStyle(
            //       fontSize: 30,
            //     ),
            //   ),
            // ),
            // Step 11
          ],
        ),
      ),
    );
  }
}

