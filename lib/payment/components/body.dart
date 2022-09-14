import 'package:college_event_management/createProfile/createProfile.dart';
import 'package:college_event_management/payment/components/payment_components.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { Yes, No }
int amt=100;

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  bool isLoading = false;
  bool isChecked = false;
  int certificate = 0;
  int lunch = 0;
  SingingCharacter? _certificate = SingingCharacter.No;
  SingingCharacter? _lunch = SingingCharacter.No;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500
                ? EdgeInsets.zero
                : const EdgeInsets.all(30.0),
            child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 25.0),
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment(0, 0),
                          ),

                          Container(
                            child: ListTile(
                              leading: IconButton(
                                  padding: EdgeInsets.only(bottom: 3, right: 8),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                createProfile()));
                                  },
                                  icon: Icon(
                                    color: Color(0xFF1D2A3A),
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 30,
                                  )),
                              title: const Text(
                                'Payment ',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1D2A3A)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                payment_components().text(
                                    'Do you want to have hardcopy of certificate ?',
                                    FontWeight.w600, Color(0xFF1D2A3A), 16),
                                // const Text('   User Name',
                                //     style: TextStyle(
                                //         fontSize: 16, color: Color(0xFF1D2A3A))),
                                const SizedBox(
                                  height: 10,
                                ),

                                Column(
                                  children: [
                                    RadioListTile(
                                        title: Text("Yes"),
                                        value: SingingCharacter.Yes,
                                        groupValue: _certificate,
                                        onChanged: (SingingCharacter? value) {
                                          setState(() {
                                            _certificate = value;
                                            certificate=100;
                                            amount(certificate,lunch);
                                          });
                                        }),
                                    RadioListTile(
                                        title: Text("No"),
                                        value: SingingCharacter.No,
                                        groupValue: _certificate,
                                        onChanged: (SingingCharacter? value) {
                                          setState(() {
                                            _certificate = value;
                                            certificate=0;
                                            amount(certificate,lunch);
                                          });
                                        }),
                                  ],
                                ),

                                payment_components().text(
                                    'Do you want to include lunch ?',
                                    FontWeight.w600, Color(0xFF1D2A3A), 16),

                                const SizedBox(
                                  height: 10,
                                ),

                                Column(
                                  children: [
                                    RadioListTile(
                                        title: Text("Yes"),
                                        value: SingingCharacter.Yes,
                                        groupValue: _lunch,
                                        onChanged: (SingingCharacter? value) {
                                          setState(() {
                                            _lunch = value;
                                            lunch=150;
                                            amount(certificate,lunch);
                                          });
                                        }),
                                    RadioListTile(
                                        title: Text("No"),
                                        value: SingingCharacter.No,
                                        groupValue: _lunch,
                                        onChanged: (SingingCharacter? value) {
                                          setState(() {
                                            _lunch = value;
                                            lunch=0;
                                            amount(certificate,lunch);
                                          });
                                        }),
                                  ],
                                ),

                              SizedBox(height: 20,),

                                Text("Amount : $amt", ),

                                SizedBox(height: 20,),

                                Container(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF1D2A3A),
                                      onSurface: Color(0xFF1D2A3A),
                                      padding: EdgeInsets.all(3),
                                      textStyle: TextStyle(fontSize: 20),
                                      minimumSize: Size.fromHeight(50),
                                      shape: StadiumBorder(),
                                      enableFeedback: true,
                                    ),
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor: Colors.transparent,
                                    )
                                        : const Text('Make Payment'),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom)),
                        ],
                      )
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }

  void amount(int certificate, int lunch) {
    int fixed=100;
    setState(() {
      amt=fixed+certificate+lunch;
    });
  }
}
