import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallmaster/screens/dailylog/dailylog.dart';
import 'package:wallmaster/screens/dailylog/dailylog_list.dart';

Widget build(BuildContext context){
  return SafeArea(
    child: Container(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              margin: const EdgeInsets.only(
                top: 24.0,
                bottom: 64.0,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DailyLogList()),
                    (route) => false,
              );},
              leading: Icon(Icons.file_copy_rounded),
              title: Text('Daily Log'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DailyLog()),
                      (route) => false,
                );},
              leading: Icon(Icons.access_time_rounded),
              title: Text('Schedule'),
            ),
            Spacer(),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}