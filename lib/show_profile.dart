import 'dart:convert';

import 'package:dapp/home_activity.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/pages/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class show_profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _profile_show();
  }
}

class _profile_show extends State<show_profile> {
  bool gift = true;
  double _opacity = 0.9;
  var host_id;
  var user_id;
  var host_details;
  final GlobalKey expansionTileKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getuser(context);
  }

  getuser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    host_id = (prefs.getString('host_id') ?? "");
    user_id = (prefs.getString('user_id') ?? "");
    print("user_id $host_id $user_id");
    this.hostdetails(host_id);
  }

  Future<String> hostdetails(String user_id) async {
    String postUrl = "https://hookupindia.in/hookup/ApiController/userDetail";
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = user_id;

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Map mapRes = json.decode(onValue.body);
          var status = mapRes["status"];
          setState(() {
            host_details = mapRes["data"]["userData"];
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
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => chat_home_list(
                              type: "user",
                            )));
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffCC0000),
                    ),
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xffCC0000), width: 2)),
                      child: const Center(
                        child: Text(
                          "Message",
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffCC0000),
                  ),
                  child: Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xffCC0000), width: 2)),
                    child: const Center(
                      child: Text(
                        "Video call 20coin/ min",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10),
                      ),
                      // TextButton.icon(     // <-- TextButton
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.download,
                      //     size: 24.0,
                      //   ),
                      //   label: Text('Download'),
                      // ),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: host_details != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Stack(
                        //alignment: Alignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                host_details["profile_image"],
                                height: 300,
                                fit: BoxFit.cover,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 25,
                                      color: Colors.white,
                                    )),
                                InkWell(
                                  onTap: () {
                                    showGeneralDialog(
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        transitionBuilder:
                                            (context, a1, a2, widget) {
                                          return Transform.scale(
                                            scale: a1.value,
                                            child: Opacity(
                                              opacity: a1.value,
                                              child: AlertDialog(
                                                shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0)),
                                                title: InkWell(
                                                    onTap: () {
                                                      circle(context);
                                                      block_user(
                                                          user_id, host_id);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Row(
                                                      children: const <Widget>[
                                                        Text(
                                                          'Block',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffCC0000),
                                                              fontSize: 14),
                                                        ),
                                                        Icon(
                                                          Icons.block,
                                                          color:
                                                              Color(0xffCC0000),
                                                          size: 24,
                                                        )
                                                      ],
                                                    )),
                                                content: InkWell(
                                                  onTap: () {
                                                    circle(context);
                                                    report_user(
                                                        user_id, host_id);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    children: const [
                                                      Text('Report'),
                                                      Icon(
                                                        Icons.report,
                                                        color:
                                                            Color(0xffCC0000),
                                                        size: 24,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        context: context,
                                        pageBuilder:
                                            (context, animation1, animation2) {
                                          return const Center();
                                        });
                                  },
                                  child: const Icon(
                                    Icons.more_vert,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Positioned(
                          //   top: 100,
                          //   left: MediaQuery.of(context).size.width * 0.8,
                          //   right: -10,
                          //   child: Container(
                          //     height: 200,
                          //     child: ListView.builder(
                          //       itemExtent: 40,
                          //       shrinkWrap: true,
                          //       itemCount: 6,
                          //       itemBuilder: (context, i) {
                          //         return ListTile(
                          //           leading: Image.asset(
                          //             "assets/profilepp.png",
                          //             width: 30,
                          //             height: 30,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 8, left: 20),
                        child: Text(
                          host_details["fname"] + " " + host_details["lname"],
                          style: const TextStyle(
                              color: Color(0xffCC0000),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, bottom: 8, left: 20),
                        child: Text(
                          "ID:${host_details["unique_id"]}",
                          style: const TextStyle(
                            color: Color(0xffCC0000),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, bottom: 8, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/india.png"),
                            const Text(
                              " IN",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              // color: Colors.green.withOpacity(5),
                              width: 50,
                              height: 17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: host_details["live_status"] == "0"
                                    ? const Color(0xffCC0000).withOpacity(0.4)
                                    : Colors.green.withOpacity(0.4),
                              ),
                              child: Center(
                                child: Text(
                                  host_details["live_status"] == "0"
                                      ? "Offline"
                                      : "Online",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: host_details["live_status"] == "0"
                                        ? const Color(0xffCC0000)
                                        : const Color(0xff05FF00),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          key: expansionTileKey,
                          onExpansionChanged: (value) {
                            if (value) {
                              _scrollToSelectedContent(
                                  expansionTileKey: expansionTileKey);
                            }
                          },
                          title: const Text(
                            "Basic Information",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              // color: Colors.black
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 0, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Nick Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${host_details["fname"]}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xffCC0000),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            /* Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Birthday",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "24/jan/2000",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffCC0000)),
                                  ),
                                ],
                              ),
                            ),*/
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "City",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Delhi",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffCC0000)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Language",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "English",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffCC0000)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Hair Color",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    host_details["hair_color"],
                                    style: const TextStyle(
                                        fontSize: 14, color: Color(0xffCC0000)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Body Type",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    host_details["body_type"],
                                    style: const TextStyle(
                                        fontSize: 14, color: Color(0xffCC0000)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 20, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Interests",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "-",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffCC0000)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 8, left: 20, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Gifts",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      )),
                                  TextSpan(
                                      text:
                                          "  (Recieved ${host_details["virtual_gift"].length.toString()})",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  gift = false;
                                });
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    "All gifts",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffCC0000),
                                        fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                    color: Color(0xffCC0000),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Offstage(
                        offstage: gift,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          height: 200.0,
                          child: ListView.builder(
                              itemCount: host_details["virtual_gift"].length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 150.0,
                                  color: Colors.transparent,
                                  child: Image.network(
                                      host_details["virtual_gift"][index]
                                          ["gift"]),
                                );
                              }),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ],
    );
  }

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  block_user(String UserId, String friend_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl = "https://hookupindia.in/hookup/ApiController/blockUser";
    print("stringrequest");
    print("user_id $UserId");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
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

  report_user(String UserId, String friend_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl = "https://hookupindia.in/hookup/ApiController/spamUser";
    print("stringrequest");
    print("user_id $UserId");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
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
