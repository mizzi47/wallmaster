//Packages import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallmaster/screens/dailylog/job_list.dart';

//State create
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  initState() {
    super.initState();
  }

  //Widget Builder
  Widget _buildButton(
          {required String label,
          VoidCallback? onPressed,
          required Color cl}) =>
      Padding(
          padding: EdgeInsets.all(12.0),
          child: MaterialButton(
            onPressed: onPressed,
            color: cl.withOpacity(0.8),
            disabledColor: cl.withOpacity(0.5),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: Center(child: Text('REXINPRO SOFT (v1)')),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_phone_logo.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.grey.shade200.withOpacity(0.05),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.all(8.0),
                            )),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200
                                            .withOpacity(0.5),
                                        border:
                                            Border.all(color: Colors.black26),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    padding: const EdgeInsets.all(15.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            TextFormField(
                                              onTap: () {},
                                              decoration: InputDecoration(
                                                  icon: Icon(Icons.person),
                                                  filled: true,
                                                  fillColor: Colors.white
                                                      .withOpacity(0.8),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          20.0, 15.0, 20.0, 15.0),
                                                  hintText: "Username",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0))),
                                              controller: username,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter username';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            TextFormField(
                                              onTap: () {},
                                              decoration: InputDecoration(
                                                  icon: Icon(Icons.password),
                                                  filled: true,
                                                  fillColor: Colors.white
                                                      .withOpacity(0.8),
                                                  contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                                  hintText: "Password",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                              controller: password,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter password';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                  onPressed: (){
                                                      if (formkey.currentState!.validate()) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => JobList()),
                                                        );
                                                      }
                                                  },
                                                  child: Text('Login'),
                                                )
                                            )
                                          ]),
                                    ))),
                          ]),
                    )),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
