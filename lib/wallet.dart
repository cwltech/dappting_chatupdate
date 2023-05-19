import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/payment_stripe.dart';
import 'package:dapp/providers/package_provider.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:dapp/providers/regular_package_provider.dart';
import 'package:dapp/providers/vip_package_provider.dart';
import 'package:dapp/vipaccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mybalance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mybalance();
  }
}

class _mybalance extends State<mybalance> {
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
    print("blodidw $user_id");
  }

  double _opacity = 0.9;
  var packagedata;
  String type = "";
  String plan_id = "";
  @override
  Widget build(BuildContext context) {
    context.read<package_provider>().package_list(user_id);
    context.read<profile_details_provider>().profile_details_list(user_id);
    context.read<vip_package_provider>().package_list(user_id);
    context.read<regular_package_provider>().package_list(user_id);

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
                  opacity: _opacity,
                  child: Image.asset('assets/hearts_1.png',
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover)),
            ]),
          ],
        )),
        // Opacity(
        //     opacity: _opacity,
        //     child: Image.asset(
        //         'assets/homeheart.png',
        //         width: double.maxFinite,
        //         height: MediaQuery.of(context).size.height,
        //         fit: BoxFit.cover)
        // ),
        Scaffold(
            //  backgroundColor: Color(0xffCC0000),
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
                        text: "My Balance",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(child:
                Consumer2<package_provider, profile_details_provider>(
                    builder: (context, value, value2, child) {
              return value.map["data"]["HostList"] != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFEB974),
                                const Color(0xFF944C1E),
                                const Color(0xFF772F1A),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            //color:Color(0xff07D3DF).withOpacity(0.3),
                          ),
                          child: Stack(children: [
                            Positioned(
                                right: -28,
                                top: 60,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => vipaccess()));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.black,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Subscribe Now",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 12),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "5% discount on Membership Card",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6, left: 12),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Pay for itself only about one purchase",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 12, right: 15, top: 100),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        value.map["data"]["HostList"][0]
                                                ["PlanName"] +
                                            "\nSubsribe now to check more about plans",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Text(
                                      "₹ " +
                                          value.map["data"]["HostList"][0]
                                              ["PlanPrice"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height,
                          child: ContainedTabBarView(
                            tabBarProperties: TabBarProperties(
                              //height: 32.0,
                              labelColor: Colors.red,
                              indicatorColor: Color(0xff07D3DF),
                              indicatorWeight: 1.0,
                              unselectedLabelColor: Colors.grey[400],
                            ),
                            tabs: [
                              Text(
                                'Wallet',
                                style: TextStyle(
                                  //color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Credit',
                                style: TextStyle(
                                  //color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            views: [
                              wallet_w(),
                              credit_w(value2.map["data"]["userData"]["coins"]
                                  .toString())
                              //Container(color: Colors.green),
                              //Container(color: Colors.green)
                            ],
                            onChange: (index) => print(index),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            })))
      ],
    );
  }

  Widget wallet_w() {
    return Consumer3<profile_details_provider, vip_package_provider,
            regular_package_provider>(
        builder: (context, value, value2, value3, child) {
      return value.map["data"] != null
          ? Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text(
                      "My Balance \u{1FA99} " +
                          value.map["data"]["userData"]["coins"].toString() +
                          " Coins",
                      style: TextStyle(
                        color: Color(0xffCC0000),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset("assets/bigcoin.png")),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(" Buy Coins",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Text(
                              " Buy Coins and unlock special features specially \n curated for you.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.map["data"]["userData"]["membership_plan"]
                                .toString() ==
                            "1"
                        ? value2.map["data"].length
                        : value3.map["data"].length,
                    itemBuilder: (context, i) {
                      packagedata = value.map["data"]["userData"]
                                      ["membership_plan"]
                                  .toString() ==
                              "1"
                          ? value2.map["data"]
                          : value3.map["data"];
                      type = value.map["data"]["userData"]["membership_plan"]
                                  .toString() ==
                              "1"
                          ? "2"
                          : "1";
                      plan_id = value.map["data"]["userData"]["membership_plan"]
                                  .toString() ==
                              "1"
                          ? value2.map["data"][i]["id"].toString()
                          : value3.map["data"][i]["id"].toString();
                      return GestureDetector(
                        onTap: () {
                          circle(context);
                          payment_stripe.makepayment(context,
                              packagedata[i]["price"], user_id, type, plan_id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff07D3DF), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/smallcoin.png",
                                        width: 12,
                                        height: 12,
                                      ),
                                      Text(
                                        " " +
                                            packagedata[i]["coins"] +
                                            " Coins",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        packagedata[i]["name"] ?? "",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffCC0000),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xffCC0000)
                                                .withOpacity(0.8),
                                            // border: Border.all(color: Color(0xff07D3DF),width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Center(
                                          child: Text(
                                            "₹ " + packagedata[i]["price"] ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
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
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }

  Widget credit_w(String coins) {
    return Column(
      children: [
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 20.0, bottom: 10),
        //     child: Text(
        //       "$coins \u{1FA99} Coins",
        //       style: TextStyle(
        //         color: Color(0xffCC0000),
        //         fontSize: 13,
        //       ),
        //     ),
        //   ),
        // ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Text(
              "Your Balance : $coins \u{1FA99} Coins",
              style: TextStyle(
                color: Color(0xffCC0000),
                fontSize: 13,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Credit Balance",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Text(
                "0",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Exchange to Coins",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/smallcoin.png",
                    width: 12,
                    height: 12,
                  ),
                  Text(
                    " 0",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 35,
            color: Color(0xffCC0000),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "EXCHANGE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color(0xffCC0000),
                ),
              ),
              // color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
