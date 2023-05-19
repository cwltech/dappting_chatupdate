import 'dart:convert';

import 'package:dapp/female_user/female_dashboard.dart';
import 'package:dapp/female_user/female_home_activity.dart';
import 'package:dapp/forget_password.dart';
import 'package:dapp/home_activity.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'otp_screen.dart';

class create_account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _sign_up();
  }
}

class _sign_up extends State<create_account> {
  final mobilecontroller = new TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                        "Register To Login",
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
                    child: Form(
                      key: formGlobalKey,
                      child: Container(
                        color: Colors.white.withOpacity(0.15),
                        child: TextFormField(
                          controller: mobilecontroller,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (value) {
                            if (value!.length != 10)
                              return 'Mobile Number must be of 10 digit';
                            else
                              return null;
                          },
                          decoration: new InputDecoration(
                            errorStyle:
                                TextStyle(fontSize: 12.0, color: Colors.yellow),
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

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xff07D3DF),
                      child: TextButton(
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            circle(context);
                            send_mobile_otp(mobilecontroller.text);
                          }
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => otp_screen()));
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

                  /*Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => female_home()));
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Vendor Login',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff07D3DF),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),*/

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => login()));
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: "Already have an account?  ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  )),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff07D3DF),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }

  send_mobile_otp(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl = "https://hookupindia.in/hookup/ApiController/saveUser";
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
            var user_id = mapRes["data"]["user_id"].toString();
            print("user_id $user_id");
            setState(() {
              var getotp = otpdetail;
              prefs.setString("new_account", "new_account");
              prefs.setString("mobile_number", mobile);
              prefs.setInt("otp_found", getotp);
              prefs.setString("user_id", user_id);
            });
            // Fluttertoast.showToast(
            //     msg: mapRes["message"],
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 1
            // );
            userdata(user_id);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => otp_screen()));
          } else {
            Fluttertoast.showToast(
                msg: mapRes["message"],
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
    request.fields['UserId'] = UserId;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print("onValue1${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var emaildetail = mapRes["commandResult"]["data"]["Email"];
          var namedetail = mapRes["commandResult"]["data"]["Name"];
          var Mobile = mapRes["commandResult"]["data"]["Mobile"];
          setState(() {
            prefs.setString("email_id", "$emaildetail");
            prefs.setString("name_user", "$namedetail");
            prefs.setString("Mobile", "$Mobile");
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