import 'dart:convert';
import 'package:dapp/pages/chat_list.dart';
import 'package:dapp/payment_stripe.dart';
import 'package:dapp/vipaccess.dart';
import 'package:http/http.dart' as http;
import 'package:dapp/profile_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

List discover1 = ["assets/discover1.png", "assets/discover4.png"];
List discover2 = ["assets/discover2.png", "assets/discover5.png"];
List discover3 = ["assets/discover3.png", "assets/discover6.png"];

class hotpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _hot_match();
  }
}

class _hot_match extends State<hotpage> {
  double _opacity = 0.9;
  var hotprofile;

  @override
  var user_id;

  @override
  void initState() {
    super.initState();
    get_blogdetails(context);
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
      getmembership(user_id);
    });
    print("blodid $user_id");
  }

  Future<String> getmembership(String user_id) async {
    //replace your restFull API here.
    String url = "https://hookupindia.in/hookup/ApiController/hotList";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    setState(() {
      hotprofile = responseData["data"]["HostList"];
    });
    print("hotprofile $hotprofile");
    //Creating a list to store input data;
    return "users";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
            opacity: _opacity,
            child: Image.asset('assets/homeheart.png',
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.5,
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
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "Discover",
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
              child: hotprofile != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        ListView.builder(
                            // the number of items in the list
                            itemCount: hotprofile.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            // display each item of the product list
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 15),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  //height: MediaQuery.of(context).size.height*.62,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xfff5cccc),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 360,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MasonryGridView.count(
                                            shrinkWrap: true,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: hotprofile[index]
                                                    ["GalleryList"]
                                                .length,
                                            itemBuilder: (context, i) {
                                              return hotprofile[index]
                                                              ["GalleryList"][i]
                                                          ["image"] !=
                                                      ""
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                          hotprofile[index][
                                                                  "GalleryList"]
                                                              [i]["image"]))
                                                  : Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.network(
                                                          hotprofile[index]
                                                              ["profile_image"],
                                                          width: 200,
                                                          height: 200,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                            },
                                            crossAxisCount: 2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0, horizontal: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          profile_dashboard()));
                                            },
                                            child: Text(
                                              hotprofile[index]["name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Australia",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff686868),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // payment.makepayment(
                                                    //     context, "10");
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                chat_home_list(
                                                                  type: "user",
                                                                )));
                                                  },
                                                  child: Image.asset(
                                                    "assets/msgred.png",
                                                    height: 22,
                                                    width: 22,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet<void>(
                                                      isScrollControlled: true,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              20),
                                                        ),
                                                      ),
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return vipaccess();
                                                      },
                                                    );
                                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => vipaccess()));
                                                  },
                                                  child: Image.asset(
                                                    "assets/video.png",
                                                    height: 22,
                                                    width: 22,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )),
      ],
    );
  }
}
