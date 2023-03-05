import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallmaster/model/dailylogmodel.dart';
import 'package:wallmaster/screens/dailylog/dailylog_list.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

DailyLogModel _dbdailylogmodel = DailyLogModel();

class DailyLogAdd extends StatefulWidget {
  final int job_id;

  const DailyLogAdd(this.job_id);

  @override
  _DailyLogAddState createState() => _DailyLogAddState();
}

class _DailyLogAddState extends State<DailyLogAdd> {
  //class initiation
  Dio dio = Dio();
  final formkey = GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  final controller = MultiImagePickerController(
    maxImages: 10,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
    withData: true,
    withReadStream: true,
  );

  //form initiation
  TextEditingController update = TextEditingController();
  TextEditingController pending = TextEditingController();
  TextEditingController issue = TextEditingController();
  TextEditingController logdate = TextEditingController();
  var datePicked;
  var selectedscope = [];
  List<String> scope = [
    'Wework',
    'Ceiling',
    'Wiring',
    'Wall Finishes',
    'Floor Finishes',
    'Carpentry Finishes',
    'Steel/aluminium Finishes',
    'Others'
  ];

  //files upload declaration
  var selectedfile;
  List<File>? files;
  Response? response;
  String? progress;

  @override
  Widget build(BuildContext context) {
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
                          FocusScope.of(context).requestFocus(FocusNode());
                          var datePickedNew =
                              await DatePicker.showSimpleDatePicker(
                            context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1960),
                            dateFormat: "dd-MM-yyyy",
                            looping: true,
                          );
                          if (datePickedNew == null) {
                            print('null bro');
                          } else {
                            datePicked = datePickedNew;
                            var outputFormat = DateFormat('yyyy/MM/dd');
                            var outputDate = outputFormat.format(datePicked);
                            logdate.text = outputDate;
                          }
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('SCOPE OF WORK :')),
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
                                    if (selected == true) {
                                      selectedscope.add(index);
                                      print(selectedscope);
                                    }
                                    if (selected == false) {
                                      selectedscope.remove(index);
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
                          final prefs = await SharedPreferences.getInstance();
                          var job_id = prefs.getInt('current_job_id');
                          selectedscope.sort();
                          //await _dbdailylogmodel.testapi();
                          if (formkey.currentState!.validate()) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.white,
                                  size: 100,
                                );
                              },
                            );
                            await _dbdailylogmodel
                                .addDailyLog(
                                    widget.job_id,
                                    selectedscope,
                                    update.text,
                                    pending.text,
                                    issue.text,
                                    logdate.text.substring(0, 10),
                                    controller.images)
                                .then((value) => Navigator.pop(context))
                                .then((value) {
                              return Dialogs.materialDialog(
                                  barrierDismissible: false,
                                  msg: 'Daily log data saved successfully',
                                  title: "Success!",
                                  color: Colors.white,
                                  context: context,
                                  actions: [
                                    IconsButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DailyLogList(widget.job_id)),
                                        );
                                      },
                                      text: 'Okay',
                                      iconData: Icons.file_download_done,
                                      color: Colors.green,
                                      textStyle: TextStyle(color: Colors.white),
                                      iconColor: Colors.white,
                                    ),
                                  ]);
                            });
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  )),
                  SizedBox(height: 10.0),
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
