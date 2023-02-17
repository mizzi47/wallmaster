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

class DailyLogFilesDataObject {
  final int dailylog_id;
  final String file_name, file_extension;

  DailyLogFilesDataObject(this.dailylog_id, this.file_name, this.file_extension);
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

  Future<void> testapi()async {
    Response response = await dio.post('http://192.168.1.138/wallmaster/dailylog/getDailyLog',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
    );
    List dailylog_list = jsonDecode(response.toString());
    print(dailylog_list[0]['update']);
  }

  Future<List> getDailyLog() async {
    // List<String> dailylog_list = [
    //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    // ];
    Response response = await dio.post('http://192.168.1.138/wallmaster/dailylog/getDailyLog',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
    );
    List dailylog_list = jsonDecode(response.toString());
    return dailylog_list;
  }

  Future<void> addDailyLog(List scope, String update, String pending, String issue, String logdate, Iterable<ImageFile> images) async {
    DailyLogObject obj = new DailyLogObject(scope, update, pending, issue, logdate);
    List listImages = images.toList();

    Response response = await dio.post('http://192.168.1.138/wallmaster/dailylog/addDailyLog',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(obj.toJson())
    );
    print(response.toString());

    //uploaddata
    for (int i = 0; i < listImages!.length; i++) {
        FormData formdata = FormData.fromMap({
          "file": await MultipartFile.fromFile(listImages[i].path,
              filename: basename(listImages![i].path)
            //show only filename from path
          ),
        });
        response = await dio.post(
          'http://192.168.1.138/wallmaster/api/fileupload.php',
          data: formdata,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          },
        );
        if (response!.statusCode == 200) {
          print(response.toString());
          //print response from server
        } else {
          print("Error during connection to server.");
        }
    }
  }

}
