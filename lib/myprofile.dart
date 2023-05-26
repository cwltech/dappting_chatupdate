import 'dart:convert';
import 'dart:io';

import 'package:dapp/constants/constants.dart';
import 'package:dapp/drawer_option.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/login.dart';
import 'package:dapp/providers/country_provider.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:dapp/screens/male.edit.profile.dart';
import 'package:dapp/screens/male.profile.view.dart';
import 'package:dapp/wallet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_activity.dart';

bool editprof = false;
String appreance = "-";

class myprofile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myprofile();
  }
}

class _myprofile extends State<myprofile> {
  double _opacity = 0.9;
  List<File> imagesfile = [];

  var nickname = TextEditingController();
  var fname = TextEditingController();
  var lname = TextEditingController();
  var birthday = TextEditingController();
  var city = TextEditingController();
  var height = TextEditingController();
  var weight = TextEditingController();
  var language = TextEditingController();
  var gender = TextEditingController();
  var pincode = TextEditingController();
  var address = TextEditingController();
  var own_words = TextEditingController();
  var looking_partner = TextEditingController();
  var relationship = TextEditingController();

  var user_id;
  File? imageFile;
  List nicknamed = [];
  String? nicknameval;
  List heightmap = [];
  String? heightval;
  List weightmap = [];
  String? weightval;
  List drinkmap = [];
  String? drinkval;
  List smokemap = [];
  String? smokeval;
  List maritialmap = [];
  String? maritialval;
  List educationmap = [];
  String? educationval;
  List wordsmap = [];
  String? wordsval;
  List partnermap = [];
  String? partnerval;
  List relationmap = [];
  String? relationalval;
  String? countryval;
  List mycountry = [];
  String? stateval;
  List statelist = [];
  List citylist = [];
  String? cityval = null;

  @override
  void initState() {
    super.initState();
    context.read<apperance_provider>().apperance_list();
    context.read<height_provider>().height_list();
    context.read<weight_provider>().weight_list();
    context.read<drink_provider>().drink_list();
    context.read<smoke_provider>().smoke_list();
    context.read<maritial_provider>().maritial_list();
    context.read<education_provider>().eductaion_list();
    context.read<country_provider>().country_list();
    Future.delayed(const Duration(seconds: 2), () {});
    getUserDetails(context);
  }

