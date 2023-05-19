import 'dart:convert';

import 'package:dapp/show_profile.dart';
import 'package:dapp/vipaccess.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class profile_dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _profile_d();
  }
}

class _profile_d extends State<profile_dashboard> {
  var getuser;

  @override
  void initState() {
//
    super.initState();
    getRequest();
  }

  Future<String> getRequest() async {
    //replace your restFull API here.
    String url = "https://hookupindia.in/hookup/ApiController/userHostList";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    setState(() {
      getuser = responseData["data"]["HostList"];
    });
    print("getuserc $getuser");
    //Creating a list to store input data;
    return "users";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: getuser != null
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        "assets/banner.png",
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "For You",
                        style: TextStyle(
                            color: Color(0xffCC0000),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    scrollDirection: Axis.vertical,
                    itemCount: getuser.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        //height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        child: GridTile(
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("host_id",
                                  getuser[index]["user_id"].toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => show_profile()));
                            },
                            child: Container(
                              //height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      getuser[index]["profile_image"]),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      // color: Colors.green.withOpacity(5),
                                      width: 50,
                                      height: 17,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: getuser[index]["live_status"] ==
                                                0
                                            ? Color(0xffCC0000).withOpacity(0.4)
                                            : Colors.green.withOpacity(0.4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          getuser[index]["live_status"] == 0
                                              ? "Offline"
                                              : "Online",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: getuser[index]
                                                        ["live_status"] ==
                                                    0
                                                ? Color(0xffCC0000)
                                                : Color(0xff05FF00),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        //alignment: Alignment.bottomCenter,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        color:
                                            Color(0xff000000).withOpacity(0.35),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .25,
                                                    child: Text(
                                                      getuser[index]["name"] ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2,
                                                          right: 2,
                                                          top: 5),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "India",
                                                          style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.9),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                        "assets/india.png"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/msgred.png",
                                                  height: 25,
                                                  width: 25,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet<
                                                          void>(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                              child:
                                                                  vipaccess());
                                                        },
                                                      );
                                                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => vipaccess()));
                                                    },
                                                    child: Image.asset(
                                                      "assets/video.png",
                                                      height: 25,
                                                      width: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ), //just for testing, will fill with image later
                      );
                    },
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(color: Colors.red),
              ),
      ),
    );
  }
}
