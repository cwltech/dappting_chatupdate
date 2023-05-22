import 'package:card_swiper/card_swiper.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile_dashboard.dart';
import 'content_screen.dart';

class home_user extends StatefulWidget {
  @override
  State<home_user> createState() => _home_userState();
}

class _home_userState extends State<home_user> {
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
    });
    print("blodid $user_id");
  }

  @override
  Widget build(BuildContext context) {
    context.read<hostlist_provider>().host_list(user_id).toString();
    return Scaffold(
      body: Consumer<hostlist_provider>(
        builder: (context, value, child) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<hostlist_provider>().host_list(user_id);
            },
            child: value.map["data"]["HostList"] != null
                ? SafeArea(
                    child: Container(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          //We need swiper for every content
                          Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return ContentScreen(
                                src: value.map["data"]["HostList"][index]
                                    ["profile_video"],
                                index: index,
                              );
                            },
                            itemCount: value.map["data"]["HostList"].length,
                            scrollDirection: Axis.vertical,
                            loop: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Hookup',
                                    style: TextStyle(
                                      color: Color(0xff07D3DF),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    profile_dashboard()));
                                      },
                                      child: Image.asset(
                                        "assets/card.png",
                                        width: 40,
                                        height: 40,
                                      ),
                                    )),
                                //Icon(Icons.camera_alt),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
        /*child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                //We need swiper for every content
                Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    print("inddd ${constant.videos[index]["profile_video"]}");
                    print("inddd $index");
                    return ContentScreen(
                      src: constant.videos[index]["profile_video"],
                      index: index,
                    );
                  },
                  itemCount: constant.videos.length,
                  scrollDirection: Axis.vertical,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Hookup',
                          style: TextStyle(
                            color: Color(0xff07D3DF),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder:(context) => profile_dashboard()));
                            },
                            child: Image.asset("assets/card.png",width: 40,
                              height: 40,),
                          )),
                      //Icon(Icons.camera_alt),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),*/
      ),
    );
  }
}
