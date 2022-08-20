import 'package:college_event_management/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class createEvent extends StatefulWidget {
  const createEvent({Key? key}) : super(key: key);

  @override
  State<createEvent> createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            Column(
              children: [
                const Align(alignment: Alignment(0, 0),),
                Container(
                  height: getHeight(50),
                  width: getWidth(kIsWeb ? 100 : double.infinity),
                  margin: EdgeInsets.only(left: 20,
                  top: MediaQuery.of(context).size.height*0.12),
                  child: const Text('Create Event',
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1D2A3A)),),
                ),

                Container(
                  // height: getHeight(555),
                  width: getWidth(kIsWeb ? 100 : double.infinity),
                  // width: kIsWeb ? 600 : double.infinity,
                  // constraints: BoxConstraints(maxWidth: 1000),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.06),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('   Event Name',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Event Name',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('    Event Date',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Date',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      const Text('    Event Location',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Event Location',
                        ),
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      const Text('    Event Charges',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Event Charges',
                        ),
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      const Text('    Event Description',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF1D2A3A))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter Event Description',
                        ),
                        keyboardType: TextInputType.multiline,
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 5),
                          child: Container(
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
                                  : const Text('Add Faculty'),
                              onPressed: () async {
                                if (isLoading) return;

                                setState(() => isLoading = true);
                                // User? user = await loginUsingEmailPassword(
                                //     email: _emailController.text,
                                //     password: _passwordController.text,
                                //     context: context);
                                // print(user);
                                // if (user != null) {
                                //   setState(() => isLoading = false);
                                //   Navigator.of(context).pushReplacement(
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               dashboardScreen()));
                                // } else {
                                //   Fluttertoast.showToast(
                                //       msg: "Enter Valid Email and Password",
                                //       toastLength: Toast.LENGTH_SHORT,
                                //       gravity: ToastGravity.BOTTOM,
                                //       timeInSecForIosWeb: 1,
                                //       backgroundColor: Colors.red,
                                //       textColor: Colors.white,
                                //       fontSize: 16.0);
                                //   setState(() => isLoading = false);
                                // }
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),

              ],
            )
          ],
        ),
      ),

    );
  }
}
