import 'package:dapp/aboutus.dart';
import 'package:dapp/login.dart';
import 'package:dapp/providers/female_details_provider.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Webview.profile.view.dart';
import '../invitevideocall.dart';
import 'female.edit.profile.dart';

class female_profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _female_profile();
  }
}

class _female_profile extends State<female_profile> {
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
    context.read<profile_details_provider>().profile_details_list(user_id);
    context.read<female_details_provider>().female_details(user_id);
    return Stack(
      children: [
        Opacity(
            opacity: 0.9,
            child: Image.asset('assets/homeheart.png',
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover)),
        Scaffold(
            //  backgroundColor: Color(0xffCC0000),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              // leading: const Icon(
              //   Icons.arrow_back_ios,
              //   color: Colors.black,
              // ),
              backgroundColor: Colors.transparent,
              title: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "Vendor Profile",
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
                Consumer2<profile_details_provider, female_details_provider>(
                    builder: (context, value, value2, child) {
              print("valuep$value");
              return value.map.length == 0 && !value.error
                  ? const CircularProgressIndicator()
                  : value.error
                      ? const Text("Opps SOmething went wrong")
                      : value.map["data"]["userData"] != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfileSetting()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Image.asset(
                                                    "assets/profile_eyecircle.png")),
                                            // Front image
                                            SizedBox(
                                                width: 16,
                                                height: 16,
                                                child: Image.asset(
                                                    "assets/edit.png")),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.asset(
                                                      "assets/halfcircle.png")),
                                              // Front image
                                              SizedBox(
                                                  width: 90,
                                                  height: 90,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    child: value.map["data"]
                                                                    ["userData"]
                                                                [
                                                                "profile_image"] !=
                                                            null
                                                        ? Image.network(
                                                            value.map["data"]
                                                                    ["userData"]
                                                                [
                                                                "profile_image"],
                                                            fit: BoxFit.fill,
                                                          )
                                                        : const Icon(
                                                            Icons.person),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Image.asset(
                                                    "assets/profile_eyecircle.png")),
                                            // Front image
                                            InkWell(
                                              onTap: () {
                                                setState(() {});
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const FemaleProfileViewWebView()));
                                              },
                                              child: SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child: Image.asset(
                                                      "assets/ssetting.png")),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 8),
                                  child: Center(
                                    child: Text(
                                      value.map["data"]["userData"]["fname"],
                                      style: const TextStyle(
                                          color: Color(0xffCC0000),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, bottom: 8),
                                  child: Center(
                                    child: Text(
                                      "ID:${value.map["data"]["userData"]["unique_id"]}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, bottom: 8),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/india.png"),
                                      const Text(
                                        " IN",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xff07D3DF)
                                              .withOpacity(0.3),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, left: 6),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      " My Balance",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: 10,
                                                      height: 10,
                                                      child: Image.asset(
                                                          "assets/redfrwd.png")),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6, left: 6),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      value2.map["data"][
                                                                  "total_coins"]
                                                              .toString() ??
                                                          "",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "assets/smallcoin.png",
                                                      width: 12,
                                                      height: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFFEB974),
                                                Color(0xFF944C1E),
                                                Color(0xFF772F1A),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            //color:Color(0xff07D3DF).withOpacity(0.3),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 6),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: InkWell(
                                                        onTap: () {
                                                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => mybalance()));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              " My Wallet ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                                width: 10,
                                                                height: 10,
                                                                child: Image.asset(
                                                                    "assets/whitefwrd.png")),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6, left: 6),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        value2.map["data"][
                                                                    "total_amount_in_wallet"]
                                                                .toString() ??
                                                            "",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 30),
                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      about_us()));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "About us",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xffCC0000),
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Settings",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Color(0xffCC0000),
                                            size: 15,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          SharedPreferences prefrences =
                                              await SharedPreferences
                                                  .getInstance();
                                          setState(() {
                                            prefrences.remove("isLoggedIn");
                                            prefrences
                                                .remove("isLoggedInvendor");
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        login()));
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Logout",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xffCC0000),
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CallInvitationPage(
                                  localUserID: int.parse(value.map["data"]
                                      ["userData"]["unique_id"]),
                                  inivites: "",
                                  username: value.map["data"]["userData"]
                                      ["fname"],
                                  user_id: "",
                                  vendor_id: "",
                                  type: "host",
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
            })))
      ],
    );
  }
}
