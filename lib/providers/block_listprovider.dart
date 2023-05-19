import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class block_list_provider with ChangeNotifier {
  Map<String, dynamic> map = {};
  bool error = false;
  String errormessage = '';

  Map<String, dynamic> get _map => map;
  bool get _error => error;
  String get _errormessage => errormessage;

  Future<void> block_list(String user_id) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/userBlocklist";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.send().then((response) {
      request.fields['user_id'] = user_id;
      http.Response.fromStream(response).then((onValue) {
        if (response.statusCode == 200) {
          try {
            map = json.decode(onValue.body);
            print("bodyblock$map");
            error = false;
          } catch (e) {
            error = true;
            print("response$e");
            errormessage = e.toString();
            map = {};
          }
        } else {
          error = true;
          errormessage = "Please Check Your Internet Connection";
          map = {};
        }
        notifyListeners();
      });
    });
  }

  void initializedvalue() {
    error = false;
    errormessage = " ";
    map = {};
    notifyListeners();
  }
}
