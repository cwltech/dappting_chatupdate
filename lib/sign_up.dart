import 'dart:convert';

import 'package:dapp/home_activity.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class sign_up extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _sign_up();
  }
}

class _sign_up extends State<sign_up> {
  double _opacity = 0.9;
  String? countryval;
  List mycountry = [];
  String? stateval;
  List statelist = [];
  List citylist = [];
  String? cityval = null;
  var fname = new TextEditingController();
  var lname = new TextEditingController();
  var emailid = new TextEditingController();
  var username = new TextEditingController();
  var mobile = new TextEditingController();
  var pincode = new TextEditingController();
  var address = new TextEditingController();

  var user_id;

  void initState() {
    super.initState();
    // loading(context);
    context.read<country_provider>().country_list();
    Future.delayed(Duration(seconds: 2), () {});
    get_blogdetails(context);
    // isNumeric("8076799976");
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
    });
    print("blodid $user_id");
  }

  @override
  Widget build(BuildContext context) {
    context.read<country_provider>().country_list();

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
                opacity: _opacity,
                child: Image.asset('assets/hearts_1.png',
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover)),
          ]),
        ],
      )),
      Scaffold(
          // backgroundColor: Color(0xffCC0000),
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          // ),
          body: SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<country_provider>().country_list();
              },
              child:
                  Consumer<country_provider>(builder: (context, value, child) {
                mycountry = value.map["data"];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(
                        child: Image.asset(
                          "assets/logo.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .42,
                            child: TextField(
                              controller: fname,
                              style: TextStyle(color: Colors.white),
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                hintText: "First Name",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .42,
                            child: TextField(
                              controller: lname,
                              style: TextStyle(color: Colors.white),
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                hintText: "Last Name",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: emailid,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          hintText: "Email I'd",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: username,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          hintText: "User name",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 20),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            // margin: const EdgeInsets.all(12.0),
                            // padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.grey.withOpacity(0.8),
                                  style: TextStyle(color: Colors.white),
                                  isExpanded: true,
                                  hint: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      "Country",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    // Add this
                                    Icons.keyboard_arrow_down_sharp,
                                    // Add this
                                    color: Colors.white,
                                    size: 30, // Add this
                                  ),
                                  value: countryval,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      countryval = newValue;
                                      circle(context);
                                      print("countryval $countryval");
                                      state_c(int.parse(countryval!));
                                    });
                                    print(countryval);
                                  },
                                  items: mycountry.map((item) {
                                    return DropdownMenuItem(
                                      child: new Text(item['country']),
                                      value: item['id'].toString(),
                                      // value: item['id'].toString(),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 20),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            // margin: const EdgeInsets.all(12.0),
                            // padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.grey.withOpacity(0.8),
                                  style: TextStyle(color: Colors.white),
                                  hint: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      "State",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    // Add this
                                    Icons.keyboard_arrow_down_sharp,
                                    // Add this
                                    color: Colors.white,
                                    size: 30, // Add this
                                  ),
                                  value: stateval,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      stateval = newValue;
                                      circle(context);
                                      city_c(int.parse(stateval!));
                                    });
                                    print(stateval);
                                  },
                                  items: statelist.map((item) {
                                    return DropdownMenuItem(
                                      child: new Text(
                                        item['state'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: item['id'].toString(),
                                      // value: item['id'].toString(),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    // margin: const EdgeInsets.all(12.0),
                                    // padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                      },
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor:
                                              Colors.grey.withOpacity(0.8),
                                          style: TextStyle(color: Colors.white),
                                          hint: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Text(
                                              "City",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          icon: Icon(
                                            // Add this
                                            Icons.keyboard_arrow_down_sharp,
                                            // Add this
                                            color: Colors.white,
                                            size: 30, // Add this
                                          ),
                                          value: cityval,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              cityval = newValue;
                                            });
                                            print(cityval);
                                          },
                                          items: citylist.map((item) {
                                            return DropdownMenuItem(
                                              child: new Text(
                                                item['city'],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              value: item['id'].toString(),
                                              // value: item['id'].toString(),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: pincode,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          hintText: "Pincode",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: address,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          hintText: "Address",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xff07D3DF),
                        child: TextButton(
                          onPressed: () {
                            circle(context);
                            // sign_up(fname.text, lname.text, emailid.text, user_id, username.text,
                            //     countryval!, stateval!, cityval!, pincode.text, address.text,"User");
                            update_profile(
                                fname.text,
                                lname.text,
                                emailid.text,
                                user_id,
                                username.text,
                                countryval!,
                                stateval!,
                                cityval!,
                                pincode.text,
                                address.text,
                                "User",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "");
                          },
                          child: Text(
                            "SIGN UP",
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
                );
              }),
            ),
          )),
    ]);
  }

  Future<String> state_c(int country) async {
    stateval = null;
    String postUrl = "https://hookupindia.in/hookup/ApiController/stateList";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['country'] = country.toString();
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          Map mapRes = json.decode(onValue.body);
          setState(() {
            statelist = mapRes["data"];
          });
          print("response$statelist");
        } catch (e) {
          print("response$e");
        }
      });
    });
    return country.toString();
  }

  Future<String> city_c(int state) async {
    cityval = null;
    String postUrl = "https://hookupindia.in/hookup/ApiController/cityList";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['state'] = state.toString();
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          Map mapRes = json.decode(onValue.body);
          setState(() {
            citylist = mapRes["data"];
          });
          print("response$citylist");
        } catch (e) {
          print("response$e");
        }
      });
    });
    return state.toString();
  }

  sign_up(
      String first_name,
      String last_name,
      String email_address,
      String user_id,
      String user_name,
      String country,
      String state,
      String city,
      String pincode,
      String address,
      String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/updateUserProfile";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['first_name'] = first_name;
    request.fields['last_name'] = last_name;
    request.fields['email_address'] = email_address;
    request.fields['user_id'] = user_id;
    request.fields['user_name'] = user_name;
    request.fields['country'] = country;
    request.fields['state'] = state;
    request.fields['city'] = city;
    request.fields['pincode'] = pincode;
    request.fields['address'] = address;
    //request.fields['type'] = type;

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          print("onValue1${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var status = mapRes["status"];
          if (status == "1") {
            setState(() {
              Fluttertoast.showToast(
                  msg: mapRes["message"],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => home_home()));
            });
          } else {
            Fluttertoast.showToast(
                msg: mapRes["message"],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          }
          //   print("getdatata$email $name)");

        } catch (e) {
          print("response$e");
        }
      });
    });
  }

  update_profile(
      String first_name,
      String last_name,
      String email_address,
      String user_id,
      String user_name,
      String country,
      String state,
      String city,
      String pincode,
      String address,
      String type,
      String profile_image,
      String profile_video,
      String hair_color,
      String eye_color,
      String height,
      String weight,
      String body_type,
      String ethnicity,
      String my_appearance,
      String drink,
      String smoke,
      String marital_status,
      String children_have,
      String children_want,
      String occupation,
      String relationship_looking_for,
      String education,
      String english_ability,
      String religion,
      String gallery) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/updateUserProfile";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['first_name'] = first_name;
    request.fields['type'] = "User";
    request.fields['last_name'] = last_name;
    request.fields['email_address'] = email_address;
    request.fields['user_id'] = user_id;
    request.fields['user_name'] = user_name;
    request.fields['country'] = country;
    request.fields['state'] = state;
    request.fields['city'] = city;
    request.fields['pincode'] = pincode;
    request.fields['address'] = address;
    //request.fields['type'] = type;
    request.fields['profile_image'] = profile_image;
    request.fields['profile_video'] = profile_video;
    request.fields['hair_color'] = hair_color;
    request.fields['eye_color'] = eye_color;
    request.fields['height'] = height;
    request.fields['weight'] = weight;
    request.fields['body_type'] = body_type;
    request.fields['ethnicity'] = ethnicity;
    request.fields['my_appearance'] = my_appearance;
    request.fields['drink'] = drink;
    request.fields['smoke'] = smoke;
    request.fields['marital_status'] = marital_status;
    request.fields['children_have'] = children_have;
    request.fields['children_want'] = children_want;
    request.fields['occupation'] = occupation;
    request.fields['relationship_looking_for'] = relationship_looking_for;
    request.fields['education'] = education;
    request.fields['english_ability'] = english_ability;
    request.fields['religion'] = religion;
    request.fields['gallery'] = gallery;

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          print("onValue1${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var status = mapRes["status"];
          if (status == "1") {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => home_home()));
            });
          } else {
            Fluttertoast.showToast(
                msg: mapRes["message"],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          }
          //   print("getdatata$email $name)");

        } catch (e) {
          print("response$e");
        }
      });
    });
  }
}


//https://www.figma.com/file/4BeISemeJcYA2qt1tub2tX/Dating-App?node-id=50%3A289