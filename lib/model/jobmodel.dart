import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobModel {
  //String hostname = 'http://192.168.0.116/wallmaster';

  String hostname = 'http://192.168.1.138/wallmaster';
  Dio dio = new Dio();

  Future<List> getJob() async {
    final prefs = await SharedPreferences.getInstance();
    var _userid = prefs.getInt('_userid');
    Response response = await dio.post(hostname + '/dailylog/getJob',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: _userid);
    List job_list = jsonDecode(response.toString());
    return job_list;
  }
}
