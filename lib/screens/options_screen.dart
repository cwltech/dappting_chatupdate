import 'dart:convert';
import 'dart:ui';

import 'package:dapp/constants/app.keys.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/payment_stripe.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../invitevideocall.dart';
import '../providers/profile_deatils_provider.dart';
import '../show_profile.dart';

class OptionsScreen extends StatefulWidget {
  final int? index;

  const OptionsScreen({Key? key, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OptionsScreen();
  }
}

class _OptionsScreen extends State<OptionsScreen> {
  var getuser;
  var membership;
  var user_id;
  Razorpay? razorpay;
  int payment = 0;
  String payment_id = "";
  String plan_id = '';
  String balance = "";
  List<bool> likes = [true, false, false, true, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    context.read<hostlist_provider>().host_list(user_id);
    context.read<profile_details_provider>().profile_details_list(user_id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer2<hostlist_provider, profile_details_provider>(
        builder: (context, value, value2, child) {
          return value.map["data"]["HostList"] != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Center(
                              //alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height / 2,
                                    left: 10,
                                    right: 10,
                                    bottom: 0),
                                //child: Opacity(
                                child: value.map["data"]["HostList"] != null
                                    ? Container(
                                        //alignment: Alignment.bottomCenter,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        color: const Color(0xffCC0000)
                                            .withOpacity(0.4),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    top: 7,
                                                    bottom: 0,
                                                    right: 20),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: () async {
                                                                SharedPreferences
                                                                    prefs =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                prefs.setString(
                                                                    "host_id",
                                                                    value.map[
                                                                            "data"]
                                                                            [
                                                                            "HostList"]
                                                                            [
                                                                            widget.index]
                                                                            [
                                                                            "user_id"]
                                                                        .toString());
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                show_profile()));
                                                              },
                                                              child: value.map["data"]["HostList"]
                                                                              [
                                                                              widget.index]
                                                                          [
                                                                          "profile_image"] !=
                                                                      null
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child: Image
                                                                          .network(
                                                                        value.map["data"]["HostList"][widget.index]
                                                                            [
                                                                            "profile_image"],
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            40,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ))
                                                                  : const Icon(Icons
                                                                      .person)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5.0),
                                                            child: Text(
                                                              value.map["data"][
                                                                              "HostList"]
                                                                          [
                                                                          widget
                                                                              .index]
                                                                      [
                                                                      "name"] ??
                                                                  "",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      FavoriteButton(
                                                        isFavorite: value
                                                                    .map["data"]
                                                                        [
                                                                        "HostList"]
                                                                        [widget
                                                                            .index]
                                                                        [
                                                                        "like_status"]
                                                                    .toString() ==
                                                                "1"
                                                            ? true
                                                            : false,
                                                        iconDisabledColor:
                                                            Colors.white,
                                                        valueChanged:
                                                            (_isFavorite) {
                                                          setState(() {
                                                            if (_isFavorite ==
                                                                true) {
                                                              like(
                                                                  user_id,
                                                                  value.map[
                                                                          "data"]
                                                                          [
                                                                          "HostList"]
                                                                          [
                                                                          widget
                                                                              .index]
                                                                          [
                                                                          "user_id"]
                                                                      .toString());
                                                            } else {
                                                              dislikelike(
                                                                  user_id,
                                                                  value.map[
                                                                          "data"]
                                                                          [
                                                                          "HostList"]
                                                                          [
                                                                          widget
                                                                              .index]
                                                                          [
                                                                          "user_id"]
                                                                      .toString());
                                                            }

                                                            print(
                                                                'Is Favorite : $_isFavorite');
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 10,
                                                            top: 0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "India",
                                                        style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.9),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Opacity(
                                                    opacity: 0.9,
                                                    child: Container(
                                                      // color: Colors.green.withOpacity(5),
                                                      width: 50,
                                                      height: 17,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: value.map["data"]
                                                                        [
                                                                        "HostList"]
                                                                        [widget
                                                                            .index]
                                                                        [
                                                                        "live_status"]
                                                                    .toString() ==
                                                                "0"
                                                            ? const Color(
                                                                    0xffCC0000)
                                                                .withOpacity(
                                                                    0.4)
                                                            : Colors.green
                                                                .withOpacity(
                                                                    0.4),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          value.map["data"][
                                                                          "HostList"]
                                                                          [
                                                                          widget
                                                                              .index]
                                                                          [
                                                                          "live_status"]
                                                                      .toString() ==
                                                                  "0"
                                                              ? "Offline"
                                                              : "Online",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0, top: 0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Video Call @ 20 \u{1FA99}/ min",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff07D3DF),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: () async {
                                                                print(
                                                                    "HostListv ${value.map["data"]["HostList"][widget.index]["unique_id"]}");
                                                                //setState(() {
                                                                value2.map["data"]["userData"]
                                                                            [
                                                                            "coins"] ==
                                                                        0
                                                                    ? showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                BackdropFilter(
                                                                          filter: ImageFilter.blur(
                                                                              sigmaX: 7,
                                                                              sigmaY: 7),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: 270,
                                                                              child: Dialog(
                                                                                backgroundColor: Colors.transparent,
                                                                                child: ListView.builder(
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    shrinkWrap: true,
                                                                                    itemCount: membership.length,
                                                                                    itemBuilder: (ctx, i) {
                                                                                      return _dialog(context, i);
                                                                                    }),
                                                                                //child: _dialogContent(context)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                BackdropFilter(
                                                                          filter: ImageFilter.blur(
                                                                              sigmaX: 7,
                                                                              sigmaY: 7),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: 170,
                                                                              child: CallInvitationPage(
                                                                                localUserID: int.parse(value2.map["data"]["userData"]["unique_id"]),
                                                                                inivites: value.map["data"]["HostList"][widget.index]["unique_id"],
                                                                                username: value2.map["data"]["userData"]["fname"],
                                                                                user_id: value2.map["data"]["userData"]["user_id"],
                                                                                vendor_id: value.map["data"]["HostList"][widget.index]["user_id"],
                                                                                type: "user",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                // //Container();
                                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                                //     CallInvitationPage(
                                                                //       localUserID: user_id,
                                                                //       inivites: value.map["data"]["HostList"][widget.index]["user_id"],
                                                                //       username: user_id,
                                                                //     )));
                                                              },
                                                              child: const Icon(
                                                                Icons.videocam,
                                                                color: Colors
                                                                    .white,
                                                                size: 38,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator()),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              : const Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()),
                );
        },
      ),
    );
  }

  Widget _dialog(BuildContext context, int index) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8, top: 10, bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffCC0000).withOpacity(0.4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                                text: "My Balance: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                )),
                            WidgetSpan(
                                child: Image.asset(
                              "assets/smallcoin.png",
                              width: 15,
                              height: 15,
                            )),
                            TextSpan(
                                text: balance,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.clear_rounded,
                              size: 20,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                        color: Colors.white,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/bigcoin.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                      child: Text(
                    membership[index]["coins"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "₹ " + membership[index]["price"],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xffCC0000).withOpacity(0.4),
          ),
          child: Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xffCC0000), width: 2)),
            child: InkWell(
              onTap: () {
                setState(() {
                  plan_id = membership[index]["id"].toString();
                });

                payment_stripe.makepayment(
                    context, membership[index]["price"], user_id, "1", plan_id);

                // openCheckout(
                //     int.parse(membership["HostList"][index]["PlanPrice"]));
              },
              child: const Center(
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 13),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    get_blogdetails(context);
    razorpay = Razorpay();

    // razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    // razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    // razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString(AppKeys.loginUserID);
      getmembership(user_id);
    });
    print("blodid $user_id");
  }

  getmembership(String userId) async {
    //replace your restFull API here.
    String url = "https://hookupindia.in/hookup/ApiController/regularPackage";
    final response = await http.get(Uri.parse(url));
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.fields['user_id'] = userId;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        if (response.statusCode == 200) {
          try {
            Map map = json.decode(onValue.body);

            setState(() {
              membership = map["data"];
              print("membershipmembership$membership");
            });
          } catch (e) {
            print("response$e");
          }
        } else {}
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay!.clear();
  }

  void openCheckout(int amount) {
    var options = {
      "key": "rzp_test_7XLPQrd4ZugiQI",
      "amount": amount * 100,
      "name": "Hookup India",
      "description": "Payment for Join",
      "prefill": {"contact": "", "email": ""},
      "external": {
        "wallets": ["paytm"]
      }
    };

    // try{
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    razorpay!.open(options);
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Pament success ${response.paymentId}");
    Fluttertoast.showToast(
        msg: "Payment success",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
    setState(() {
      payment = 1;
      payment_id = response.paymentId.toString();
      print("paymentv $payment");
      circle(context);
      //orderhistory(user_id, plan_id, payment_id);
    });
    //Navigator.pop(context);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Pament error");
    Fluttertoast.showToast(
        msg: "Payment error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(
        msg: "External Wallet",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  /*-----------> Like Api <-------------*/
  like(String UserId, String friend_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postUrl = "https://hookupindia.in/hookup/ApiController/likeUser";
    print("stringrequest");
    print("user_id $UserId");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = UserId;
    request.fields['friend_id'] = friend_id;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print("onValue1like ${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var success = mapRes["status"];
          var message = mapRes["message"];
          if (success == "1") {}
          setState(() {});
        } catch (e) {
          print("response$e");
        }
      });
    });
  }

  /*-----------> Dislike Api <-------------*/
  dislikelike(String UserId, String friend_id) async {
    String postUrl = "https://hookupindia.in/hookup/ApiController/unlikeUser";
    print("stringrequest");
    print("user_id $UserId");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = UserId;
    request.fields['friend_id'] = friend_id;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print("onValue1like ${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var success = mapRes["status"];
          var message = mapRes["message"];
          if (success == "1") {}
          setState(() {});
        } catch (e) {
          print("response$e");
        }
      });
    });
  }
}
