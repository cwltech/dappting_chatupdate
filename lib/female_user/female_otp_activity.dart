import 'dart:convert';
import 'package:dapp/female_user/female_home_activity.dart';
import 'package:dapp/home_activity.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class female_otp_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _otp_screen();
  }
}

class _otp_screen extends State<female_otp_screen> {
  String phonenum = "";
  var otp_val;
  var getdata;
  String enterotp = "";
  String new_acc = "";
  @override
  void initState() {
    super.initState();
    // loading(context);
    Future.delayed(Duration(seconds: 2), () {});
    get_otp(context);
    // isNumeric("8076799976");
  }

  get_otp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //  Navigator.pop(context);
      //new_acc = prefs.getString("new_account")!;
      phonenum = prefs.getString('mobile_number')!;
      otp_val = prefs.getInt("otp_found");
      //isNumeric(phonenum);
      // new_acc = "new_account";
    });
    print("phonem$phonenum");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
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
                opacity: 0.9,
                child: Image.asset('assets/hearts_1.png',
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover)),
          ]),
        ],
      )),
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: Text(
            "Login / Signup",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'lato',
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: Text(
                  "Enter Verification Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Center(
                child: Text(
                  "We have sent you a 6 digit verification code on",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Center(
                child: Text(
                  "$phonenum",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
              child: OtpTextField(
                textStyle: TextStyle(color: Colors.white),
                numberOfFields: 6,
                borderColor: Color(0xff07D3DF),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                cursorColor: Color(0xff07D3DF),
                focusedBorderColor: Color(0xff07D3DF),
                //   enabledBorderColor: Color(0xffECAE0F),
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  setState(() {
                    enterotp = verificationCode;
                  });
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text("Verification Code"),
                  //         content: Text('Code entered is $verificationCode'),
                  //       );
                  //     });
                }, // end onSubmit
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    circle(context);
                    send_mobile_otp(phonenum);
                  },
                  child: Text(
                    "Resend OTP",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xff07D3DF),
                child: TextButton(
                  onPressed: () {
                    match_otp(context);
                  },
                  child: Text(
                    "Login",
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
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 30),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        loading(context);
                        match_otp(context);
                      });

                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),//empty container can use inside of widget
                      height: 50,
                      alignment: Alignment.center,
                      //changebtn?Icon(Icons.done,color: Colors.white,):
                      child:Text(
                        new_acc=="new_account"?"Sign Up":"Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(int.parse("0xff${colors_color.main_theme}")),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),*/
          ],
        ),
      ),
    ]);
  }

  match_otp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (otp_val.toString() == enterotp) {
      print("correct");
      prefs.setBool("isLoggedInvendor", true);
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => female_home()));
    } else {
      // Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "OTP is invalid",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
      print("otp_val$otp_val .....$enterotp");
    }
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
          var success = mapRes["commandResult"]["success"];
          var msg = mapRes["commandResult"]["message"];

          if (success == 1) {
            var blogdetail = mapRes["commandResult"]["data"]["otp"];
            var user_id = mapRes["commandResult"]["data"]["user_id"];
            setState(() {
              getdata = blogdetail;
              prefs.setString("new_account", " ");
              prefs.setString("mobile_number", mobile);
              prefs.setInt("otp_found", getdata);
              prefs.setString("user_id", user_id);
              print("otpuser$user_id");
            });
            userdata(user_id);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => female_otp_screen()));
          } else {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          }
          print("getdatata$getdata)");
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
