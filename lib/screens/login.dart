//Packages import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallmaster/model/dailylogmodel.dart';
import 'package:wallmaster/screens/dailylog/job_list.dart';

//State create
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DailyLogModel _dbdailylogmodel = DailyLogModel();
  final formkey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  initState() {
    super.initState();
  }

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
                                                  onPressed: () async {
                                                      if (formkey.currentState!.validate()) {
                                                        var isLogin = await _dbdailylogmodel.userlogin(username.text, password.text);
                                                        print(isLogin);
                                                        if(isLogin == 'Succeed'){
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => JobList()),
                                                          );
                                                        }
                                                        else {
                                                          print(isLogin);
                                                        }
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
