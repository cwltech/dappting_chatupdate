import 'dart:async';
import 'dart:io';

import 'package:dapp/login.dart';
import 'package:dapp/models/host.list.model.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/firestore_constants.dart';
import '../models/models.dart';
import '../providers/auth_provider.dart';
import '../providers/home_provider.dart';
import '../utils/debouncer.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class chat_home_list extends StatefulWidget {
  final type;

  chat_home_list({Key? key, this.type}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<chat_home_list> {
  HomePageState({Key? key});

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;
  var user_id;
  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;
  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> btnClearController = StreamController<bool>();
  TextEditingController searchBarTec = TextEditingController();

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Log out', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();

    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => login()),
      //   (Route<dynamic> route) => false,
      // );
    }
    registerNotification();
    //configLocalNotification();
    listScrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    btnClearController.close();
  }

  void registerNotification() {
    firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      if (message.notification != null) {
        showNotification(message.notification!);
      }
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('push token: $token');
      if (token != null) {
        homeProvider.updateDataFirestore(
            widget.type == "user"
                ? FirestoreConstants.pathUservendorCollection
                : FirestoreConstants.pathUserCollection,
            currentUserId,
            {'pushToken': token});
      }
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
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

  void showNotification(RemoteNotification remoteNotification) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Platform.isAndroid ? 'com.coder.hookup' : '',
      'Flutter chat demo',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    print(remoteNotification);

    await flutterLocalNotificationsPlugin.show(
      0,
      remoteNotification.title,
      remoteNotification.body,
      platformChannelSpecifics,
      payload: null,
    );
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
    // authProvider.handleSignOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => login()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = context.read<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Message",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        // centerTitle: true,
        // actions: <Widget>[buildPopupMenu()],
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
                                  // TODO : Navigation To Chat Page
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                          chatUserListModel: ChatUserListModel(
                                            data: Data(
                                              hostList: <HostList>[
                                                state.map["data"]["HostList"]
                                                    ["user_id"]
                                              ],
                                            ),
                                          ),
                                          type: widget.type,
                                        ),
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
                // Expanded(
                //   child: StreamBuilder<QuerySnapshot>(
                //     stream: homeProvider.getStreamFireStore(
                //         widget.type == "user"
                //             ? FirestoreConstants.pathUservendorCollection
                //             : FirestoreConstants.pathUserCollection,
                //         _limit,
                //         _textSearch),
                //     builder: (BuildContext context,
                //         AsyncSnapshot<QuerySnapshot> snapshot) {
                //       if (snapshot.hasData) {
                //         if ((snapshot.data?.docs.length ?? 0) > 0) {
                //           return ListView.builder(
                //             padding: const EdgeInsets.all(10),
                //             itemBuilder: (context, index) =>
                //                 buildItem(context, snapshot.data?.docs[index]),
                //             itemCount: snapshot.data?.docs.length,
                //             controller: listScrollController,
                //           );
                //         } else {
                //           return const Center(
                //             child: Text("No users"),
                //           );
                //         }
                //       } else {
                //         return const Center(
                //           child: CircularProgressIndicator(
                //             color: ColorConstants.themeColor,
                //           ),
                //         );
                //       }
                //     },
                //   ),
                // ),
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