  /* Get User ID From From Local Function */
  getUserDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString(FirestoreConstants.id);
      context.read<profile_details_provider>().profile_details_list(user_id);
    });
    print("User Profile ID 🍆🍆🍆🍆 ==========> $user_id");
  }

  @override
  Widget build(BuildContext context) {
    context.read<profile_details_provider>().profile_details_list(user_id);

    return Stack(
      children: [
        Opacity(
            opacity: _opacity,
            child: Image.asset('assets/homeheart.png',
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover)),
        editprof == false
            ? Scaffold(
                //  backgroundColor: Color(0xffCC0000),
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  // leading: Icon(
                  //   Icons.arrow_back_ios,
                  //   color: Colors.black,
                  // ),
                  backgroundColor: Colors.transparent,
                  title: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "User Profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            )),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Row(
                        children: <Widget>[
                          TextButton(
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () async {
                              SharedPreferences prefrences =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                prefrences.remove("isLoggedIn");
                                prefrences.remove("isLoggedInvendor");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => login()));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(child:
                    Consumer<profile_details_provider>(
                        builder: (context, value, child) {
                  print("User Pro$value");
                  return value.map.isEmpty && !value.error
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
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MaleEditProfileSetting()));
                                          });
                                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => edit_profile()));
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
                                                            BorderRadius
                                                                .circular(55),
                                                        child: value.map["data"]
                                                                        [
                                                                        "userData"]
                                                                    [
                                                                    "profile_image"] !=
                                                                ""
                                                            ? Image.network(
                                                                value.map["data"]
                                                                        [
                                                                        "userData"]
                                                                    [
                                                                    "profile_image"],
                                                                width: 90,
                                                                height: 90,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                size: 30,
                                                              ),
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
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const MaleProfileSetting()));
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
                                          value.map["data"]["userData"]
                                                  ["fname"] +
                                              " " +
                                              value.map["data"]["userData"]
                                                  ["lname"],
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
                                          user_id.toString(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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

                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                                    //      child: Container(
                                    //     width: MediaQuery.of(context).size.width,
                                    //     height: 70,
                                    //     decoration: BoxDecoration(
                                    //       color: Color(0xff07D3DF),
                                    //       borderRadius: BorderRadius.circular(20)
                                    //     ),
                                    //   ),
                                    // ),

                                    const SizedBox(
                                      height: 50,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6.0, left: 6),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          " My Balance",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6, left: 6),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          value.map["data"]
                                                                  ["userData"]
                                                                  ["coins"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
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
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          mybalance()));
                                            },
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
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0, left: 6),
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      children: const [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            " Premium / VIP",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6, left: 6),
                                                    child: Row(
                                                      children: [
                                                        const Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Get more privilleges",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 10,
                                                            height: 10,
                                                            child: Image.asset(
                                                                "assets/whitefwrd.png")),
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
                                          vertical: 10.0, horizontal: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 60,
                                            color: const Color(0xff07D3DF)
                                                .withOpacity(0.15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Image.asset(
                                                    "assets/taskcenter.png"),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Center(
                                                  child: Text(
                                                    "Task Center",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 60,
                                            color: const Color(0xff07D3DF)
                                                .withOpacity(0.15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Image.asset(
                                                    "assets/credit.png"),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Center(
                                                  child: Text(
                                                    "Credit",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          drawer()));
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 60,
                                              color: const Color(0xff07D3DF)
                                                  .withOpacity(0.15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset(
                                                      "assets/setting.png"),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      "Setings",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Offstage(
                                      offstage: true,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 60,
                                              color: const Color(0xff07D3DF)
                                                  .withOpacity(0.15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: const [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  // Image.asset(
                                                  //     "assets/custser.png"),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "Customer Service",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              height: 60,
                                              color: const Color(0xff07D3DF)
                                                  .withOpacity(0.15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset(
                                                      "assets/google.png"),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      "Google Order",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              height: 60,
                                              color: const Color(0xff07D3DF)
                                                  .withOpacity(0.15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset(
                                                      "assets/setting.png"),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      "Setings",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: CircularProgressIndicator());
                })))
            : editprofile(context),
      ],
    );
  }

  Widget editprofile(BuildContext context) {
    context.read<apperance_provider>().apperance_list();
    context.read<height_provider>().height_list();
    context.read<weight_provider>().weight_list();
    context.read<drink_provider>().drink_list();
    context.read<smoke_provider>().smoke_list();
    context.read<maritial_provider>().maritial_list();
    context.read<education_provider>().eductaion_list();
    context.read<country_provider>().country_list();
    context.read<profile_details_provider>().profile_details_list(user_id);

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(35.0), // he,
          child: AppBar(
            centerTitle: true,
            title: const Text(
              "Edit Information",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    editprof = false;
                  });
                }),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
        body: SingleChildScrollView(child: Consumer<profile_details_provider>(
            builder: (context, value, child) {
          fname.text = value.map["data"]["userData"]["fname"] ?? "";
          lname.text = value.map["data"]["userData"]["lname"] ?? "";
          pincode.text = value.map["data"]["userData"]["pincode"] ?? "";
          address.text = value.map["data"]["userData"]["address"] ?? "";

          print("valuep$value");
          return value.map.length == 0 && !value.error
              ? const Center(child: CircularProgressIndicator())
              : value.error
                  ? const Text("Opps SOmething went wrong")
                  : value.map["data"]["userData"] != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                        width: 115,
                                        height: 115,
                                        child: Image.asset(
                                            "assets/halfcircle.png")),
                                    // Front image
                                    Stack(children: [
                                      SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: imageFile != null
                                              ? CircleAvatar(
                                                  backgroundImage:
                                                      Image.file(imageFile!)
                                                          .image)
                                              : const Icon(
                                                  Icons.person,
                                                  size: 80,
                                                )),
                                      Positioned(
                                        bottom: -1,
                                        right: 2,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const ShapeDecoration(
                                            shape: CircleBorder(),
                                            color: Color(0xffCC0000),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              _getFromGallery();
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Center(
                                child: Text(
                                  value.map["data"]["userData"]["fname"] +
                                      " " +
                                      value.map["data"]["userData"]["lname"],
                                  style: const TextStyle(
                                      color: Color(0xffCC0000),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            imagesfile != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        children: imagesfile.map((imageone) {
                                          return Card(
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: SizedBox(
                                                    height: 100,
                                                    width: 100,
                                                    child: Image.file(
                                                        File(imageone.path)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 20),
                              child: Row(
                                children: const [
                                  Text(
                                    "Basic Information",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "( Fill in all to get \u{1FA99} )",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "First Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: fname,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "-",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Last Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: lname,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "-",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Nick Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: nickname,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "-",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Pincode",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: pincode,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "pincode",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: address,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "address",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<country_provider>(
                                  builder: (context, value, child) {
                                mycountry = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? const CircularProgressIndicator()
                                    : value.error
                                        ? const Text(
                                            "Opps SOmething went wrong")
                                        :
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       //showbottomsheet(context);
                                        //     });
                                        //     print("apperance1 $appreance");
                                        //   },
                                        //   child:
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Country",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),

                                              Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  // border: const Border(
                                                  //   left: BorderSide(
                                                  //     color: Colors.blue,
                                                  //     width: 8,
                                                  //   ),
                                                  // ),
                                                ),
                                                child: DropdownButton<String>(
                                                  //  itemHeight: 50,
                                                  underline: const SizedBox(),
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "country",
                                                      // value.map[
                                                      // "data"][
                                                      //                 "userData"]
                                                      //             ["country"] ==
                                                      //         null
                                                      //     ? "country"
                                                      //     : value.map["data"]
                                                      //             ["userData"]
                                                      //         ["country"],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: countryval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      countryval = newValue;
                                                      circle(context);
                                                      print(
                                                          "countryval $countryval");
                                                      state_c(int.parse(
                                                          countryval!));
                                                    });
                                                    print(countryval);
                                                  },
                                                  items: mycountry.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        item['country'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      value:
                                                          item['id'].toString(),
                                                      // value: item['id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                              // Container(
                                              //   width: 70,
                                              //   height: 30,
                                              //   child: Text(
                                              //     appreance,
                                              //   // controller:  nickname,
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         color: Colors.black
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, right: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "State",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),

                                    Container(
                                      width: 100,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        // border: const Border(
                                        //   left: BorderSide(
                                        //     color: Colors.blue,
                                        //     width: 8,
                                        //   ),
                                        // ),
                                      ),
                                      child: DropdownButton<String>(
                                        //  itemHeight: 50,
                                        underline: const SizedBox(),
                                        dropdownColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        isExpanded: true,
                                        hint: const Padding(
                                          padding: EdgeInsets.all(7.0),
                                          child: Text(
                                            "state",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          // Add this
                                          Icons.arrow_forward_ios,
                                          // Add this
                                          color: Colors.black,
                                          size: 12, // Add this
                                        ),
                                        value: stateval,
                                        isDense: false,
                                        onChanged: (newValue) {
                                          setState(() {
                                            stateval = newValue;
                                            circle(context);
                                            print("countryval $stateval");
                                            city_c(int.parse(stateval!));
                                          });
                                          print(stateval);
                                        },
                                        items: statelist.map((item) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              item['state'],
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            value: item['id'].toString(),
                                            // value: item['id'].toString(),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                )),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, right: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "City",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),

                                    Container(
                                      width: 100,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        // border: const Border(
                                        //   left: BorderSide(
                                        //     color: Colors.blue,
                                        //     width: 8,
                                        //   ),
                                        // ),
                                      ),
                                      child: DropdownButton<String>(
                                        //  itemHeight: 50,
                                        underline: const SizedBox(),
                                        dropdownColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        isExpanded: true,
                                        hint: const Padding(
                                          padding: EdgeInsets.all(7.0),
                                          child: Text(
                                            "city",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          // Add this
                                          Icons.arrow_forward_ios,
                                          // Add this
                                          color: Colors.black,
                                          size: 12, // Add this
                                        ),
                                        value: cityval,
                                        isDense: false,
                                        onChanged: (newValue) {
                                          setState(() {
                                            cityval = newValue;
                                          });
                                          print(cityval);
                                        },
                                        items: citylist.map((item) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              item['city'],
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            value: item['id'].toString(),
                                            // value: item['id'].toString(),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                )),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<height_provider>(
                                  builder: (context, value, child) {
                                heightmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? const CircularProgressIndicator()
                                    : value.error
                                        ? const Text(
                                            "Opps SOmething went wrong")
                                        :
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       //showbottomsheet(context);
                                        //     });
                                        //     print("apperance1 $appreance");
                                        //   },
                                        //   child:
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Height",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),

                                              Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  // border: const Border(
                                                  //   left: BorderSide(
                                                  //     color: Colors.blue,
                                                  //     width: 8,
                                                  //   ),
                                                  // ),
                                                ),
                                                child: DropdownButton<String>(
                                                  //  itemHeight: 50,
                                                  underline: const SizedBox(),
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: heightval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      heightval = newValue;
                                                    });
                                                    print(heightval);
                                                  },
                                                  items: heightmap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      value:
                                                          item['id'].toString(),
                                                      // value: item['id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            ],
                                          );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<apperance_provider>(
                                  builder: (context, value, child) {
                                nicknamed = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? const CircularProgressIndicator()
                                    : value.error
                                        ? const Text(
                                            "Opps SOmething went wrong")
                                        :
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       //showbottomsheet(context);
                                        //     });
                                        //     print("apperance1 $appreance");
                                        //   },
                                        //   child:
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Appearence",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),

                                              Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  // border: const Border(
                                                  //   left: BorderSide(
                                                  //     color: Colors.blue,
                                                  //     width: 8,
                                                  //   ),
                                                  // ),
                                                ),
                                                child: DropdownButton<String>(
                                                  //  itemHeight: 50,
                                                  underline: const SizedBox(),
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: nicknameval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      nicknameval = newValue;
                                                    });
                                                    print(nicknameval);
                                                  },
                                                  items: nicknamed.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      value:
                                                          item['id'].toString(),
                                                      // value: item['id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                              // Container(
                                              //   width: 70,
                                              //   height: 30,
                                              //   child: Text(
                                              //     appreance,
                                              //   // controller:  nickname,
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         color: Colors.black
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<drink_provider>(
                                  builder: (context, value, child) {
                                drinkmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? const CircularProgressIndicator()
                                    : value.error
                                        ? const Text(
                                            "Opps SOmething went wrong")
                                        :
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       //showbottomsheet(context);
                                        //     });
                                        //     print("apperance1 $appreance");
                                        //   },
                                        //   child:
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Drink",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),

                                              Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  // border: const Border(
                                                  //   left: BorderSide(
                                                  //     color: Colors.blue,
                                                  //     width: 8,
                                                  //   ),
                                                  // ),
                                                ),
                                                child: DropdownButton<String>(
                                                  //  itemHeight: 50,
                                                  underline: const SizedBox(),
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: drinkval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      drinkval = newValue;
                                                    });
                                                    print(drinkval);
                                                  },
                                                  items: drinkmap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      value:
                                                          item['id'].toString(),
                                                      // value: item['id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                              // Container(
                                              //   width: 70,
                                              //   height: 30,
                                              //   child: Text(
                                              //     appreance,
                                              //   // controller:  nickname,
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         color: Colors.black
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<smoke_provider>(
                                  builder: (context, value, child) {
                                smokemap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? const CircularProgressIndicator()
                                    : value.error
                                        ? const Text(
                                            "Opps SOmething went wrong")
                                        :
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       //showbottomsheet(context);
                                        //     });
                                        //     print("apperance1 $appreance");
                                        //   },
                                        //   child:
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Smoke",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),

                                              Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  // border: const Border(
                                                  //   left: BorderSide(
                                                  //     color: Colors.blue,
                                                  //     width: 8,
                                                  //   ),
                                                  // ),
                                                ),
                                                child: DropdownButton<String>(
                                                  //  itemHeight: 50,
                                                  underline: const SizedBox(),
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: smokeval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      smokeval = newValue;
                                                    });
                                                    print(smokeval);
                                                  },
                                                  items: smokemap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      value:
                                                          item['id'].toString(),
                                                      // value: item['id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                              // Container(
                                              //   width: 70,
                                              //   height: 30,
                                              //   child: Text(
                                              //     appreance,
                                              //   // controller:  nickname,
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         color: Colors.black
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<maritial_provider>(
                                  builder: (context, value, child) {
                                maritialmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? const CircularProgressIndicator()
                                    : value.error
                                        ? const Text(
                                            "Opps SOmething went wrong")
                                        :
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       //showbottomsheet(context);
                                        //     });
                                        //     print("apperance1 $appreance");
                                        //   },
                                        //   child:
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Maritial Status",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),

                                              Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  // border: const Border(
                                                  //   left: BorderSide(
                                                  //     color: Colors.blue,
                                                  //     width: 8,
                                                  //   ),
                                                  // ),
                                                ),
                                                child: DropdownButton<String>(
                                                  //  itemHeight: 50,
                                                  underline: const SizedBox(),
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: maritialval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      maritialval = newValue;
                                                    });
                                                    print(maritialval);
                                                  },
                                                  items:
                                                      maritialmap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      value:
                                                          item['id'].toString(),
                                                      // value: item['id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            ],
                                          );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<education_provider>(
                                  builder: (context, value, child) {
                                educationmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? const CircularProgressIndicator()
                                    : value.error
                                        ? const Text(
                                            "Opps Something went wrong")
                                        :
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       //showbottomsheet(context);
                                        //     });
                                        //     print("apperance1 $appreance");
                                        //   },
                                        //   child:
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Education",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),

                                              Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  // border: const Border(
                                                  //   left: BorderSide(
                                                  //     color: Colors.blue,
                                                  //     width: 8,
                                                  //   ),
                                                  // ),
                                                ),
                                                child: DropdownButton<String>(
                                                  //  itemHeight: 50,
                                                  underline: const SizedBox(),
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: educationval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      educationval = newValue;
                                                    });
                                                    print(educationval);
                                                  },
                                                  items:
                                                      educationmap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      value:
                                                          item['id'].toString(),
                                                      // value: item['id'].toString(),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            ],
                                          );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Own Words",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: own_words,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "-",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Looking Partner",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: looking_partner,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "-",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Relationship Looking For",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: relationship,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "-",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 40),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color(0xffCC0000),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    List none = [];
                                    circle(context);
                                    update_profile(
                                        fname.text,
                                        lname.text,
                                        "",
                                        user_id,
                                        nickname.text,
                                        countryval != null ? countryval! : "",
                                        stateval != null ? stateval! : "",
                                        cityval != null ? cityval! : "",
                                        pincode.text,
                                        address.text,
                                        "User",
                                        imageFile!.path != null
                                            ? imageFile!.path
                                            : "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        relationship.text,
                                        educationval != null
                                            ? educationval!
                                            : "",
                                        "",
                                        "",
                                        none,
                                        own_words.text,
                                        "",
                                        looking_partner.text);
                                  },
                                  child: const Text(
                                    "SAVE",
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
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
        })));
  }

  Future getimageslist() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      setState(() {
        imagesfile = result.paths.map((path) => File(path!)).toList();
        for (int i = 0; i < result.count; i++) {}
        print("resumefile$imagesfile");
      });
    } else {}
    // User canceled the picker
  }

  update_profile(
      String first_name,
      String last_name,
      String email_address,
      String user_id,
      String user_name,
      String country,
      String state,
      String city,
      String pincode,
      String address,
      String type,
      String profile_image,
      String profile_video,
      String hair_color,
      String eye_color,
      String height,
      String weight,
      String body_type,
      String ethnicity,
      String my_appearance,
      String drink,
      String smoke,
      String marital_status,
      String children_have,
      String children_want,
      String occupation,
      String relationship_looking_for,
      String education,
      String english_ability,
      String religion,
      List gallery,
      String own_words,
      String little_yourself,
      String looking_partner) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/updateUserProfile";
    print("stringrequest");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['first_name'] = first_name;
    request.fields['type'] = "User";
    request.fields['last_name'] = last_name;
    request.fields['email_address'] = email_address;
    request.fields['user_id'] = user_id;
    request.fields['user_name'] = user_name;
    request.fields['country'] = country;
    request.fields['state'] = state;
    request.fields['city'] = city;
    request.fields['pincode'] = pincode;
    request.fields['address'] = address;
    // request.fields['type'] = type;
    request.fields['profile_image'] = profile_image;
    request.fields['profile_video'] = profile_video;
    request.fields['hair_color'] = hair_color;
    request.fields['eye_color'] = eye_color;
    request.fields['height'] = height;
    request.fields['weight'] = weight;
    request.fields['body_type'] = body_type;
    request.fields['ethnicity'] = ethnicity;
    request.fields['my_appearance'] = my_appearance;
    request.fields['drink'] = drink;
    request.fields['smoke'] = smoke;
    request.fields['marital_status'] = marital_status;
    request.fields['children_have'] = children_have;
    request.fields['children_want'] = children_want;
    request.fields['occupation'] = occupation;
    request.fields['relationship_looking_for'] = relationship_looking_for;
    request.fields['education'] = education;
    request.fields['english_ability'] = english_ability;
    request.fields['religion'] = religion;
    request.fields['gallery'] = gallery.toString();
    request.fields['own_words'] = own_words;
    request.fields['little_yourself'] = little_yourself;
    request.fields['looking_partner'] = looking_partner;

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          print("onValue1${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var status = mapRes["status"];
          if (status == "1") {
            setState(() {
              Fluttertoast.showToast(
                  msg: mapRes["message"],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => home_home()));
            });
          } else {
            Fluttertoast.showToast(
                msg: mapRes["message"],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          }
          //   print("getdatata$email $name)");

        } catch (e) {
          print("response$e");
        }
      });
    });
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      // maxWidth: 1800,
      // maxHeight: 1800,
    );
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
  }

  Future<String> state_c(int country) async {
    stateval = null;
    String postUrl = "https://hookupindia.in/hookup/ApiController/stateList";
    print("stringrequest");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['country'] = country.toString();
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          Map mapRes = json.decode(onValue.body);
          setState(() {
            statelist = mapRes["data"];
          });
          print("response$statelist");
        } catch (e) {
          print("response$e");
        }
      });
    });
    return country.toString();
  }

  Future<String> city_c(int state) async {
    cityval = null;
    String postUrl = "https://hookupindia.in/hookup/ApiController/cityList";
    print("stringrequest");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['state'] = state.toString();
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Navigator.pop(context);
          Map mapRes = json.decode(onValue.body);
          setState(() {
            citylist = mapRes["data"];
          });
          print("response$citylist");
        } catch (e) {
          print("response$e");
        }
      });
    });
    return state.toString();
  }
}
