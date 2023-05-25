import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileDetailsProvider with ChangeNotifier {
  Map<String, dynamic> map = {};
  bool error = false;
  String errormessage = '';

  Map<String, dynamic> get _map => map;
  bool get _error => error;
  String get _errormessage => errormessage;

  Future<void> profileDetailsList(String UserId) async {
    String postUrl = "https://hookupindia.in/hookup/ApiController/userDetail";
    print("stringrequest");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = UserId;
    print("hahahahh ==== > $UserId");
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        if (response.statusCode == 200) {
          try {
            map = json.decode(onValue.body);
            print("User From Current Api =========> 🍧🍧🍧🍧 $map");
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
