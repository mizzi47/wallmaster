import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:wallmaster/model/dailylogmodel.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:wallmaster/widgets/imagesliders.dart' as testslider;
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class DailyLogAdd extends StatefulWidget {
  @override
  _DailyLogAddState createState() => _DailyLogAddState();
}

class _DailyLogAddState extends State<DailyLogAdd> {
  DailyLogModel _md = new DailyLogModel();
  final controller = MultiImagePickerController(
    maxImages: 10,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  List<String> scope = [
    'Wework',
    'Ceiling',
    'Wiring',
    'Wall Finishes',
    'Floor Finishes',
    'Carpentry Finishes',
    'Steel/aluminium Finishes'
  ];
  var selectedscope = [];
  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController update = new TextEditingController();
  TextEditingController pending = new TextEditingController();
  TextEditingController issue = new TextEditingController();
  TextEditingController logdate = new TextEditingController();
  var datePicked;

  @override
  Widget build(BuildContext context) {
    selectedscope = [];
    selectedscope.length = 7;
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: constant_drawer.build(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: const Text('Add New Daily Log'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Scope Of Work :')),
                  ),
                  Container(
                    child: Column(
                      children: List.generate(scope.length, (index) {
                        return Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    if(selected == true){
                                      selectedscope[index] = scope[index].toString();
                                      print(scope[index].toString());
                                      print(selectedscope);
                                    }
                                    if(selected == false){
                                      selectedscope[index] = null;
                                      print(index);
                                      print(selectedscope);
                                    }
                                  },
                                  size: 30,
                                  uncheckedColor: Colors.white,
                                )),
                            Text(scope[index].toString())
                          ],
                        );
                      }),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter update';
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: update,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.update_rounded),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Update",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter pending';
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: pending,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.pending_rounded),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Pending",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter issue';
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: issue,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.security_update_warning_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Issues",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          datePicked = await DatePicker.showSimpleDatePicker(
                            context,
                            firstDate: DateTime(1960),
                            dateFormat: "dd-MMMM-yyyy",
                            looping: true,
                          );
                          logdate.text = datePicked.toString();
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              value == 'null' ||
                              value == null) {
                            return 'Please enter submit date';
                          }
                          return null;
                        },
                        controller: logdate,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Submit date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Divider(color: Colors.black),
                  MultiImagePickerView(
                    controller: controller,
                    padding: const EdgeInsets.all(10),
                  ),
                  Divider(color: Colors.black),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            _md.addDailyLog(selectedscope, update.text, pending.text, issue.text, logdate.text);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => JobList()),
                            // );
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
