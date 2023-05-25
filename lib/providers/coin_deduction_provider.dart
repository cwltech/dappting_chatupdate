import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class coin_deduction_provider with ChangeNotifier {
  Map<String, dynamic> map = {};
  bool error = false;
  String errormessage = '';

  Map<String, dynamic> get _map => map;
  bool get _error => error;
  String get _errormessage => errormessage;

  Future<void> coin_deduction_list(
      String userId, String host_id, String coins, String sec) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/coinDeduction";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = userId;
    request.fields['host_id'] = host_id;
    request.fields['coins'] = coins;
    request.fields['sec'] = sec;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        if (response.statusCode == 200) {
          try {
            map = json.decode(onValue.body);
            print("coin_coin$map");
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
