import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallmaster/screens/dailylog/dailylog_view.dart';
import 'package:wallmaster/screens/dailylog/job_list.dart';
import 'package:wallmaster/screens/login.dart';
import 'package:wallmaster/screens/schedule/scheduleview.dart';

Widget build(BuildContext context){
  var txtshadow = TextStyle(
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 10.0,
        color: Color.fromARGB(255, 0, 0, 0),
      )
    ],
  );
  var _shadows = <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 10.0,
      color: Color.fromARGB(255, 0, 0, 0),
    )
  ];
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
            Divider(color: Colors.black12,
              thickness: 1,),
            ListTile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        JobList()),
                    (route) => false,
              );},
              leading: Icon(Icons.file_copy_rounded, shadows: _shadows),
              title: Text('My Jobs', style: TextStyle(shadows: _shadows)),
            ),
            Divider(color: Colors.black12,
              thickness: 1,),
            ListTile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ScheduleView()),
                      (route) => false,
                );},
              leading: Icon(Icons.access_time_rounded, shadows: _shadows,),
              title: Text('Schedule', style: txtshadow),
            ),
            Divider(color: Colors.black12,
              thickness: 1,),
            ListTile(
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('_islogged');
                await prefs.remove('_userid');
                await prefs.remove('_userdata');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                );
                },
              leading: Icon(Icons.logout_rounded, shadows: _shadows),
              title: Text('Logout',style: TextStyle(shadows: _shadows)),
            ),
            Divider(color: Colors.black12,
              thickness: 1,),
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