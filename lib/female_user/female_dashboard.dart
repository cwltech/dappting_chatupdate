import 'dart:convert';
import 'dart:ui';

import 'package:dapp/female_user/female_edit_profile.dart';
import 'package:dapp/invitevideocall.dart';
import 'package:dapp/providers/female_details_provider.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class female_dash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _female_d();
  }
}

class _female_d extends State<female_dash> with WidgetsBindingObserver {
  bool _switchValue = true;
  var user_id;
  ValueNotifier<int> dialogTrigger = ValueNotifier(1);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    get_blogdetails(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    dialogTrigger.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print('app inactive, is lock screen: ${await isLockScreen()}');
      livestatus(user_id, "0");
    } else if (state == AppLifecycleState.resumed) {
      print('app resumed');
      context.read<profile_details_provider>().profile_details_list(user_id);
    }
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
      print("blodid $user_id");
      context.read<profile_details_provider>().profile_details_list(user_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<profile_details_provider>().profile_details_list(user_id);
    context.read<female_details_provider>().female_details(user_id);
    return Stack(
      children: [
        Opacity(
            opacity: 0.9,
            child: Image.asset('assets/homeheart.png',
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover)),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Consumer2<profile_details_provider, female_details_provider>(
                builder: (context, value, value2, child) {
              print("valuep$value");
              return value.map.length == 0 && !value.error
                  ? CircularProgressIndicator()
                  : value.error
                      ? Text("Opps SOmething went wrong")
                      : value.map["data"]["userData"] != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),

                                //value.map["data"]["userData"]["address"] ==
                                //     "" ||
                                // value.map["data"]["userData"]
                                //         ["fname"] ==
                                //     "" ||
                                // value.map["data"]["userData"]
                                //         ["country"] ==
                                //     null

                                //     ? ValueListenableBuilder(
                                //         valueListenable: dialogTrigger,
                                //         builder: (ctx, value, child) {
                                //           Future.delayed(
                                //               const Duration(seconds: 0), () {
                                //             showDialog(
                                //                 barrierDismissible: true,
                                //                 context: ctx,
                                //                 builder: (ctx) {
                                //                   return WillPopScope(
                                //                     onWillPop: () async => true,
                                //                     child: AlertDialog(
                                //                       shape: RoundedRectangleBorder(
                                //                           borderRadius:
                                //                               BorderRadius.all(
                                //                                   Radius
                                //                                       .circular(
                                //                                           20))),
                                //                       title: const Text(
                                //                         'Complete your Profile first !!..',
                                //                         style: TextStyle(
                                //                             fontWeight:
                                //                                 FontWeight.w500,
                                //                             color: Color(
                                //                                 0xffCC0000)),
                                //                       ),
                                //                       content: Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .center,
                                //                         children: [
                                //                           Container(
                                //                             width: MediaQuery.of(
                                //                                         context)
                                //                                     .size
                                //                                     .width *
                                //                                 0.4,
                                //                             height: 42,
                                //                             decoration:
                                //                                 BoxDecoration(
                                //                               borderRadius:
                                //                                   BorderRadius
                                //                                       .circular(
                                //                                           16),
                                //                               color: Color(
                                //                                   0xff07D3DF),
                                //                             ),
                                //                             child: TextButton(
                                //                               onPressed: () {
                                //                                 // Navigator.pop(
                                //                                 //     context);
                                //                                 Navigator.pop(
                                //                                     ctx);
                                //                                 // Navigator.of(
                                //                                 //         context,
                                //                                 //         rootNavigator:
                                //                                 //             true)
                                //                                 //     .pop();
                                //                                 //setState(() {});
                                //                                 Navigator.push(
                                //                                   context,
                                //                                   MaterialPageRoute(
                                //                                       builder:
                                //                                           (context) =>
                                //                                               female_edit_profile()),
                                //                                 );
                                //                               },
                                //                               child: Text(
                                //                                 "Complete Profile",
                                //                                 textAlign:
                                //                                     TextAlign
                                //                                         .center,
                                //                                 style:
                                //                                     TextStyle(
                                //                                   color: Colors
                                //                                       .white,
                                //                                   fontSize: 15,
                                //                                   fontWeight:
                                //                                       FontWeight
                                //                                           .bold,
                                //                                   backgroundColor:
                                //                                       Color(
                                //                                           0xff07D3DF),
                                //                                 ),
                                //                               ),
                                //                               // color: Colors.white,
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       ),
                                //                     ),
                                //                   );
                                //                 });
                                //           });
                                //           return const SizedBox();
                                //         })
                                //     : SizedBox(),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Front image
                                          SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: value.map["data"]
                                                                ["userData"]
                                                            ["profile_image"] !=
                                                        null
                                                    ? Image.network(
                                                        value.map["data"]
                                                                ["userData"]
                                                            ["profile_image"],
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Icon(Icons.person),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20.0, bottom: 8),
                                          child: Center(
                                            child: Text(
                                              value.map["data"]["userData"]
                                                  ["fname"],
                                              style: TextStyle(
                                                  color: Color(0xffCC0000),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, bottom: 8),
                                          child: Center(
                                            child: Text(
                                              "ID: ${value.map["data"]["userData"]["unique_id"]}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff07D3DF),
                                              Color.fromARGB(255, 91, 235, 245),
                                              Color.fromARGB(
                                                  255, 167, 230, 235),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, left: 6),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Total Likes",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //     width: 10,
                                                  //     height: 10,
                                                  //     child: Image.asset(
                                                  //       "assets/whitefwrd.png",
                                                  //       color: Colors.black,
                                                  //     )),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6, left: 6),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      value2.map["data"][
                                                                  "total_likes"]
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    //Image.asset("assets/smallcoin.png",width: 12,height: 12,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFFEB974),
                                                Color(0xFF944C1E),
                                                Color(0xFF772F1A),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            //color:Color(0xff07D3DF).withOpacity(0.3),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0, left: 6),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Total Gift ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //     width: 10,
                                                      //     height: 10,
                                                      //     child: Image.asset(
                                                      //         "assets/whitefwrd.png")),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6, left: 6),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Total Gift ${value2.map["data"]["count_recieve_gift"].toString()}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      //Image.asset("assets/smallcoin.png",width: 12,height: 12,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  child: InkWell(
                                    onTap: () {
                                      giftshow(context,
                                          value.map["data"]["userData"]);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFCC0000),
                                            Color(0xFFD02525),
                                            Color(0xFFD23737),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        //color:Color(0xff07D3DF).withOpacity(0.3),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.card_giftcard,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              " Check your Gifts",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "My Data Today",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            value.map["data"]["userData"]
                                                        ["live_status"] ==
                                                    "1"
                                                ? "Working"
                                                : "Working Off",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: value.map["data"]
                                                                ["userData"]
                                                            ["live_status"] ==
                                                        "1"
                                                    ? Colors.green
                                                    : Color(0xffCC0000),
                                                fontSize: 12),
                                          ),
                                          Transform.scale(
                                            scale: 0.8,
                                            child: CupertinoSwitch(
                                              value: value.map["data"]
                                                              ["userData"]
                                                          ["live_status"] ==
                                                      "1"
                                                  ? true
                                                  : false,
                                              trackColor:
                                                  const Color(0xffCC0000),
                                              onChanged: (value) {
                                                setState(() {
                                                  _switchValue = value;
                                                  livestatus(
                                                      user_id,
                                                      value == true
                                                          ? "1"
                                                          : "0");
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            " Gifts",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             female_balance()));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      value2.map["data"][
                                                                  "count_recieve_gift"]
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            " Gifts coins",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    value2.map["data"][
                                                                "total_gift_coins"]
                                                            .toString() ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Colors.black,
                                                    size: 12,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Offstage(
                                  offstage: false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              " Calls",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      value2.map["data"][
                                                                  "total_calls"]
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              " Calls coins",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      value2.map["data"][
                                                                  "total_video_coins"]
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Offstage(
                                  offstage: false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              " Wallet",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      value2.map["data"][
                                                                  "total_amount_in_wallet"]
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              " Total coins",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      value2.map["data"][
                                                                  "total_coins"]
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Offstage(
                                  offstage: true,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 30),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffCC0000)
                                              .withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextButton(
                                        onPressed: () {
                                          //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => home_home()));
                                        },
                                        child: Text(
                                          value2.map["data"]["total_coins"]
                                                  .toString() ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            //backgroundColor:  Color(0xffCC0000).withOpacity(0.2),
                                          ),
                                        ),
                                        // color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                value.map["data"]["userData"]
                                                ["profile_video"] ==
                                            "" ||
                                        value.map["data"]["userData"]
                                                ["profile_image"] ==
                                            "" ||
                                        value.map["data"]["userData"]
                                                ["address"] ==
                                            ""
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        female_edit_profile()));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xff5AFF15),
                                                  Color(0xFF00B712),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              //color:Color(0xff07D3DF).withOpacity(0.3),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Complete Your Profile",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),

                                CallInvitationPage(
                                  localUserID: int.parse(value.map["data"]
                                      ["userData"]["unique_id"]),
                                  inivites: "",
                                  username: value.map["data"]["userData"]
                                      ["fname"],
                                  user_id: "",
                                  vendor_id: "",
                                  type: "host",
                                ),
                              ],
                            )
                          : Center(child: CircularProgressIndicator());
            }),
          ),
        )
      ],
    );
  }

  livestatus(String userId, String live_status) async {
    //replace your restFull API here.
    String url =
        "https://hookupindia.in/hookup/ApiController/updateLiveWorking";
    final response = await http.get(Uri.parse(url));
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.fields['user_id'] = userId;
    request.fields['live_status'] = live_status;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        if (response.statusCode == 200) {
          try {
            Map map = json.decode(onValue.body);

            setState(() {});
          } catch (e) {
            print("response$e");
          }
        } else {}
      });
    });
  }

  giftshow(BuildContext context, var host_details) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.white.withOpacity(0.85),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          height: 250.0,
          color: Colors.transparent,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Gift Received",
                  style: TextStyle(
                      color: Color(0xffCC0000),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                height: 190.0,
                color: Colors.transparent,
                child: ListView.builder(
                    itemCount: host_details["virtual_gift"].length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 150.0,
                        color: Colors.transparent,
                        child: Image.network(
                            host_details["virtual_gift"][index]["gift"]),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  profilecomplete(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: const Text(
                'Complete your Profile first !!..',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Color(0xffCC0000)),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xff07D3DF),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pop(
                        //     context);
                        Navigator.pop(context);
                        // Navigator.of(
                        //         context,
                        //         rootNavigator:
                        //             true)
                        //     .pop();
                        //setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => female_edit_profile()),
                        );
                      },
                      child: Text(
                        "Complete Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Color(0xff07D3DF),
                        ),
                      ),
                      // color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
