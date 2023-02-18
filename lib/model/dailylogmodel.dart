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

  DailyLogObject(
      this.scope, this.update, this.pending, this.issue, this.logdate);

  Map toJson() => {
        'scope': scope,
        'update': update,
        'pending': pending,
        'issue': issue,
        'logdate': logdate
      };
}

class DailyLogFilesObject {
  final int dailylog_id;
  final String file_name, file_extension;

  DailyLogFilesObject(this.dailylog_id, this.file_name, this.file_extension);

  Map toJson() => {
        'dailylog_id': dailylog_id,
        'file_name': file_name,
        'file_extension': file_extension,
      };
}

class Request {
  final String date, name, reason, status, uid;

  Request(this.date, this.name, this.reason, this.status, this.uid);
}

class DailyLogModel {
  String hostname = 'http://192.168.1.138/wallmaster';

  //String hostname = 'http://192.168.0.116/wallmaster';
  Dio dio = new Dio();

  Future<void> testapi() async {
    Response response = await dio.post(
      hostname+'/dailylog/getDailyLog',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
    );
    List dailylog_list = jsonDecode(response.toString());
    print(dailylog_list[0]['update']);
  }

  Future<List> getDailyLog() async {
    Response response = await dio.post(
      hostname+'/dailylog/getDailyLog',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
    );
    List dailylog_list = jsonDecode(response.toString());
    return dailylog_list;
  }

  Future<void> addDailyLog(List scope, String update, String pending,
      String issue, String logdate, Iterable<ImageFile> images) async {
    DailyLogObject obj =
        new DailyLogObject(scope, update, pending, issue, logdate);

    List listImages = images.toList();

    Response addresponse =
        await dio.post(hostname+'/dailylog/addDailyLog',
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data: jsonEncode(obj.toJson()));
    print('inserted id: ' + addresponse.toString());

    //uploaddata
    for (int i = 0; i < listImages.length; i++) {
      String createdfile_name =
          'FDL' + addresponse.toString() + '_' + basename(listImages[i].path);
      FormData formdata = FormData.fromMap({
        "file": await MultipartFile.fromFile(listImages[i].path,
            filename: createdfile_name),
      });
      Response fileupload_response = await dio.post(
        hostname+'/api/fileupload.php',
        data: formdata,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
      if (fileupload_response.statusCode == 200) {
        DailyLogFilesObject fobj = new DailyLogFilesObject(
            int.parse(addresponse.toString()),
            createdfile_name,
            listImages[i].extension);
        print(jsonEncode(fobj.toJson()));
        Response fileuploaddata_response = await dio.post(
            hostname+'/dailylog/addDailyLogFiles',
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data: jsonEncode(fobj.toJson()));
        //print response from server
      } else {
        print("Error during connection to server.");
      }
    }
  }

  Future<List> getDailyLogFiles(var dailylog_id) async {
    Response response = await dio.post(
      hostname+'/dailylog/getDailyLogFiles',
      data: {'dailylog_id': dailylog_id},
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
    );
    List dailylog_list_raw = jsonDecode(response.toString());
    List<String> dailylog_list = [];
    for (var dlraw in dailylog_list_raw) {
      dailylog_list.add(hostname+'/uploads/'+dlraw['file_name']);
    }
    return dailylog_list;
  }
}
