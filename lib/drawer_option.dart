import 'dart:developer';

import 'package:dapp/aboutus.dart';
import 'package:dapp/block_list.dart';
import 'package:dapp/editprofile.dart';
import 'package:dapp/home_activity.dart';
import 'package:dapp/myprofile.dart';
import 'package:dapp/wallet.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class drawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _drawer();
  }
}

class _drawer extends State<drawer> {
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
                  opacity: 0.9,
                  child: Image.asset('assets/hearts_1.png',
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover)),
            ]),
          ],
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Menu",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                ],
              ),
            ),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(shrinkWrap: true, children: [
                    ListTile(
                      title: Text(
                        "Home",
                        style: TextStyle(
                            color: Color(0xffCC0000),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => home_home()));
                      },
                    ),
                    // ListTile(
                    //   title: Text(
                    //     "Profile",
                    //     style: TextStyle(
                    //         color: Color(0xffCC0000),
                    //         fontWeight: FontWeight.w600),
                    //   ),
                    //   trailing: Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: Colors.black,
                    //   ),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => myprofile()));
                    //   },
                    // ),
                    ListTile(
                      title: Text(
                        "Block List",
                        style: TextStyle(
                            color: Color(0xffCC0000),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => block_list()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "My Balance",
                        style: TextStyle(
                            color: Color(0xffCC0000),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => mybalance()));
                      },
                    ),

                    ListTile(
                      title: Text(
                        "About us",
                        style: TextStyle(
                            color: Color(0xffCC0000),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).push(_createRoute());

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => about_us()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            color: Color(0xffCC0000),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => login()));
                      },
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => about_us(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
