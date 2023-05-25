import 'dart:async';
import 'dart:io';

import 'package:dapp/login.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../models/models.dart';
import '../providers/auth_provider.dart';
import '../utils/debouncer.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class chat_home_list extends StatefulWidget {
  final type;

  const chat_home_list({Key? key, this.type}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<chat_home_list> {
  HomePageState({Key? key});

  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;
  var user_id;
  late AuthProvider authProvider;
  late String currentUserId;

  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> btnClearController = StreamController<bool>();
  TextEditingController searchBarTec = TextEditingController();

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Log out', icon: Icons.exit_to_app),
  ];

  @override
  @override
  void dispose() {
    super.dispose();
    btnClearController.close();
  }

  // void configLocalNotification() {
  //   AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('logo1');
  //   DarwinInitializationSettings initializationSettingsIOS =
  //       DarwinInitializationSettings();
  //   InitializationSettings initializationSettings = InitializationSettings(
  //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == 'Log out') {
      handleSignOut();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<void> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                color: ColorConstants.themeColor,
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.cancel,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    const Text(
                      'Cancel',
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.check_circle,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    const Text(
                      'Yes',
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }

  Future<void> handleSignOut() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => login()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Message",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        // child: WillPopScope(
        child: Stack(
          children: <Widget>[
            Opacity(
                opacity: 0.9,
                child: Image.asset('assets/homeheart.png',
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.cover)),

            // List
            Column(
              children: [
                buildSearchBar(),
                Expanded(
                  child: Consumer<hostlist_provider>(
                    builder: (context, state, child) {
                      return state.map["data"]["HostList"] != null
                          ? ListView.builder(
                              itemCount: state.map["data"]["HostList"].length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  // TODO: Navigation To Chat Page
                                  onTap: () async {
                                    // SharedPreferences pref =
                                    //     await SharedPreferences.getInstance();
                                    // var getUserID =
                                    //     pref.getString(FirestoreConstants.idTo);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                            arguments: ChatPageArguments(
                                                peerId: state.map["data"]
                                                        ["HostList"][index]
                                                        ["user_id"]
                                                    .toString(),
                                                peerAvatar: state.map["data"]
                                                        ["HostList"][index]
                                                    ["profile_image"],
                                                peerNickname: state.map["data"]
                                                        ["HostList"][index]
                                                    ["name"]),
                                            type: widget.type),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    state.map["data"]["HostList"][index]
                                        ["name"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(state.map["data"]["HostList"]
                                      [index]["last_message"]),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        state.map["data"]["HostList"][index]
                                            ["profile_image"]),
                                  ),
                                  trailing: Text(state.map["data"]["HostList"]
                                          [index]["user_id"]
                                      .toString()),
                                );
                              })
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ],
            ),

            // Loading
            Positioned(
              child: isLoading ? LoadingView() : const SizedBox.shrink(),
            ),
          ],
        ),
        //   onWillPop: null,
        // ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorConstants.greyColor2,
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.search, color: ColorConstants.greyColor, size: 20),
          const SizedBox(width: 5),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchBarTec,
              onChanged: (value) {
                searchDebouncer.run(() {
                  if (value.isNotEmpty) {
                    btnClearController.add(true);
                    setState(() {
                      _textSearch = value;
                    });
                  } else {
                    btnClearController.add(false);
                    setState(() {
                      _textSearch = "";
                    });
                  }
                });
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search nickname (you have to type exactly string)',
                hintStyle:
                    TextStyle(fontSize: 13, color: ColorConstants.greyColor),
              ),
              style: const TextStyle(fontSize: 13),
            ),
          ),
          StreamBuilder<bool>(
              stream: btnClearController.stream,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? GestureDetector(
                        onTap: () {
                          searchBarTec.clear();
                          btnClearController.add(false);
                          setState(() {
                            _textSearch = "";
                          });
                        },
                        child: const Icon(Icons.clear_rounded,
                            color: ColorConstants.greyColor, size: 20))
                    : const SizedBox.shrink();
              }),
        ],
      ),
    );
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
      onSelected: onItemMenuPress,
      itemBuilder: (BuildContext context) {
        return choices.map((PopupChoices choice) {
          return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: ColorConstants.primaryColor,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    choice.title,
                    style: const TextStyle(color: ColorConstants.primaryColor),
                  ),
                ],
              ));
        }).toList();
      },
    );
  }
}
