import 'package:college_event_management/hms/ui/event/body.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class EventScreenHms extends StatefulWidget {
  const EventScreenHms({Key? key}) : super(key: key);
  @override
  State<EventScreenHms> createState() => _EventScreenHmsState();
}

class _EventScreenHmsState extends State<EventScreenHms> {
  double maxWidthSize = 500;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child:
        //Login Text Container
        LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: constraints.maxWidth < maxWidthSize
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(30.0),
              child: Center(
                  child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 25.0),
                      constraints: BoxConstraints(
                        maxWidth: maxWidthSize,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Body()
                  )
              )
          );
        }
        )
        )
    );
  }
}