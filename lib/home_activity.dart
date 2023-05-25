import 'package:dapp/hotpage.dart';
import 'package:dapp/myprofile.dart';
import 'package:dapp/pages/chat_list.dart';
import 'package:dapp/profile_dashboard.dart';
import 'package:dapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class home_home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<home_home> {
  int currentTabIndex = 0;
  var getuser;
  List<Widget> tabs = [
    home_user(),
    // home_match(),
    hotpage(),
    const chat_home_list(type: "user"),
    profile_dashboard(),
    // const ViewProfilePage(),
    myprofile(),
  ];

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> exitConfirm() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Do you want to exit ?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
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
      onWillPop: () async {
        return exitConfirm();
      },
      child: Scaffold(
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xffCC0000),
          unselectedItemColor: Colors.white,
          // Fixed
          backgroundColor: const Color(0xff07D3DF),
          items: [
            BottomNavigationBarItem(
              icon: InkWell(
                onDoubleTap: () {
                  print('clicktab');
                },
                child: const ImageIcon(
                  AssetImage("assets/home.png"),
                  size: 30,
                ),
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/hot.png"),
                size: 30,
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/msg.png"),
                // color: Colors.white,
                size: 30,
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/breakheart.png"),
                // color: Colors.white,
                size: 30,
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
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
}