// Widget chatMessageItme(BuildContext context, snapshot){
//   if(snapshot!=null){
//     ChatUserListModel chatUserListModel = ChatUserListModel.fromJson(snapshot);
//     if(chatUserListModel.data?.hostList?.first.userId !=null){
//       return const SizedBox.shrink();
//     }else{return Container(
//       color: Colors.amber,
//       margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
//       child: TextButton(
//         onPressed: () {
//           if (Utilities.isKeyboardShowing()) {
//             Utilities.closeKeyboard(context);
//           }
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChatPage(
//                 arguments: ChatPageArguments(
//                   peerId: chatUserListModel.data!.hostList!.first.userId.toString(),
//                   peerAvatar: chatUserListModel.data!.hostList!.first.profileImage.toString(),
//
//                 ),
//                 type: widget.type,
//               ),
//             ),
//           );
//         },
//         style: ButtonStyle(
//           //backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.greyColor2),
//           shape: MaterialStateProperty.all<OutlinedBorder>(
//             const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//         ),
//         child: Row(
//           children: <Widget>[
//             Material(
//               borderRadius: const BorderRadius.all(Radius.circular(25)),
//               clipBehavior: Clip.hardEdge,
//               child: userChat.photoUrl.isNotEmpty
//                   ? Image.network(
//                 userChat.photoUrl,
//                 fit: BoxFit.cover,
//                 width: 50,
//                 height: 50,
//                 loadingBuilder: (BuildContext context, Widget child,
//                     ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Container(
//                     width: 50,
//                     height: 50,
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         color: ColorConstants.themeColor,
//                         value: loadingProgress.expectedTotalBytes !=
//                             null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                             loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     ),
//                   );
//                 },
//                 errorBuilder: (context, object, stackTrace) {
//                   return const Icon(
//                     Icons.account_circle,
//                     size: 50,
//                     color: ColorConstants.greyColor,
//                   );
//                 },
//               )
//                   : const Icon(
//                 Icons.account_circle,
//                 size: 50,
//                 color: ColorConstants.greyColor,
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );}
//   }
// }
// Widget buildItem(BuildContext context, DocumentSnapshot? document) {
//   if (document != null) {
//     UserChat userChat = UserChat.fromDocument(document);
//     if (userChat.id == currentUserId) {
//       return const SizedBox.shrink();
//     } else {
//       return Container(
//         color: Colors.amber,
//         margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
//         child: TextButton(
//           onPressed: () {
//             if (Utilities.isKeyboardShowing()) {
//               Utilities.closeKeyboard(context);
//             }
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ChatPage(
//                   arguments: ChatPageArguments(
//                     peerId: userChat.id,
//                     peerAvatar: userChat.photoUrl,
//                     // peerNickname: userChat.nickname,
//                   ),
//                   type: widget.type,
//                 ),
//               ),
//             );
//           },
//           style: ButtonStyle(
//             //backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.greyColor2),
//             shape: MaterialStateProperty.all<OutlinedBorder>(
//               const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Material(
//                 borderRadius: const BorderRadius.all(Radius.circular(25)),
//                 clipBehavior: Clip.hardEdge,
//                 child: userChat.photoUrl.isNotEmpty
//                     ? Image.network(
//                         userChat.photoUrl,
//                         fit: BoxFit.cover,
//                         width: 50,
//                         height: 50,
//                         loadingBuilder: (BuildContext context, Widget child,
//                             ImageChunkEvent? loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Container(
//                             width: 50,
//                             height: 50,
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 color: ColorConstants.themeColor,
//                                 value: loadingProgress.expectedTotalBytes !=
//                                         null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes!
//                                     : null,
//                               ),
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, object, stackTrace) {
//                           return const Icon(
//                             Icons.account_circle,
//                             size: 50,
//                             color: ColorConstants.greyColor,
//                           );
//                         },
//                       )
//                     : const Icon(
//                         Icons.account_circle,
//                         size: 50,
//                         color: ColorConstants.greyColor,
//                       ),
//               ),
//               Flexible(
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 20),
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         margin: const EdgeInsets.fromLTRB(10, 0, 0, 5),
//                         child: Text(
//                           'Nickname: ${userChat.nickname}',
//                           maxLines: 1,
//                           style: const TextStyle(
//                               color: ColorConstants.primaryColor),
//                         ),
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         child: Text(
//                           'About me: ${userChat.aboutMe}',
//                           maxLines: 1,
//                           style: const TextStyle(
//                               color: ColorConstants.primaryColor),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   } else {
//     return const SizedBox.shrink();
//   }
// }
}
