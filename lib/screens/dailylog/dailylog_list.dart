import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallmaster/screens/dailylog/dailylog_add.dart';
import 'package:wallmaster/widgets/carddailylog.dart';
import 'package:wallmaster/widgets/cardmyjob.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:wallmaster/screens/dailylog/dailylog_view.dart';
import 'package:wallmaster/model/dailylogmodel.dart' as dailylogmodel;


class DailyLogList extends StatefulWidget {
  @override
  _DailyLogListState createState() => _DailyLogListState();
}

class _DailyLogListState extends State<DailyLogList> {
  dailylogmodel.DailyLogModel _dbdailylog = dailylogmodel.DailyLogModel();
  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  final ScrollController _firstController = ScrollController();

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
          backgroundColor: Colors.blue.withOpacity(0.2),
          title: const Text('Daily Log List'),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.withOpacity(0.5)),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DailyLogAdd()),
                  );
                },
                child: Icon(Icons.add_box_rounded)
            )
          ],
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
          children: <Widget> [
            Container(
              child: FutureBuilder<List>(
                  future: _dbdailylog.getDailyLog(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text(snapshot.toString());
                    if (snapshot.hasData) {
                      return _buildMyItem(snapshot.data, context);
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
            child: Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration:
                BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'title',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Divider(color: Colors.black),
                    ],
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.account_box_rounded,
                                color: Colors.yellow),
                            Text('assign', style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.date_range, color: Colors.yellow),
                          Text('My Job',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMyItem(List? list, BuildContext context) {
    return Scrollbar(
      thickness: 10,
      isAlwaysShown: true,
      controller: _firstController,
      child: ListView.builder(
        controller: _firstController,
        shrinkWrap: true,
        itemCount: list?.length,
        itemBuilder: (BuildContext context, int index) {
          return CardDailyLog(
            title: 'Door Surveilance',
            assign: 'Mizi',
            description: 'Wiring',
            assignemail: '',
            taskno: 't/21',
            priority: 2,
          );
        },
      ),
    );
  }
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
