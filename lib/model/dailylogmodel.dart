import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path_provider/path_provider.dart';

class DailyLogObject {
  final List scope;
  final String update, pending, issue, logdate;

  DailyLogObject(this.scope, this.update, this.pending, this.issue, this.logdate);
  Map toJson() => {
    'scope': scope,
    'update': update,
    'pending': pending,
    'issue': issue,
    'logdate': logdate
  };
}

class Request {
  final String date, name, reason, status, uid;

  Request(this.date, this.name, this.reason, this.status, this.uid);
}

class DailyLogModel {
  late Response response;
  Future<List> getDailyLog() async {
    List<String> dailylog_list = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    ];
    return dailylog_list;
  }
  Future<void> addDailyLog(List scope, String update, String pending, String issue, String logdate, List<File>? files) async {
    DailyLogObject obj = new DailyLogObject(scope, update, pending, issue, logdate);
    // final url = Uri.parse('http://192.168.0.116/wallmaster/api/updateDailyLog');
    // final headers = {"Content-type": "application/json"};
    // final json = '{"title": "Hello", "body": "body text/asd.!@3/asda/vsdkewdafa/...,da!", "userId": 1}';
    // final response = await post(url, headers: headers, body: json);
    // print('Status code: ${response.statusCode}');
    // print('Body: ${response.body}');

  }

}
