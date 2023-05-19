import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dapp/chatmessage.dart';
import 'package:dapp/demo.dart';
import 'package:dapp/female_user/chat_tab_female.dart';
import 'package:dapp/female_user/female_profile.dart';
import 'package:dapp/hotpage.dart';
import 'package:dapp/myprofile.dart';
import 'package:dapp/newhot.dart';
import 'package:dapp/pages/chat_list.dart';
import 'package:dapp/profile_dashboard.dart';
import 'package:dapp/show_profile.dart';
import 'package:dapp/vipaccess.dart';
import 'package:dapp/wallet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'female_dashboard.dart';

class female_home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<female_home> with WidgetsBindingObserver {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    female_dash(),
    // chat_tab(),
    chat_home_list(
      type: "vendor",
    ),
    female_profile(),
  ];

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  var user_id;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    get_blogdetails(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print('app inactive, is lock screen: ${await isLockScreen()}');
      // livestatus(user_id, "0");
    } else if (state == AppLifecycleState.resumed) {
      print('app resumed');
    }
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
    });
    print("blodid $user_id");
  }

  Future<bool> exitConfirm() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Do you want to exit ?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  livestatus(user_id, "0");
                  SystemNavigator.pop();
                  //Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => exitConfirm(),
      child: Scaffold(
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xffCC0000),
          unselectedItemColor: Colors.white, // Fixed
          backgroundColor: Color(0xff07D3DF),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_customize,
                size: 30,
              ),
              // icon: ImageIcon(
              //   AssetImage("assets/home.png"),
              //   // color: Colors.white,
              //   size: 30,
              // ),
              label: "",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.chat_rounded,
            //     size: 30,
            //   ),
            //   label: "",
            // ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/msg.png"),
                // color: Colors.white,
                size: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/profile.png"),
                // color: Colors.white,
                size: 30,
              ),
              label: "",
            )
          ],
        ),
      ),
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
            print("maplock $map");
            setState(() {});
          } catch (e) {
            print("response$e");
          }
        } else {}
      });
    });
  }
}
