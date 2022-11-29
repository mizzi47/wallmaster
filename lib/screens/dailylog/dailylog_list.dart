import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:wallmaster/screens/dailylog/dailylog.dart';
import 'package:wallmaster/model/dailylogmodel.dart' as dailylogmodel;


class DailyLogList extends StatefulWidget {
  @override
  _DailyLogListState createState() => _DailyLogListState();
}

class _DailyLogListState extends State<DailyLogList> {
  dailylogmodel.Model _dbdailylog = dailylogmodel.Model();
  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();

  var spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Daily Log List'),
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
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: FutureBuilder<List>(
                  future: _dbdailylog.getDailyLog(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text(snapshot.toString());
                    if (snapshot.hasData) {
                      return Container(
                        height: height * 0.85,
                        child: _buildItem(snapshot.data, context),
                      );
                    } else {
                      return spinkit;
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  _buildItem(List? list, BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Hi'),
    );
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list?.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white12),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DailyLog()),
                  );
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                )),
          ),
        );
      },
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
