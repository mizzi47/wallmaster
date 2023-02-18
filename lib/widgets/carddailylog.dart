
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart';
import 'package:wallmaster/model/dailylogmodel.dart';
import 'package:wallmaster/screens/dailylog/dailylog_list.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:wallmaster/screens/dailylog/dailylog_view.dart';

DailyLogModel _dbdailylogmodel = DailyLogModel();

class CardDailyLog extends StatelessWidget {
  CardDailyLog(
      {required this.dailylogdata,});

  var dailylogdata;
  var dailylogfiles;

  @override
  Widget build(BuildContext context) {
    print(dailylogdata);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Bounce(
        onPressed: () async {
          showDialog(barrierDismissible: false,
            context:context,
            builder:(BuildContext context){
              return LoadingAnimationWidget.fourRotatingDots(
                color: Colors.white,
                size: 100,
              );
            },
          );
          await _dbdailylogmodel.getDailyLogFiles(dailylogdata['dailylog_id']).then((value) {
            dailylogfiles = value;
            Navigator.pop(context);
         });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    DailyLogView(dailylogdata: dailylogdata, dailylogfiles: dailylogfiles)),
          );
        },
        duration: Duration(milliseconds: 150),
        child: Column(
          children: [
            Card(
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
                    child: Icon(Icons.date_range, color: Colors.white,),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dailylogdata['logdate'],
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
                            Text('testname', style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.type_specimen_rounded, color: Colors.yellow),
                          Text(dailylogdata['scope'],
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
