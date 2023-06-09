import 'package:dapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'constants/app_constants.dart';

var starttime;
var endtime;

class CallInvitationPage extends StatelessWidget {
  final localUserID;
  final inivites;
  final username;
  final user_id;
  final vendor_id;
  final type;

  CallInvitationPage(
      {Key? key,
      required this.localUserID,
      required this.inivites,
      required this.username,
      required this.user_id,
      required this.vendor_id,
      required this.type})
      : super(key: key);
  final TextEditingController inviteeUsersIDTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("zegolcouddd");
    return ZegoUIKitPrebuiltCallWithInvitation(
      appID: 907425870,
      appSign:
          "d28fae0bae464fe9997491e345a0b163681421a5d2d829224a9efdc06d1e19bd",
      userID: localUserID.toString(),
      userName: username.toString(),
      plugins: [ZegoUIKitSignalingPlugin()],
      requireConfig: (ZegoCallInvitationData data) {
        var config = (data.invitees.length > 1)
            ? ZegoInvitationType.videoCall == data.type
                ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoInvitationType.videoCall == data.type
                ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        // Modify your custom configurations here.

        config.onHangUpConfirmation = (BuildContext context) async {
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xffC50808)!.withOpacity(0.3),
                title: const Text("End Video call",
                    style: TextStyle(color: Colors.white70)),
                content: const Text("Do you want to exit?",
                    style: TextStyle(color: Colors.white70)),
                actions: [
                  ElevatedButton(
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.white70)),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  ElevatedButton(
                    child: const Text("Exit"),
                    onPressed: () {
                      // if (type == "user") {
                      endtime = DateTime.now();
                      //   Future.delayed(const Duration(seconds: 1));
                      var diff = endtime
                          .difference(starttime)
                          .inSeconds; // HINT: you can use .inDays, inHours, .inMinutes or .inSeconds according to your need.
                      print("difftime $diff");
                      coinDeduction(
                        user_id.toString(),
                        vendor_id.toString(),
                        AppConstants.coin_deduction,
                        diff.toString(),
                        starttime.toString(),
                        "",
                      );

                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );
        };
        return config;
      },
      child: yourPage(context),
    );
  }

  Widget yourPage(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 2,
                child: callButton(context, true)),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget inviteeUserIDInput() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
            ],
            decoration: const InputDecoration(
              isDense: true,
              hintText: "Please Enter Invitees ID",
              labelText: "Invitees ID, Separate ids by ','",
            ),
          ),
        ),
      ],
    );
  }

  Widget callButton(BuildContext context, bool isVideoCall) {
    var invitees = getInvitesFromTextCtrl(inivites.toString());
    return ZegoStartCallInvitationButton(
      isVideoCall: isVideoCall,
      invitees: invitees,
      icon: ButtonIcon(
          icon: const Icon(Icons.video_call_rounded,
              color: Colors.white, size: 38)),
      text: "Press To Call",
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white60, fontSize: 18),
      onPressed:
          (String code, String message, List<String> errorInvitees) async {
        print("zegolcouddd2");
        starttime = DateTime.now();
        print("Call Start Time =============> $starttime");
        errorInvitees.length;
        if (errorInvitees.isEmpty) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          var userIDs = pref.getString(FirestoreConstants.id);
          // String userIDs = "";
          for (int index = 0; index < errorInvitees.length; index++) {
            if (index >= 5) {
              userIDs = '... ';
              break;
            }
            var userID = errorInvitees.elementAt(index);
            userIDs = userID + ' ';
          }

          print("Length : ${userIDs!.length}");

          if (userIDs.isNotEmpty) {
            userIDs = userIDs.substring(0, userIDs.length - 1);
            print("timetime");

            // timer1 = Timer.periodic(Duration(seconds: 5), (timer) {
            //   print("Dateeee" + DateTime.now().toString());

            // coinDeduction(
            //   user_id.toString(),
            //   vendor_id.toString(),
            //   AppConstants.coin_deduction,
            //   "60",
            //   starttime.toString(),
            //   "",
            // );
            //   timer1 = timer;
            // });
          } else {
            print("UserIDS empty");
          }

          print("Reached Here");
          var message = 'Is offline';
          if (code.isNotEmpty) {
            message += ' message:$message';
          }
          showToast(
            message,
            position: StyledToastPosition.top,
            context: context,
          );
          print("Reached Here Too");
        } else if (code.isNotEmpty) {
          showToast(
            'message:$message',
            position: StyledToastPosition.top,
            context: context,
          );
        } else {
          print("Something Else");

          /// Your IF Condition is not working ... its going in ELSE... hence the api is not being called
          ///
        }
      },
    );
  }

  List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {
    List<ZegoUIKitUser> invitees = [];
    var inviteeIDs = textCtrlText.trim().replaceAll('，', '');
    inviteeIDs.split(",").forEach((inviteeUserID) {
      if (inviteeUserID.isEmpty) {
        return;
      }

      invitees.add(ZegoUIKitUser(
        id: inviteeUserID,
        name: 'user_$inviteeUserID',
      ));
    });

    return invitees;
  }

  coinDeduction(String userId, String host_id, String coins, String sec,
      String dateTime, String plan_type) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/coinDeduction";
    var map = Map<String, dynamic>();
    map['user_id'] = userId;
    map['host_id'] = host_id;
    map['coins'] = coins;
    map['sec'] = sec;
    map['start_time'] = dateTime;
    map['play_type'] = plan_type;
    final response = await http.post(Uri.parse(postUrl), body: map);
    if (response.body == "1") print("Coin Dedid --------------> $response");
    try {
      if (response.body == "1") print(response);
    } catch (e) {
      print(e);
    }
  }
// coin_deduction(String userId, String host_id, String coins, String sec,
//     String dateTime, String plan_type) async {
//   String postUrl =
//       "https://hookupindia.in/hookup/ApiController/coinDeduction";
//   print("stringrequest");
//
//   var request = http.MultipartRequest("POST", Uri.parse(postUrl));
//   request.fields['user_id'] = userId;
//   request.fields['host_id'] = host_id;
//   request.fields['coins'] = coins;
//   request.fields['sec'] = sec;
//   request.fields['plan_type'] = plan_type;
//   request.fields['start_time'] = dateTime;
//   request.send().then((response) {
//     http.Response.fromStream(response).then((onValue) {
//       try {
//         // Navigator.pop(context);
//         print("onValue${onValue.body}");
//         Map mapRes = json.decode(onValue.body);
//         var success = mapRes["status"];
//         var msg = mapRes["message"];
//
//         if (success == "1") {
//           print("resultt $mapRes");
//         } else {}
//       } catch (e) {
//         print("response$e");
//       }
//     });
//   });
// }
}
