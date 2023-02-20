import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:wallmaster/screens/dailylog/dailylog_list.dart';

class CardMyJob extends StatelessWidget {
  CardMyJob(
      {required this.title,
        required this.description,
        required this.assign,
        required this.assignemail,
        required this.priority,
        required this.taskno});

  final String title;
  final String description;
  final String assign;
  final String assignemail;
  final String taskno;
  final int priority;

  String hasService = '';
  String hasProduct = '';

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Bounce(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    DailyLogList()),
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
                    child: Icon(Icons.file_copy_outlined, color: Colors.white),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
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
                            Text(assign, style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.date_range, color: Colors.yellow),
                          Text(description,
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

  Widget _buildProductList(
      List list, String hasProduct, List prod, BuildContext context) {
    if (hasProduct == 'yes') {
      return Column(
        children: [
          Container(
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Text(
                      'Products: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          for (var i = 0; i < list.length; i++)
            Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: Text(
                        '${i + 1}. ${list[i]}',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Text(
                      'No Products Found',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ],
      );
    }
  }
}
