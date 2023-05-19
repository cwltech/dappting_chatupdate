import 'dart:convert';

import 'package:dapp/providers/block_listprovider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home_activity.dart';

class block_list extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _block_list();
  }
}

class _block_list extends State<block_list> {
  double _opacity = 0.9;
  var user_id;
  var host_details;
  @override
  void initState() {
    super.initState();
    get_blogdetails(context);
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
      this.hostdetails(user_id);
    });
    print("blodidw $user_id");
  }

  Future<String> hostdetails(String user_id) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/userBlocklist";
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = user_id;

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Map mapRes = json.decode(onValue.body);
          var status = mapRes["status"];
          setState(() {
            host_details = mapRes["data"]["UserList"];
          });
          if (status == "1") {
            print("host_details$host_details");
          }
        } catch (e) {
          print("response$e");
        }
      });
    });
    return "";
  }

  @override
  Widget build(BuildContext context) {
    context.read<block_list_provider>().block_list(user_id);
    return Stack(
      children: [
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              Opacity(
                  opacity: _opacity,
                  child: Image.asset('assets/hearts_1.png',
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover)),
            ]),
          ],
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Block List",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                ],
              ),
            ),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              host_details != null
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: host_details.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            child: host_details[index]
                                                        ["profile_image"] !=
                                                    null
                                                ? Image.network(
                                                    host_details[index]
                                                        ["profile_image"],
                                                    fit: BoxFit.fill,
                                                  )
                                                : Icon(Icons.person),
                                          )),
                                      Text(
                                        host_details[index]["unique_id"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    host_details[index]["name"],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xffCC0000),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    unblock_user(
                                      user_id,
                                      host_details[index]["user_id"].toString(),
                                    );
                                  },
                                  child: Text(
                                    "Unblock",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Color(0xffCC0000),
                                    ),
                                  ),
                                  // color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          )),
        )
      ],
    );
  }

  unblock_user(String UserId, String friend_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl = "https://hookupindia.in/hookup/ApiController/unblockUser";
    print("stringrequest");
    print("user_id $UserId");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = UserId;
    request.fields['friend_id'] = friend_id;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print("onValue1${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var success = mapRes["status"];
          var message = mapRes["message"];
          if (success == "1") {
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home_home()));
          }
          setState(() {});
        } catch (e) {
          print("response$e");
        }
      });
    });
  }
}
