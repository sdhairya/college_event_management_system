import 'package:college_event_management/size_config.dart';
import 'package:flutter/cupertino.dart';

import 'desktop_mode.dart';
import 'login_form.dart';
import 'mobile_mode.dart';

class LoginScreenHms extends StatefulWidget {
  const LoginScreenHms({Key? key}) : super(key: key);

  @override
  State<LoginScreenHms> createState() => _LoginScreenHmsState();
}

class _LoginScreenHmsState extends State<LoginScreenHms> {
  //Login Function

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth <= 1024) {
          return MobileMode();
        } else {
          return DesktopMode();
        }
      },
    );
  }
}