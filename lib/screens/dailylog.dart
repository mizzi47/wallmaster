import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:wallmaster/widgets/testslider.dart' as testslider;
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';



class DailyLog extends StatefulWidget {
  @override
  _DailyLogState createState() => _DailyLogState();
}

class _DailyLogState extends State<DailyLog> {
  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController booking_name = new TextEditingController();
  TextEditingController booking_date = new TextEditingController();
  var datePicked;

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
          title: const Text('PDRM EVIDENCE BOOKING'),
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
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: booking_name,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Sender name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your position';
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: booking_name,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_box_outlined),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Position name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Agency/Department';
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: booking_name,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.local_police_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Your Agency/Department",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Which Department';
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: booking_name,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_balance),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "To What Department?",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          datePicked = await DatePicker.showSimpleDatePicker(
                            context,
                            firstDate: DateTime(1960),
                            dateFormat: "dd-MMMM-yyyy",
                            looping: true,
                          );
                          booking_date.text = datePicked.toString();
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == 'null' || value == null) {
                            return 'Please enter submit date';
                          }
                          return null;
                        },
                        controller: booking_date,
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
                  testslider.sliders(context)
                ],
              ),),
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