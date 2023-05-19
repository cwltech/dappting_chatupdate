import 'package:flutter/material.dart';

class edit_profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _edit_p();
  }
}

class _edit_p extends State<edit_profile> {
  double _opacity = 0.9;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Opacity(
            opacity: _opacity,
            child: Image.asset('assets/home_heart_full.png',
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover)),
        Scaffold(
            //  backgroundColor: Color(0xffCC0000),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              leading: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset("assets/pg1.png"),
                  ),
                  Column(
                    children: [
                      Image.asset("assets/pg2.png"),
                      Image.asset("assets/profilepic.png"),
                    ],
                  ),
                ],
              ),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/halfcircle.png")),
                          // Front image
                          SizedBox(
                              width: 90,
                              height: 90,
                              child: Image.asset("assets/profilepic.png")),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                    child: Center(
                      child: Text(
                        "14788888",
                        style: TextStyle(
                            color: Color(0xffCC0000),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
