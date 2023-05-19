import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class saveorderhistory {
  static orderhistory(BuildContext context, String user_id, String txn_id,
      String plan_id, String type, String status) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/saveOrderHistory";
    print("stringrequestorder");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = user_id;
    request.fields['plan_id'] = plan_id;
    request.fields['txn_id'] = txn_id;
    request.fields['type'] = type;
    request.fields['status'] = status;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          print("onValuehistory ${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var success = mapRes["status"];
          var msg = mapRes["message"];

          if (success == "1") {
            print("user_id$user_id");

            Navigator.pop(context);
          } else {}
        } catch (e) {
          print("response$e");
        }
      });
    });
  }
}
