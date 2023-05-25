import 'dart:convert';
import 'dart:io';

import 'package:dapp/female_user/female_home_activity.dart';
import 'package:dapp/loading_bar.dart';
import 'package:dapp/providers/country_provider.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

bool editprof = false;
String appreance = "-";

class female_edit_profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myprofile();
  }
}

class _myprofile extends State<female_edit_profile> {
  double _opacity = 0.9;
  List<File> imagesfile = [];

  var fname = new TextEditingController();
  var lname = new TextEditingController();
  var nickname = new TextEditingController();
  var pincode = new TextEditingController();
  var address = new TextEditingController();
  var own_words = new TextEditingController();
  var looking_partner = new TextEditingController();
  var relationship = new TextEditingController();
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
  List ethencitymap = [];
  String? ethencityval;
  List childrenhavemap = [];
  String? childrenhaveval;
  List childrenwantmap = [];
  String? childrenwantval;
  List maritialmap = [];
  String? maritialval;
  List educationmap = [];
  String? educationval;
  List bodytypemap = [];
  String? bodytypeval;
  List englishmap = [];
  String? englishval;
  List eyecolormap = [];
  String? eyecolorval;
  List haircolormap = [];
  String? haircolorval;
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
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  File? videoFile1;
  Future? future;

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
    context.read<ethencity_provider>().ethencity_list();
    context.read<childrenhave_provider>().children_list();
    context.read<children_want_provider>().children_want_list();
    context.read<body_type_provider>().body_type_list();
    context.read<english_provider>().english_list();
    context.read<eye_color_provider>().eye_color_list();
    context.read<hair_color_provider>().hair_color_list();
    Future.delayed(Duration(seconds: 2), () {});
    get_blogdetails(context);
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
      context.read<profile_details_provider>().profile_details_list(user_id);
    });
    print("blodid $user_id");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Opacity(
            opacity: _opacity,
            child: Image.asset('assets/homeheart.png',
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover)),
        editprofile(context),
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
    context.read<ethencity_provider>().ethencity_list();
    context.read<childrenhave_provider>().children_list();
    context.read<children_want_provider>().children_want_list();
    context.read<body_type_provider>().body_type_list();
    context.read<english_provider>().english_list();
    context.read<eye_color_provider>().eye_color_list();
    context.read<hair_color_provider>().hair_color_list();
    context.read<profile_details_provider>().profile_details_list(user_id);

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(35.0), // he,
          child: AppBar(
            centerTitle: true,
            title: Text(
              "Edit Information",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => female_home()));
                  });
                }),
            backgroundColor: Colors.transparent,
            /* title: SizedBox(
            height: 250,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset("assets/pg1.png"),
                ),
                Column(
                  children: [
                    Image.asset("assets/pg2.png"),
                    Image.asset("assets/pg3.png"),
                  ],
                ),
              ],
            ),
          ),*/
            elevation: 0.0,
          ),
        ),
        body: SingleChildScrollView(child: Consumer<profile_details_provider>(
            builder: (context, value, child) {
          fname.text = value.map["data"]["userData"]["fname"] ?? "";
          lname.text = value.map["data"]["userData"]["lname"] ?? "";
          pincode.text = value.map["data"]["userData"]["pincode"] ?? "";
          address.text = value.map["data"]["userData"]["address"] ?? "";
          nickname.text = value.map["data"]["userData"]["user_name"] ?? "";

          print("valuep$value");
          return value.map.length == 0 && !value.error
              ? CircularProgressIndicator()
              : value.error
                  ? Text("Opps SOmething went wrong")
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
                                    Stack(clipBehavior: Clip.none, children: [
                                      value.map["data"]["userData"]
                                                  ["profile_image"] ==
                                              ""
                                          ? SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: imageFile != null
                                                  ? CircleAvatar(
                                                      backgroundImage:
                                                          Image.file(imageFile!)
                                                              .image)
                                                  : Icon(
                                                      Icons.person,
                                                      size: 80,
                                                    ))
                                          : SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: CircleAvatar(
                                                  backgroundImage:
                                                      Image.network(value.map[
                                                                      "data"]
                                                                  ["userData"]
                                                              ["profile_image"])
                                                          .image)),
                                      Positioned(
                                        bottom: -1,
                                        right: 2,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: ShapeDecoration(
                                            shape: CircleBorder(),
                                            color: Color(0xffCC0000),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              _getFromGallery();
                                            },
                                            icon: Icon(
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
                                  "Click on edit button to change photo",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Center(
                                child: Text(
                                  nickname.text,
                                  style: TextStyle(
                                      color: Color(0xffCC0000),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Photo Album",
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: DottedBorder(
                                      //customPath: (size) => customPath, // PathBuilder
                                      color: Colors.grey,
                                      dashPattern: [8, 4],
                                      strokeWidth: 2,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.grey.withAlpha(40),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                getimageslist();
                                              },
                                            ),
                                            Text("Image")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: _controller != null
                                        ?
                                        // Visibility(
                                        //   visible: _controller != null, child:
                                        FutureBuilder(
                                            future:
                                                _initializeVideoPlayerFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                // If the VideoPlayerController has finished initialization, use
                                                // the data it provides to limit the aspect ratio of the video.
                                                return Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Stack(children: [
                                                    VideoPlayer(_controller!),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: _controller == null
                                                          ? null
                                                          : FloatingActionButton(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              onPressed: () {
                                                                // Wrap the play or pause in a call to `setState`. This ensures the
                                                                // correct icon is shown.
                                                                setState(() {
                                                                  // If the video is playing, pause it.
                                                                  if (_controller!
                                                                      .value
                                                                      .isPlaying) {
                                                                    _controller!
                                                                        .pause();
                                                                  } else {
                                                                    // If the video is paused, play it.
                                                                    _controller!
                                                                        .play();
                                                                  }
                                                                });
                                                              },
                                                              // Display the correct icon depending on the state of the player.
                                                              child: Icon(
                                                                _controller!
                                                                        .value
                                                                        .isPlaying
                                                                    ? Icons
                                                                        .pause
                                                                    : Icons
                                                                        .play_arrow,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              ),
                                                            ),
                                                    ),
                                                    // Icon(Icons.arrow_back),
                                                  ]),
                                                  //
                                                );
                                                //  )
                                                ;
                                              } else {
                                                // If the VideoPlayerController is still initializing, show a
                                                // loading spinner.
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            },
                                          )
                                        : DottedBorder(
                                            //customPath: (size) => customPath, // PathBuilder
                                            color: Colors.grey,
                                            dashPattern: [8, 4],
                                            strokeWidth: 2,
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              color: Colors.grey.withAlpha(40),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: value.map["data"]
                                                                    ["userData"]
                                                                [
                                                                "profile_video"] ==
                                                            ""
                                                        ? Icon(
                                                            Icons.add,
                                                            size: 30,
                                                          )
                                                        : Icon(
                                                            Icons.check,
                                                            size: 32,
                                                            color: Colors.green,
                                                          ),
                                                    onPressed: () {
                                                      getVideo();
                                                    },
                                                  ),
                                                  Text(
                                                    value.map["data"]
                                                                    ["userData"]
                                                                [
                                                                "profile_video"] ==
                                                            ""
                                                        ? "Video"
                                                        : "Video \nUploaded",
                                                    style: TextStyle(
                                                        color: value.map["data"]
                                                                        [
                                                                        "userData"]
                                                                    [
                                                                    "profile_video"] ==
                                                                ""
                                                            ? Colors.black
                                                            : Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
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
                                                  child: Container(
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
                                children: [
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
                                  Text(
                                    "First Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: fname,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Last Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: lname,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "User Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: nickname,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pincode",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: pincode,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: address,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<country_provider>(
                                  builder: (context, value, child) {
                                mycountry = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "country",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
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
                                                      child: new Text(
                                                        item['country'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                      decoration: BoxDecoration(
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
                                        style: TextStyle(color: Colors.black),
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            "state",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        icon: Icon(
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
                                            child: new Text(
                                              item['state'],
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: item['id'].toString(),
                                            // value: item['id'].toString(),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                      decoration: BoxDecoration(
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
                                        style: TextStyle(color: Colors.black),
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            "city",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        icon: Icon(
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
                                            child: new Text(
                                              item['city'],
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: item['id'].toString(),
                                            // value: item['id'].toString(),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<height_provider>(
                                  builder: (context, value, child) {
                                heightmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "height",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
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
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<weight_provider>(
                                  builder: (context, value, child) {
                                weightmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                "Weight",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: weightval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      weightval = newValue;
                                                    });
                                                    print(weightval);
                                                  },
                                                  items: weightmap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<apperance_provider>(
                                  builder: (context, value, child) {
                                nicknamed = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
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
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<ethencity_provider>(
                                  builder: (context, value, child) {
                                ethencitymap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                "Ethencity",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: ethencityval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      ethencityval = newValue;
                                                    });
                                                    print(ethencityval);
                                                  },
                                                  items:
                                                      ethencitymap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<childrenhave_provider>(
                                  builder: (context, value, child) {
                                childrenhavemap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                "Children have",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: childrenhaveval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      childrenhaveval =
                                                          newValue;
                                                    });
                                                    print(childrenhaveval);
                                                  },
                                                  items: childrenhavemap
                                                      .map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<children_want_provider>(
                                  builder: (context, value, child) {
                                childrenwantmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                "Children want",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: childrenwantval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      childrenwantval =
                                                          newValue;
                                                    });
                                                    print(childrenwantval);
                                                  },
                                                  items: childrenwantmap
                                                      .map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<body_type_provider>(
                                  builder: (context, value, child) {
                                bodytypemap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                "Body Type",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: bodytypeval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      bodytypeval = newValue;
                                                    });
                                                    print(bodytypeval);
                                                  },
                                                  items:
                                                      bodytypemap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<english_provider>(
                                  builder: (context, value, child) {
                                englishmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                "English Ability",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: englishval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      englishval = newValue;
                                                    });
                                                    print(englishval);
                                                  },
                                                  items: englishmap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<eye_color_provider>(
                                  builder: (context, value, child) {
                                eyecolormap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                "Eye Color",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: eyecolorval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      eyecolorval = newValue;
                                                    });
                                                    print(eyecolorval);
                                                  },
                                                  items:
                                                      eyecolormap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<hair_color_provider>(
                                  builder: (context, value, child) {
                                haircolormap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Hair Color",
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    // Add this
                                                    Icons.arrow_forward_ios,
                                                    // Add this
                                                    color: Colors.black,
                                                    size: 12, // Add this
                                                  ),
                                                  value: haircolorval,
                                                  isDense: false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      haircolorval = newValue;
                                                    });
                                                    print(haircolorval);
                                                  },
                                                  items:
                                                      haircolormap.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<drink_provider>(
                                  builder: (context, value, child) {
                                drinkmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
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
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<smoke_provider>(
                                  builder: (context, value, child) {
                                smokemap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
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
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<maritial_provider>(
                                  builder: (context, value, child) {
                                maritialmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
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
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Consumer<education_provider>(
                                  builder: (context, value, child) {
                                educationmap = value.map["data"];
                                return value.map.length == 0 && !value.error
                                    ? CircularProgressIndicator()
                                    : value.error
                                        ? Text("Opps SOmething went wrong")
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
                                                decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Text(
                                                      "Select",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  icon: Icon(
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
                                                      child: new Text(
                                                        item['name'],
                                                        style: TextStyle(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Own Words",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: own_words,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Looking Partner",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: looking_partner,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Relationship Looking For",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    child: TextField(
                                      controller: relationship,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      decoration: InputDecoration(
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
                                  color: Color(0xffCC0000),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (imageFile != null ||
                                        videoFile1 != null) {
                                      circle(context);
                                      print(
                                          "smokeval $imagesfile $imageFile $videoFile1 ${fname.text}");
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
                                          imageFile!,
                                          videoFile1!,
                                          haircolorval != null
                                              ? haircolorval!
                                              : "",
                                          eyecolorval != null
                                              ? eyecolorval!
                                              : "",
                                          heightval != null ? heightval! : "",
                                          weightval != null ? weightval! : "",
                                          bodytypeval != null
                                              ? bodytypeval!
                                              : "",
                                          ethencityval != null
                                              ? ethencityval!
                                              : "",
                                          appreance,
                                          drinkval != null ? drinkval! : "",
                                          smokeval != null ? smokeval! : "",
                                          maritialval != null
                                              ? maritialval!
                                              : "",
                                          childrenhaveval != null
                                              ? childrenhaveval!
                                              : "",
                                          childrenwantval != null
                                              ? childrenwantval!
                                              : "",
                                          "",
                                          relationship.text,
                                          educationval != null
                                              ? educationval!
                                              : "",
                                          englishval != null ? englishval! : "",
                                          "Indian",
                                          "",
                                          own_words.text,
                                          "",
                                          looking_partner.text);
                                    } else if (imagesfile.length == 0) {
                                      Fluttertoast.showToast(
                                          msg: "Please select profile album",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please select profile photo and video",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1);
                                    }
                                  },
                                  child: Text(
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
                      : Center(
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

  Future getVideo() async {
    Future<XFile?> _videoFile = ImagePicker().pickVideo(
        source: ImageSource.gallery, maxDuration: Duration(seconds: 90));
    _videoFile.then((file) async {
      setState(() {
        videoFile1 = File(file!.path);
        _controller = VideoPlayerController.file(videoFile1!);

        // Initialize the controller and store the Future for later use.
        _initializeVideoPlayerFuture = _controller!.initialize();
        // circle(context);
        // Use the controller to loop the video.
        _controller!.setLooping(true);
      });
    });
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
    //  String type,
    File profile_image,
    File profile_video,
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
    String star_sign,
    //List gallery,
    String own_words,
    String little_yourself,
    String looking_partner,
  ) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/updateUserProfile";
    print("stringrequest");
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['first_name'] = first_name;
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
    // request.fields['profile_image'] = profile_image;
    // request.fields['profile_video'] = profile_video;
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
    request.fields['star_sign'] = star_sign;
    //  request.fields['gallery'] = gallery.toString();
    request.fields['own_words'] = own_words;
    request.fields['little_yourself'] = little_yourself;
    request.fields['looking_partner'] = looking_partner;

    request.files.add(
        await http.MultipartFile.fromPath('profile_image', profile_image.path));
    request.files.add(
        await http.MultipartFile.fromPath('profile_video', profile_video.path));

    // List<http.MultipartFile> files = [];
    // for(File file in imagesfile){
    //   var f = await http.MultipartFile.fromPath('gallery',file.path);
    //   files.add(f);
    //   print("filess ${files}");
    // }
    // request.files.addAll(files);
    //  var response = await request.send();
    if (imagesfile.length > 0) {
      for (var i = 0; i < imagesfile.length; i++) {
        request.files.add(http.MultipartFile(
            'gallery[]',
            File(imagesfile[i].path).readAsBytes().asStream(),
            File(imagesfile[i].path).lengthSync(),
            filename: (imagesfile[i].path.split("/").last)));
      }

      // send
      // var response = await request.send();
      request.send().then((response) {
        http.Response.fromStream(response).then((onValue) {
          try {
            Navigator.pop(context);
            print("onValue ${onValue.body}");
            Map mapRes = json.decode(onValue.body);
            var success = mapRes["status"];
            var msg = mapRes["message"];

            if (success == "1") {
              if (response.statusCode == 200) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => female_home()));
              } else {
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "Updated",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);
              }
// listen for response
              response.stream.transform(utf8.decoder).listen((value) {
                print(value);
              });
            }
          } catch (e) {
            print("response$e");
          }
        });
      });
      // http.Response.fromStream(response).then((onValue) {
      //   try {
      //     Navigator.pop(context);
      //     print("onValue${onValue.body}");
      //     Map mapRes = json.decode(onValue.body);
      //     var success = mapRes["status"];
      //     var msg = mapRes["message"];

      //     if (success == "1") {
      //       print("successuser_id$success $msg");
      //     }
      //   } catch (e) {
      //     print("response$e");
      //   }
      // });

      //   print("rescode" + response.statusCode.toString());

    }

    ;
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
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
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
    var request = new http.MultipartRequest("POST", Uri.parse(postUrl));
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
