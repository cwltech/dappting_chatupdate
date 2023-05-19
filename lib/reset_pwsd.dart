import 'package:flutter/material.dart';

class reset_pwsd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _sign_up();
  }
}

class _sign_up extends State<reset_pwsd> {
  @override
  Widget build(BuildContext context) {
    double _opacity = 0.9;
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Center(
                    child: Text(
                      "Reset Your Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: TextField(
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      hintText: "New Password",
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
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xff07D3DF),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "DONE",
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
            ),
          )),
    ]);
  }
}


//https://www.figma.com/file/4BeISemeJcYA2qt1tub2tX/Dating-App?node-id=50%3A289