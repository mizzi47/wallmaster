import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:wallmaster/widgets/imagesliders.dart' as testslider;
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';



class DailyLogView extends StatefulWidget {
  @override
  _DailyLogViewState createState() => _DailyLogViewState();
}

class _DailyLogViewState extends State<DailyLogView> {
  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController scope = new TextEditingController();
  TextEditingController update = new TextEditingController();
  TextEditingController pending = new TextEditingController();
  TextEditingController issue = new TextEditingController();
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
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: const Text('Daily Log Details'),
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
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        readOnly: true,
                        maxLines: null,
                        controller: scope,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Wall Finishes/ Floor Finishes",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        readOnly: true,
                        maxLines: null,
                        controller: update,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "The update is bla bla bla",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        readOnly: true,
                        maxLines: null,
                        controller: pending,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "The pending is no screws attached in the wall",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        readOnly: true,
                        maxLines: null,
                        controller: issue,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "water flowing inside mosaic of the second room",
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