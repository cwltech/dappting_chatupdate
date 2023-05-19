import 'dart:convert';
import 'package:dapp/create_account.dart';
import 'package:dapp/female_user/female_dashboard.dart';
import 'package:dapp/female_user/female_home_activity.dart';
import 'package:dapp/female_user/female_otp_activity.dart';
import 'package:dapp/forget_password.dart';
import 'package:dapp/home_activity.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/providers/auth_provider.dart';
import 'package:dapp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../otp_screen.dart';

class female_login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _sign_up();
  }
}

class _sign_up extends State<female_login> {
  final mobilecontroller = new TextEditingController();
  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);

    double _opacity = 0.9;
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
                color: Color(0xffCC0000),
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
            //  backgroundColor: Color(0xffCC0000),
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   backgroundColor: Colors.transparent,
            //   elevation: 0.0,
            // ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Center(
                      child: Image.asset(
                        "assets/logo.png",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "Vendor Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      color: Colors.white.withOpacity(0.15),
                      child: TextFormField(
                        controller: mobilecontroller,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          hintText: "Mobile No.",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                    child: TextField(
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),*/

                  Offstage(
                    offstage: true,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => forgot_pwsd()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: Center(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xff07D3DF),
                      child: TextButton(
                        onPressed: () {
                          circle(context);
                          send_mobile_otp(mobilecontroller.text);
                        },
                        child: Text(
                          "GET OTP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Color(0xff07D3DF),
                          ),
                        ),
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  send_mobile_otp(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl = "https://hookupindia.in/hookup/ApiController/userlogin";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['mobile'] = mobile;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          print("onValue${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var success = mapRes["status"];
          var msg = mapRes["message"];

          if (success == "1") {
            var otpdetail = mapRes["data"]["otp"];
            var user_id = mapRes["data"]["user_id"];
            var unique_id = mapRes["data"]["unique_id"];
            var type = mapRes["data"]["type"];
            print("user_id$user_id");

            if (type == "Host") {
              setState(() {
                var getotp = otpdetail;
                prefs.setString("new_account", " ");
                prefs.setString("mobile_number", mobile);
                prefs.setInt("otp_found", getotp);
                prefs.setString("user_id", user_id);
                prefs.setString("host_unique_id", unique_id);
                userdata(user_id);
              });
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => female_otp_screen()));
            } else {
              Fluttertoast.showToast(
                  msg: "You're not registered",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1);
            }
          } else {
            Fluttertoast.showToast(
                msg: "You're not registered",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          }
        } catch (e) {
          print("response$e");
        }
      });
    });
  }

  userdata(String UserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl = "https://hookupindia.in/hookup/ApiController/userDetail";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = UserId;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print("onValue1${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var emaildetail = mapRes["data"]["userData"]["email"];
          var namedetail = mapRes["data"]["userData"]["fname"];
          var Mobile = mapRes["data"]["userData"]["mobile"];
          var profile_image = mapRes["data"]["userData"]["profile_image"];
          var unique_id = mapRes["data"]["userData"]["unique_id"];
          var user_id = mapRes["data"]["userData"]["user_id"].toString();
          setState(() {
            prefs.setString("email_id", "$emaildetail");
            prefs.setString("name_user", "$namedetail");
            prefs.setString("Mobile", "$Mobile");
            authProvider.handleSignIn(
                user_id, namedetail, profile_image, "vendor");
          });
          //   print("getdatata$email $name)");

        } catch (e) {
          print("response$e");
        }
      });
    });
  }
}

//https://www.figma.com/file/4BeISemeJcYA2qt1tub2tX/Dating-App?node-id=50%3A289
